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

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import java.util.Comparator;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class ErrorsGenerator {

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;

    public ErrorsGenerator(GenerationContext context) {
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.context = context;
        this.writer = new RubyCodeWriter();
    }

    public void render(FileManifest fileManifest) {
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .call(() -> renderErrorCode())
                .call(() -> renderBaseErrors())
                .call(() -> renderServiceModelErrors())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderBaseErrors() {
        writer
                .write("\n# Base class for all errors returned by this service")
                .write("class ApiError < Seahorse::HTTP::ApiError; end");

        writer
                .write("\n# Base class for all errors returned where the client is at fault.")
                .write("# These are generally errors with 4XX HTTP status codes.")
                .write("class ApiClientError < ApiError; end");

        writer
                .write("\n# Base class for all errors returned where the server is at fault.")
                .write("# These are generally errors with 5XX HTTP status codes.")
                .write("class ApiServerError < ApiError; end");

        writer
                .write("# Base class for all errors returned where the service returned")
                .write("# a 3XX redirection.")
                .openBlock("class ApiRedirectError < ApiError")
                .openBlock("def initialize(location:, **kwargs)")
                .write("@location = location")
                .write("super(kwargs)")
                .closeBlock("end\n")
                .write("# @return [String] location")
                .write("attr_reader :location")
                .closeBlock("end\n");
    }

    private void renderErrorCode() {
        writer
                .write("# Given an http_resp, return the error code")
                .openBlock("def self.error_code(http_resp)")
                .write("http_resp.headers['x-smithy-error']")
                .closeBlock("end");
    }


    private void renderServiceModelErrors() {
        Stream<Shape> shapes = model.shapes().filter((s) -> s.hasTrait(ErrorTrait.class));

        shapes.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(error -> {
            String errorName = error.getId().getName();
            // assumes shapes are all filtered by error traits already
            ErrorTrait errorTrait = error.getTrait(ErrorTrait.class).get();
            String apiErrorType = getApiErrorType(errorTrait);

            renderServiceModelError(errorName, apiErrorType);
        });
    }

    private void renderServiceModelError(String errorName, String apiErrorType) {
        writer
                .openBlock("class $L < $L", errorName, apiErrorType)
                .openBlock("def initialize(http_resp:, **kwargs)")
                .write("@data = Parsers::$L.parse(http_resp)", errorName)
                .write("kwargs[:message] = @data.message if @data.respond_to?(:message)\n")
                .write("super(http_resp: http_resp, **kwargs)")
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
