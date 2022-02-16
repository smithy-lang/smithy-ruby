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
import java.util.Iterator;
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
import software.amazon.smithy.model.traits.SensitiveTrait;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
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

        new Walker(modelWithoutTraitShapes)
                .walkShapes(context.getService())
                .stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach((shape) -> shape.accept(visitor));
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

            writer.writeInline("$L", documentation);

            shape.members().forEach(memberShape -> {
                String attribute = symbolProvider.toMemberName(memberShape);
                Shape target = model.expectShape(memberShape.getTarget());
                String returnType = (String) symbolProvider.toSymbol(target)
                        .getProperty("yardType").orElseThrow(IllegalArgumentException::new);

                String memberDocumentation =
                        new ShapeDocumentationGenerator(model, symbolProvider, memberShape).render();

                writer.writeYardAttribute(attribute, () -> {
                    // delegate to member shape in this visitor
                    writer.writeInline("$L", memberDocumentation);
                    writer.writeYardReturn(returnType, "");
                });
            });

            writer
                    .openBlock(shapeName + " = ::Struct.new(")
                    .write(membersBlock)
                    .write("keyword_init: true")
                    .closeBlock(") do")
                    .indent()
                    .write("include Hearth::Structure")
                    .call(() -> renderStructureToSMethod(shape))
                    .closeBlock("end\n");

            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String documentation = new ShapeDocumentationGenerator(model, symbolProvider, shape).render();
            String shapeName = symbolProvider.toSymbol(shape).getName();

            writer.writeInline("$L", documentation);
            writer.openBlock("class $L < Hearth::Union", shapeName);

            for (MemberShape memberShape : shape.members()) {
                String memberDocumentation =
                        new ShapeDocumentationGenerator(model, symbolProvider, memberShape).render();

                writer
                        .writeInline("$L", memberDocumentation)
                        .openBlock("class $L < $L", symbolProvider.toMemberName(memberShape), shapeName)
                        .openBlock("def to_h")
                        .write("{ $L: super(__getobj__) }",
                                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)))
                        .closeBlock("end")
                        .call(() -> renderUnionToSMethod(memberShape))
                        .closeBlock("end\n");
            }

            writer
                    .writeDocstring("Handles unknown future members")
                    .openBlock("class Unknown < $L", shapeName)
                    .openBlock("def to_h")
                    .write("{ unknown: super(__getobj__) }")
                    .closeBlock("end\n")
                    .openBlock("def to_s")
                    .write("\"#<$L::Types::Unknown #{__getobj__ || 'nil'}>\"", settings.getModule())
                    .closeBlock("end")
                    .closeBlock("end");

            writer.closeBlock("end\n");

            return null;
        }

        private void renderStructureToSMethod(StructureShape structureShape) {
            String fullQualifiedShapeName = settings.getModule() + "::Types::"
                    + symbolProvider.toSymbol(structureShape).getName();

            Boolean hasSensitiveMember = structureShape.members().stream()
                    .anyMatch(memberShape -> memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent());

            if (structureShape.hasTrait(SensitiveTrait.class)) {
                // structure is itself sensitive
                writer
                        .write("")
                        .openBlock("def to_s")
                        .write("\"#<struct $L [SENSITIVE]>\"", fullQualifiedShapeName)
                        .closeBlock("end");
            } else if (hasSensitiveMember) {
                // at least one member is sensitive
                Iterator<MemberShape> iterator = structureShape.members().iterator();

                writer
                        .write("")
                        .openBlock("def to_s")
                        .write("\"#<struct $L \"\\", fullQualifiedShapeName)
                        .indent();

                while (iterator.hasNext()) {
                    MemberShape memberShape = iterator.next();
                    String key = symbolProvider.toMemberName(memberShape);
                    String value = "#{" + key + " || 'nil'}";

                    if (memberShape.isBlobShape() || memberShape.isStringShape()) {
                        // Strings are wrapped in quotes
                        value = "\"" + value + "\"";
                    } else if (memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent()) {
                        value = "\\\"[SENSITIVE]\\\"";
                    }

                    if (iterator.hasNext()) {
                        writer.write("\"$L=$L, \"\\", key, value);
                    } else {
                        writer.write("\"$L=$L>\"", key, value);
                    }
                }
                writer
                        .dedent()
                        .closeBlock("end");
            }
        }

        private void renderUnionToSMethod(MemberShape memberShape) {
            String fullQualifiedShapeName = settings.getModule() + "::Types::"
                    + symbolProvider.toMemberName(memberShape);

            writer.write("")
                    .openBlock("def to_s");

            if (memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent()) {
                writer.write("\"#<$L [SENSITIVE]>\"", fullQualifiedShapeName);
            } else {
                writer.write("\"#<$L #{__getobj__ || 'nil'}>\"", fullQualifiedShapeName);
            }

            writer.closeBlock("end");
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

            rbsWriter.openBlock("class $L < Hearth::Union", shapeName);

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
