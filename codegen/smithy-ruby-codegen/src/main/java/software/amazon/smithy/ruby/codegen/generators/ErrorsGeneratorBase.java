/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen.generators;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;

public abstract class ErrorsGeneratorBase {

    protected final GenerationContext context;
    protected final RubySettings settings;
    protected final Model model;
    protected final RubyCodeWriter writer;
    protected final RubyCodeWriter rbsWriter;
    protected final SymbolProvider symbolProvider;

    public ErrorsGeneratorBase(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Errors", true);
    }

    public void render(FileManifest fileManifest) {
        rbsWriter
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors");

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .write("")
                .call(() -> renderErrorCode())
                .call(() -> renderBaseErrors())
                .call(() -> renderServiceModelErrors())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        rbsWriter
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName() + "/errors.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
    }

    private void renderBaseErrors() {
        writer
                .write("\n# Base class for all errors returned by this service")
                .write("class ApiError < Seahorse::HTTP::ApiError; end");

        rbsWriter
                .write("\n# Base class for all errors returned by this service")
                .write("class ApiError < Seahorse::HTTP::ApiError")
                .write("end");

        writer
                .write("\n# Base class for all errors returned where the client is at fault.")
                .write("# These are generally errors with 4XX HTTP status codes.")
                .write("class ApiClientError < ApiError; end");

        rbsWriter
                .write("\n# Base class for all errors returned where the client is at fault.")
                .write("# These are generally errors with 4XX HTTP status codes.")
                .write("class ApiClientError < ApiError")
                .write("end");

        writer
                .write("\n# Base class for all errors returned where the server is at fault.")
                .write("# These are generally errors with 5XX HTTP status codes.")
                .write("class ApiServerError < ApiError; end");

        rbsWriter
                .write("\n# Base class for all errors returned where the server is at fault.")
                .write("# These are generally errors with 5XX HTTP status codes.")
                .write("class ApiServerError < ApiError")
                .write("end");

        writer
                .write("\n# Base class for all errors returned where the service returned")
                .write("# a 3XX redirection.")
                .openBlock("class ApiRedirectError < ApiError")
                .openBlock("def initialize(location:, **kwargs)")
                .write("@location = location")
                .write("super(**kwargs)")
                .closeBlock("end")
                .write("")
                .write("# @return [String] location")
                .write("attr_reader :location")
                .closeBlock("end");

        rbsWriter
                .write("\n# Base class for all errors returned where the service returned")
                .write("# a 3XX redirection.")
                .openBlock("class ApiRedirectError < ApiError")
                .openBlock("def initialize: (location: untyped location, **untyped kwargs) -> void")
                .write("")
                .write("# @return [String] location")
                .write("attr_reader location: untyped")
                .closeBlock("end");
    }

    public abstract void renderErrorCode();

    private void renderServiceModelErrors() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        Set<Shape> generatedErrors =
                topDownIndex.getContainedOperations(context.getService()).stream()
                        .map(OperationShape::getErrors)
                        .flatMap(Collection::stream)
                        .map(model::expectShape)
                        .collect(Collectors.toSet());

        generatedErrors.forEach(error -> {
            String errorName = symbolProvider.toSymbol(error).getName();
            ErrorTrait errorTrait = error.getTrait(ErrorTrait.class).get();
            String apiErrorType = getApiErrorType(errorTrait);

            renderServiceModelError(errorName, apiErrorType);
        });
    }

    private void renderServiceModelError(String errorName, String apiErrorType) {
        writer
                .write("")
                .openBlock("class $L < $L", errorName, apiErrorType)
                .openBlock("def initialize(http_resp:, **kwargs)")
                .write("@data = Parsers::$L.parse(http_resp)", errorName)
                .write("kwargs[:message] = @data.message if @data.respond_to?(:message)\n")
                .write("super(http_resp: http_resp, **kwargs)")
                .closeBlock("end")
                .write("")
                .write("attr_reader :data")
                .closeBlock("end");

        rbsWriter
                .write("")
                .openBlock("class $L < $L", errorName, apiErrorType)
                .write("def initialize: (http_resp: untyped http_resp, **untyped kwargs) -> void\n")
                .write("")
                .write("attr_reader data: untyped")
                .closeBlock("end");
    }

    private String getApiErrorType(ErrorTrait errorTrait) {
        String apiErrorType;

        if (errorTrait.isClientError()) {
            apiErrorType = "ApiClientError";
        } else if (errorTrait.isServerError()) {
            apiErrorType = "ApiServerError";
        } else {
            // This should not happen but it's a safe fallback
            apiErrorType = "Seahorse::ApiError";
        }

        return apiErrorType;
    }
}

