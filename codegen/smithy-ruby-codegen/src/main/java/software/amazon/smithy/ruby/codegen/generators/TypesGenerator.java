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
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class TypesGenerator {
    private final RubySettings settings;
    private final Stream<StructureShape> shapes;

    public TypesGenerator(RubySettings settings, Stream<StructureShape> shapes) {
        this.settings = settings;
        this.shapes = shapes;
    }

    public void render(FileManifest fileManifest) {
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types")
                .call(() -> renderTypes(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/types.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderTypes(RubyCodeWriter writer) {
        shapes.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(structureShape -> {
            // errors are not types
            if (!structureShape.hasTrait(ErrorTrait.class)) {
                renderType(writer, structureShape);
            }
        });
    }

    private void renderType(RubyCodeWriter writer, StructureShape structureShape) {
        String shapeName = structureShape.getId().getName();
        String membersBlock;

        if (structureShape.members().isEmpty()) {
            membersBlock = "nil";
        } else {
            membersBlock = structureShape
                    .members()
                    .stream()
                    .map(memberShape -> RubyFormatter.asSymbol(memberShape.getMemberName()))
                    .collect(Collectors.joining(",\n"));
        }
        membersBlock += ",";

        writer
                .openBlock(shapeName + " = Struct.new(")
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(")");
    }
}
