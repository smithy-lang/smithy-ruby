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

import java.util.ArrayList;
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

        writer.openBlock("module $L", settings.getModule())
                .openBlock("module Errors");

        writer.openBlock("class ApiRedirectError < Seahorse::ApiError");
        writer.openBlock("def initialize(location:, **api_error_options)")
                .write("@location = location")
                .write("super(api_error_options)")
                .closeBlock("end\n");
        writer.write("attr_reader :location");
        writer.closeBlock("end\n");

        writer.write("class ApiClientError < ApiError; end\n")
                .write("class ApiServerError < ApiError; end\n");

        ArrayList<String> errors = new ArrayList<String>();

        shapes.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(error -> {
            String name = error.getId().getName();
            errors.add(name);
            String traitValue = error.getTrait(ErrorTrait.class).get().getValue();
            String apiErrorType;
            if (traitValue.equals("server")) {
                apiErrorType = "ApiServerError";
            } else {
                apiErrorType = "ApiClientError";
            }

            writer.openBlock("class $L < $L", name, apiErrorType);

            writer.openBlock("def initialize(**args)")
                    .write("super(error_code: '$L', **args)", name)
                    .write("@data = Parsers::$L.new.parse(http_body)", name)
                    .closeBlock("end\n");

            writer.write("attr_reader :data");

            writer.closeBlock("end\n");
        });

        writer.openBlock("ERROR_CODES = {");
        for (String errorName: errors) {
            writer.write("'$L' => $L,", errorName, errorName);
        }
        writer.closeBlock("}.freeze");

        writer.closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }
}
