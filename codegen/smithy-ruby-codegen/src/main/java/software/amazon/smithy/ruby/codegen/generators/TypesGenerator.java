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
import java.util.logging.Logger;
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
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;

public class TypesGenerator {

    private static final Logger LOGGER =
            Logger.getLogger(TypesGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final SymbolProvider symbolProvider;

    public TypesGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Types", false);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();

        writer
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types")
                .write("")
                .call(() -> renderTypes(new TypesVisitor()))
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/types.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote types to " + fileName);
    }

    public void renderRbs() {
        FileManifest fileManifest = context.getFileManifest();

        rbsWriter
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types")
                .write("")
                .call(() -> renderTypes(new TypesRbsVisitor()))
                .closeBlock("end")
                .closeBlock("end");

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/types.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
        LOGGER.fine("Wrote types rbs to " + typesFile);
    }

    private void renderTypes(ShapeVisitor<Void> visitor) {
        Model modelWithoutTraitShapes = ModelTransformer.create()
                .getModelWithoutTraitShapes(model);

        Set<Shape> shapes = new TreeSet<>(
                new Walker(modelWithoutTraitShapes)
                        .walkShapes(context.getService()));

        for (Shape shape : shapes) {
            shape.accept(visitor);
        }
    }

    private class TypesVisitor extends ShapeVisitor.Default<Void> {
        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String shapeName = symbolProvider.toSymbol(shape).getName();

            String membersBlock = "nil";
            if (!shape.members().isEmpty()) {
                membersBlock = shape
                        .members()
                        .stream()
                        .map(memberShape -> RubyFormatter.asSymbol(symbolProvider.toMemberName(memberShape)))
                        .collect(Collectors.joining(",\n"));
            }
            membersBlock += ",";

            String documentation = new ShapeDocumentationGenerator(model, symbolProvider, shape).render();

            writer.writeInline(documentation);

            shape.members().forEach(memberShape -> {
                String attribute = symbolProvider.toMemberName(memberShape);
                Shape target = model.expectShape(memberShape.getTarget());
                String returnType = (String) symbolProvider.toSymbol(target)
                        .getProperty("yardType").orElseThrow(IllegalArgumentException::new);

                String memberDocumentation =
                        new ShapeDocumentationGenerator(model, symbolProvider, memberShape).render();

                writer.writeYardAttribute(attribute, () -> {
                    // delegate to member shape in this visitor
                    writer.writeInline(memberDocumentation);
                    writer.writeYardReturn(returnType, "");
                });
            });

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
            String documentation = new ShapeDocumentationGenerator(model, symbolProvider, shape).render();
            String shapeName = symbolProvider.toSymbol(shape).getName();

            writer.writeInline(documentation);
            writer.openBlock("class $L < Seahorse::Union", shapeName);

            for (MemberShape memberShape : shape.members()) {
                String memberDocumentation =
                        new ShapeDocumentationGenerator(model, symbolProvider, memberShape).render();

                writer
                        .writeInline(memberDocumentation)
                        .openBlock("class $L < $L", symbolProvider.toMemberName(memberShape), shapeName)
                        .openBlock("def to_h")
                        .write("{ $L: super(__getobj__) }",
                                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)))
                        .closeBlock("end")
                        .closeBlock("end\n");
            }

            writer
                    .writeDocstring("Handles unknown future members")
                    .openBlock("class Unknown < $L", shapeName)
                    .openBlock("def to_h")
                    .write("{ unknown: super(__getobj__) }")
                    .closeBlock("end")
                    .closeBlock("end")
                    .closeBlock("end\n");

            return null;
        }
    }

    private class TypesRbsVisitor extends ShapeVisitor.Default<Void> {
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
