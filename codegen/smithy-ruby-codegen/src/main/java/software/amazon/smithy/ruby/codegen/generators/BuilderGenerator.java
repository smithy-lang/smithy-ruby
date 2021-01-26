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

import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class BuilderGenerator {

    private final RubySettings settings;
    private final Stream<Shape> shapes;

    public BuilderGenerator(RubySettings settings, Stream<Shape> shapes) {
        this.settings = settings;
        this.shapes = shapes;
    }

    public void render(FileManifest fileManifest) {
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Builders")
                .call(() -> renderBuilders(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/builders.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    public void renderBuilders(RubyCodeWriter writer) {
        shapes.forEach(shape -> {
            renderBuilder(writer, shape);
            writer.write("");
        });
    }

    public void renderBuilder(RubyCodeWriter writer, Shape shape) {
        writer
                .openBlock("class $L", shape.getId().getName())
                .call(() -> renderPermittedValues(writer, shape))
                .write("")
                .call(() -> renderBuilderMethod(writer, shape))
                .closeBlock("end");
    }

    public void renderPermittedValues(RubyCodeWriter writer, Shape shape) {
        String membersBlock = shape.members()
                .stream()
                .map(memberShape -> RubyFormatter.asSymbol(memberShape.getMemberName()))
                .collect(Collectors.joining(" "));

        writer
                .openBlock("PERMIT = Set.new(%i[")
                .write(membersBlock)
                .closeBlock("])");
    }

    public void renderBuilderMethod(RubyCodeWriter writer, Shape shape) {
        String methodSignature;
        if (shape.isOperationShape()) {
            methodSignature = "def self.build(http_req:, params:)";
        } else {
            methodSignature = "def self.build(params:)";
        }
        writer
                .openBlock(methodSignature)
                .write("params = Seahorse::Params.hash_value(params, permit: PERMIT)")
                .write("# TODO")
                .closeBlock("end");

    }
}
