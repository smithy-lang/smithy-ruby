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

import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
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
        CodeWriter writer = CodeWriter.createDefault();

        writer.write("require 'seahorse'");

        writer.openBlock("module $L", settings.getModule())
                .openBlock("module Errors");

        writer.write("extend Seahorse::Model::Errors::DynamicErrors");

        shapes.forEach(error -> {
            String name = error.getId().getName();

            writer
                    .openBlock("class $L < ServiceError", name)
                    .openBlock("def initialize(context, message, data = Seahorse::Model::EmptyStructure.new)")
                    .write("super(context, message, data)")
                    .closeBlock("end");

            error.members().forEach(member -> {
                String snakeCaseMemberName = RubyFormatter.toSnakeCase(member.getMemberName());
                writer.openBlock("def $L", snakeCaseMemberName);
                String function = "";
                // "shared" in the current generator
                if (snakeCaseMemberName.equals("message") || snakeCaseMemberName.equals("code")) {
                    function = "@message || ";
                }
                function += "@data[:" + snakeCaseMemberName + "]";
                writer.write(function)
                        .closeBlock("end");
            });

            writer.closeBlock("end");
        });

        writer.closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }
}
