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

import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;

public class TypesGenerator {
    private final GenerationContext context;
    private final RubySettings settings;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final SymbolProvider symbolProvider;

    public TypesGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(context.getModel(), settings, "Types", false);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types")
                .write("")
                .call(() -> renderTypes(new TypesVisitor(writer, symbolProvider)))
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/types.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    public void renderRbs() {
        FileManifest fileManifest = context.getFileManifest();

        rbsWriter
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types")
                .write("")
                .call(() -> renderTypes(new TypesRbsVisitor(rbsWriter, symbolProvider)))
                .closeBlock("end")
                .closeBlock("end");

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/types.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
    }

    private void renderTypes(ShapeVisitor visitor) {
        Model modelWithoutTraitShapes = ModelTransformer.create()
                .getModelWithoutTraitShapes(context.getModel());

        Set<Shape> serviceShapes = new TreeSet<>(
                new Walker(modelWithoutTraitShapes)
                        .walkShapes(context.getService()));

        for (Shape shape : serviceShapes) {
            shape.accept(visitor);
        }
    }

    private static class TypesVisitor extends ShapeVisitor.Default<Void> {
        private final RubyCodeWriter writer;
        private final SymbolProvider symbolProvider;

        TypesVisitor(RubyCodeWriter writer, SymbolProvider symbolProvider) {
            this.writer = writer;
            this.symbolProvider = symbolProvider;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            Symbol symbol = symbolProvider.toSymbol(shape);
            String shapeName = symbol.getName();
            String membersBlock = "nil";

            if (!shape.members().isEmpty()) {
                membersBlock = shape
                        .members()
                        .stream()
                        .map(memberShape -> RubyFormatter.asSymbol(symbolProvider.toMemberName(memberShape)))
                        .collect(Collectors.joining(",\n"));
            }
            membersBlock += ",";

            writer
                    .openBlock(shapeName + " = Struct.new(")
                    .write(membersBlock)
                    .write("keyword_init: true")
                    .closeBlock(") { include Seahorse::Structure }")
                    .write("");

            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            Symbol symbol = symbolProvider.toSymbol(shape);
            String shapeName = symbol.getName();

            writer.openBlock("class $L < Seahorse::Union", shapeName);

            for (MemberShape memberShape : shape.members()) {
                writer
                        .openBlock("class $L < $L", symbolProvider.toMemberName(memberShape), shapeName)
                        .openBlock("def to_h")
                        .write("{ $L: super(__getobj__) }",
                                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)))
                        .closeBlock("end")
                        .closeBlock("end");
            }

            writer
                    .openBlock("class Unknown < $L", shapeName)
                    .openBlock("def to_h")
                    .write("{ unknown: super(__getobj__) }")
                    .closeBlock("end")
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
        }
    }

    private static class TypesRbsVisitor extends ShapeVisitor.Default<Void> {
        private final RubyCodeWriter rbsWriter;
        private final SymbolProvider symbolProvider;

        TypesRbsVisitor(RubyCodeWriter rbsWriter, SymbolProvider symbolProvider) {
            this.rbsWriter = rbsWriter;
            this.symbolProvider = symbolProvider;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            Symbol symbol = symbolProvider.toSymbol(shape);
            String shapeName = symbol.getName();

            rbsWriter.write(shapeName + ": untyped\n");
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            Symbol symbol = symbolProvider.toSymbol(shape);
            String shapeName = symbol.getName();

            rbsWriter.openBlock("class $L < Seahorse::Union", shapeName);

            for (MemberShape memberShape : shape.members()) {
                rbsWriter
                        .openBlock("class $L < $L", symbolProvider.toMemberName(memberShape), shapeName)
                        .write("def to_h: () -> { $L: Hash[Symbol,$L] }",
                                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)), shapeName)
                        .closeBlock("end\n");
            }

            rbsWriter
                    .openBlock("class Unknown < $L", shapeName)
                    .write("def to_h: () -> { unknown: Hash[Symbol,$L] }", shapeName)
                    .closeBlock("end")
                    .closeBlock("end\n");

            return null;
        }
    }
}
