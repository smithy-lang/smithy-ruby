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

import java.util.Comparator;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.CodeWriter;

public class ErrorsGenerator {

    private final RubySettings settings;
    private final Stream<Shape> shapes;

    public ErrorsGenerator(RubySettings settings, Stream<Shape> shapes) {
        this.settings = settings;
        this.shapes = shapes;
    }

    public void render(FileManifest fileManifest) {
        CodeWriter writer = RubyCodeWriter.createDefault();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .call(() -> renderApiRedirectError(writer))
                .call(() -> renderClientError(writer))
                .call(() -> renderServerError(writer))
                .call(() -> renderServiceModelErrors(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderApiRedirectError(CodeWriter writer) {
        writer
                .write("# Base class for all errors returned where the service returned")
                .write("# a 3XX redirection.")
                .openBlock("class ApiRedirectError < Seahorse::ApiError")
                .openBlock("def initialize(location:, **api_error_options)")
                .write("@location = location")
                .write("super(api_error_options)")
                .closeBlock("end\n")
                .write("# @return [String] location")
                .write("attr_reader :location")
                .closeBlock("end\n");
    }

    private void renderClientError(CodeWriter writer) {
        writer
                .write("# Base class for all errors returned where the client is at fault.")
                .write("# These are generally errors with 4XX HTTP status codes.")
                .write("class ApiClientError < Seahorse::ApiError; end\n");
    }

    private void renderServerError(CodeWriter writer) {
        writer
                .write("# Base class for all errors returned where the server is at fault.")
                .write("# These are generally errors with 5XX HTTP status codes.")
                .write("class ApiServerError < Seahorse::ApiError; end\n");
    }

    private void renderServiceModelErrors(CodeWriter writer) {
        shapes.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(error -> {
            String errorName = error.getId().getName();
            // assumes shapes are all filtered by error traits already
            ErrorTrait errorTrait = error.getTrait(ErrorTrait.class).get();
            String apiErrorType = getApiErrorType(errorTrait);

            renderServiceModelError(writer, errorName, apiErrorType);
        });
    }

    private void renderServiceModelError(CodeWriter writer, String errorName, String apiErrorType) {
        writer
                .openBlock("class $L < $L", errorName, apiErrorType)
                .openBlock("def initialize(**args)")
                .write("super(error_code: '$L', **args)", errorName)
                .write("@data = Parsers::$L.parse(http_body)", errorName)
                .closeBlock("end\n");

        writer.write("attr_reader :data");

        writer.closeBlock("end\n");
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
