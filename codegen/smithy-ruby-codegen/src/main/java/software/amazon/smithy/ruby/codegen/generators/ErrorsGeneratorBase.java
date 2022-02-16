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
import java.util.Comparator;
import java.util.Set;
import java.util.logging.Logger;
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
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * ErrorGeneratorBase that protocol generators can extend to get
 * common functionality.
 * <p>
 * Generates the framework and non-protocol specific parts of the
 * errors.rb.
 */
@SmithyUnstableApi
public abstract class ErrorsGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(ErrorsGeneratorBase.class.getName());

    protected final GenerationContext context;
    protected final RubySettings settings;
    protected final Model model;
    protected final RubyCodeWriter writer;
    protected final RubyCodeWriter rbsWriter;
    protected final SymbolProvider symbolProvider;
    protected final Set<Shape> errorShapes;

    public ErrorsGeneratorBase(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Errors", true);
        this.errorShapes = getErrorShapes();
    }

    public void render(FileManifest fileManifest) {
        writer
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .write("")
                .call(() -> renderErrorCode())
                .call(() -> renderBaseErrors())
                .call(() -> renderServiceModelErrors())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.info("Wrote errors to " + fileName);
    }

    public void renderRbs(FileManifest fileManifest) {
        rbsWriter
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .write("")
                .call(() -> renderRbsErrorCode())
                .call(() -> renderRbsBaseErrors())
                .call(() -> renderRbsServiceModelErrors())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName() + "/errors.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
        LOGGER.info("Wrote errors rbs to " + typesFile);
    }

    private void renderBaseErrors() {
        writer
                .write("\n# Base class for all errors returned by this service")
                .write("class ApiError < Hearth::HTTP::ApiError; end")
                .write("\n# Base class for all errors returned where the client is at fault.")
                .write("# These are generally errors with 4XX HTTP status codes.")
                .write("class ApiClientError < ApiError; end")
                .write("\n# Base class for all errors returned where the server is at fault.")
                .write("# These are generally errors with 5XX HTTP status codes.")
                .write("class ApiServerError < ApiError; end")
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
        LOGGER.fine("Generated base errors");
    }

    private void renderRbsBaseErrors() {
        rbsWriter
                .write("\nclass ApiError < Hearth::HTTP::ApiError")
                .write("end")
                .write("\nclass ApiClientError < ApiError")
                .write("end")
                .write("\nclass ApiServerError < ApiError")
                .write("end")
                .openBlock("\nclass ApiRedirectError < ApiError")
                .write("def initialize: (location: untyped location, **untyped kwargs) -> void\n")
                .write("attr_reader location: untyped")
                .closeBlock("end");
    }

    /**
     * Called to render the error_code method.
     * <p>
     * errors.rb must define a self.error_code(resp) method which will
     * return the protocol specific error code from the response or nil
     * if no error code is found.
     */
    public abstract void renderErrorCode();

    public void renderRbsErrorCode() {
        rbsWriter.write("def self.error_code: (untyped http_resp) -> untyped");
    }

    private Set<Shape> getErrorShapes() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        return topDownIndex.getContainedOperations(context.getService()).stream()
                .map(OperationShape::getErrors)
                .flatMap(Collection::stream)
                .map(model::expectShape)
                .collect(Collectors.toSet());
    }

    private void renderServiceModelErrors() {
        errorShapes
                .stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(error -> {
                    String errorName = symbolProvider.toSymbol(error).getName();
                    ErrorTrait errorTrait = error.getTrait(ErrorTrait.class).get();
                    String apiErrorType = getApiErrorType(errorTrait);

                    renderServiceModelError(errorName, apiErrorType);
                });
    }

    private void renderRbsServiceModelErrors() {
        errorShapes
                .stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(error -> {
                    String errorName = symbolProvider.toSymbol(error).getName();
                    ErrorTrait errorTrait = error.getTrait(ErrorTrait.class).get();
                    String apiErrorType = getApiErrorType(errorTrait);

                    renderRbsServiceModelError(errorName, apiErrorType);
                });
    }

    private void renderServiceModelError(String errorName, String apiErrorType) {
        writer
                .write("")
                .openBlock("class $L < $L", errorName, apiErrorType);

        writer
                .writeYardParam("Hearth::HTTP::Response", "http_resp", "")
                .writeYardParam("String", "error_code", "")
                .writeYardParam("String", "message", "");

        writer
                .openBlock("def initialize(http_resp:, **kwargs)")
                .write("@data = Parsers::$L.parse(http_resp)", errorName)
                .write("kwargs[:message] = @data.message if @data.respond_to?(:message)\n")
                .write("super(http_resp: http_resp, **kwargs)")
                .closeBlock("end")
                .write("");

        writer
                .writeYardReturn("Types::" + errorName, "")
                .write("attr_reader :data")
                .closeBlock("end");

        LOGGER.finest("Generated service model error: " + errorName + " type: " + apiErrorType);
    }

    private void renderRbsServiceModelError(String errorName, String apiErrorType) {
        rbsWriter
                .write("")
                .openBlock("class $L < $L", errorName, apiErrorType)
                .write("def initialize: (http_resp: untyped http_resp, **untyped kwargs) -> void\n")
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
            apiErrorType = "Hearth::ApiError";
        }

        return apiErrorType;
    }
}

