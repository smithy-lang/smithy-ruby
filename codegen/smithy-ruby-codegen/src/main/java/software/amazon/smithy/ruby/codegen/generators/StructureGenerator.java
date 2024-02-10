/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.directed.ShapeDirective;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.NullableIndex;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.SensitiveTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public final class StructureGenerator extends RubyGeneratorBase {

    private final StructureShape shape;
    private final NullableIndex nullableIndex;

    public StructureGenerator(ShapeDirective<StructureShape, GenerationContext, RubySettings> directive) {
        super(directive);
        this.shape = directive.shape();
        this.nullableIndex = NullableIndex.of(model);
    }

    @Override
    String getModule() {
        return "Types";
    }

    public void render() {
        write(writer -> {
            // a total hack so that any structures named Struct do not fail documentation parsing
            if (shape.getId().getName().equals("Struct")) {
                writer.apiPrivate().write("class ::Struct; end\n");
            }

            new ShapeDocumentationGenerator(model, writer, symbolProvider, shape).render();
            renderStructureInitializeMethodDocumentation(writer);
            renderStructureAttributesDocumentation(writer);

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
                .openBlock("$T = ::Struct.new(", symbolProvider.toSymbol(shape))
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(") do")
                .indent()
                .write("include $T", Hearth.STRUCTURE)
                .call(() -> renderStructureInitializeMethod(writer, shape))
                .call(() -> renderStructureToSMethod(writer, model, shape))
                .closeBlock("end\n");
        });

        writeRbs(writer -> {
            String shapeName = symbolProvider.toSymbol(shape).getName();
            writer
                    .openBlock("class $L < ::Struct[untyped]", shapeName)
                    .write("include $L", Hearth.STRUCTURE)
                    .call(() -> {
                        shape.members().forEach(memberShape -> {
                            String name = symbolProvider.toMemberName(memberShape);
                            Symbol target = symbolProvider.toSymbol(model.expectShape(memberShape.getTarget()));
                            writer.write("attr_accessor $L (): $L", name, target.getProperty("rbsType").get());
                        });
                    })
                    .closeBlock("end");
        });
    }

    private void renderStructureInitializeMethod(RubyCodeWriter writer, StructureShape structureShape
    ) {
        List<MemberShape> defaultMembers = structureShape.members().stream()
            .filter((m) -> !nullableIndex.isNullable(m))
            .toList();

        if (!defaultMembers.isEmpty()) {
            writer
                .openBlock("\ndef initialize(*)")
                .write("super")
                .call(() -> {
                    defaultMembers.forEach((m) -> {
                        String attribute = symbolProvider.toMemberName(m);
                        Shape target = model.expectShape(m.getTarget());

                        writer.write("self.$1L = $2L if self.$1L.nil?",
                                attribute,
                                target.accept(new MemberDefaultVisitor()));
                    });
                })
                .closeBlock("end");
        }
    }

    private void renderStructureInitializeMethodDocumentation(RubyCodeWriter writer) {
        writer.writeYardMethod("initialize(params = {})", () -> {
            writer.writeYardParam("Hash", "params", "");
            shape.members().forEach(memberShape -> {
                String param = RubyFormatter.asSymbol(symbolProvider.toMemberName(memberShape));
                Shape target = model.expectShape(memberShape.getTarget());
                String paramType = (String) symbolProvider.toSymbol(target)
                        .getProperty("docType").orElseThrow(IllegalArgumentException::new);

                String defaultValue = "";
                if (!nullableIndex.isNullable(memberShape)) {
                    defaultValue = target.accept(new MemberDefaultVisitor());
                }

                writer.writeYardOption("params", paramType, param, defaultValue, "");
            });
        });
    }

    private void renderStructureAttributesDocumentation(RubyCodeWriter writer) {
        shape.members().forEach(memberShape -> {
            String attribute = symbolProvider.toMemberName(memberShape);
            Shape target = model.expectShape(memberShape.getTarget());
            String returnType = (String) symbolProvider.toSymbol(target)
                    .getProperty("docType").orElseThrow(IllegalArgumentException::new);

            writer.writeYardAttribute(attribute, () -> {
                new ShapeDocumentationGenerator(model, writer, symbolProvider, memberShape).render();
                writer.writeYardReturn(returnType, "");
            });
        });
    }

    private void renderStructureToSMethod(RubyCodeWriter writer, Model model, StructureShape structureShape) {
        String fullQualifiedShapeName = settings.getModule() + "::Types::"
                + symbolProvider.toSymbol(structureShape).getName();

        boolean hasSensitiveMember = structureShape.members().stream()
                .anyMatch(memberShape -> memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent());

        if (structureShape.hasTrait(SensitiveTrait.class)) {
            // structure is itself sensitive
            writer
                    .openBlock("\ndef to_s")
                    .write("\"#<struct $L [SENSITIVE]>\"", fullQualifiedShapeName)
                    .closeBlock("end");
        } else if (hasSensitiveMember) {
            // at least one member is sensitive
            Iterator<MemberShape> iterator = structureShape.members().iterator();

            writer
                    .openBlock("\ndef to_s")
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

    private static class MemberDefaultVisitor extends ShapeVisitor.Default<String> {
        @Override
        protected String getDefault(Shape shape) {
            return "0";
        }

        @Override
        public String booleanShape(BooleanShape s) {
            return "false";
        }
    }
}
