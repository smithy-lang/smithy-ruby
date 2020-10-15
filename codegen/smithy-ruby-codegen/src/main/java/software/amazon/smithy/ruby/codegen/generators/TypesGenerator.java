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
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.CodeWriter;

public class TypesGenerator {
    private final RubySettings settings;
    private final Stream<StructureShape> shapes;

    public TypesGenerator(RubySettings settings, Stream<StructureShape> shapes) {
        this.settings = settings;
        this.shapes = shapes;
    }

    public void render(FileManifest fileManifest) {
        CodeWriter writer = RubyCodeWriter.createDefault();
        writer.openBlock("module $L", settings.getModule())
                .openBlock("module Types");

        shapes.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(structureShape -> {
            String className = structureShape.getId().getName();

            if (structureShape.members().isEmpty()) {
                writer.write(className + " < Seahorse::Model::EmptyStructure; end");
            } else {
                String membersBlock = structureShape.members()
                        .stream()
                        .map(memberShape -> RubyFormatter.asSymbol(memberShape.getMemberName()))
                        .collect(Collectors.joining(",\n"));
                writer.openBlock(className + " = Struct.new(")
                        .write(membersBlock)
                        .closeBlock(") do")
                        .indent()
                        .write("include Seahorse::StructAddons")
                        .dedent()
                        .write("end");
            }
            writer.write("");
        });

        writer.closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/types.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }
}
