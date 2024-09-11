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

package software.amazon.smithy.ruby.codegen.generators.types;

import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.directed.ShapeDirective;
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
import software.amazon.smithy.ruby.codegen.generators.RubyGeneratorBase;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.ruby.codegen.util.DefaultValueRetriever;
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
    protected String getModule() {
        return "Types";
    }

    public void render() {
        write(writer -> {
            new ShapeDocumentationGenerator(context, writer, symbolProvider, shape).render();
            renderInitializeMethodDocumentation(writer);
            renderAttributesDocumentation(writer);

            String membersBlock;
            if (!shape.members().isEmpty()) {
                membersBlock = shape
                        .members()
                        .stream()
                        .map(memberShape -> symbolProvider.toMemberName(memberShape))
                        .collect(Collectors.joining("\n"));
            } else {
                membersBlock = "";
            }

            writer
                    .openBlock("class $T", symbolProvider.toSymbol(shape))
                    .write("include $T", Hearth.STRUCTURE)
                    .write("")
                    .call(() -> {
                        if (membersBlock.isBlank()) {
                            writer.write("MEMBERS = [].freeze");
                        } else {
                            writer.openBlock("MEMBERS = %i[");
                            writer.write(membersBlock);
                            writer.closeBlock("].freeze");
                        }
                    })
                    .write("")
                    .write("attr_accessor(*MEMBERS)")
                    .call(() -> renderToSMethod(writer))
                    .call(() -> renderDefaultsMethod(writer))
                    .closeBlock("end\n");
        });

        writeRbs(writer -> {
            String shapeName = symbolProvider.toSymbol(shape).getName();
            writer
                    .openBlock("class $L", shapeName)
                    .write("include $L", Hearth.STRUCTURE)
                    .call(() -> {
                        shape.members().forEach(memberShape -> {
                            String memberName = symbolProvider.toMemberName(memberShape);
                            Shape target = model.expectShape(memberShape.getTarget());
                            Symbol symbol = symbolProvider.toSymbol(target);
                            String rbsType = symbol.getProperty("rbsType").get().toString();
                            writer.write("attr_accessor $L (): $L?", memberName, rbsType);
                        });
                    })
                    .closeBlock("end");
        });
    }

    private void renderDefaultsMethod(RubyCodeWriter writer) {

        List<MemberShape> defaultMembers = shape.members().stream()
                .filter((m) -> m.hasNonNullDefault() && !nullableIndex.isMemberNullable(m))
                .toList();

        if (!defaultMembers.isEmpty()) {
            writer
                    .write("\nprivate\n")
                    .openBlock("def _defaults")
                    .openBlock("{")
                    .call(() -> {
                        defaultMembers.forEach(memberShape -> {
                            Shape targetShape = model.expectShape(memberShape.getTarget());
                            String defaultValue = targetShape.accept(new DefaultValueRetriever(memberShape));
                            writer.write("$L: $L,",
                                    symbolProvider.toMemberName(memberShape),
                                    defaultValue
                            );
                        });
                    })
                    .unwrite(",\n")
                    .write("")
                    .closeBlock("}")
                    .closeBlock("end");
        }
    }

    private void renderInitializeMethodDocumentation(RubyCodeWriter writer) {
        writer.writeYardMethod("initialize(params = {})", () -> {
            writer.writeYardParam("Hash", "params", "");
            shape.members().forEach(memberShape -> {
                String param = RubyFormatter.asSymbol(symbolProvider.toMemberName(memberShape));
                Shape target = model.expectShape(memberShape.getTarget());
                String paramType = (String) symbolProvider.toSymbol(target)
                        .getProperty("docType").orElseThrow(IllegalArgumentException::new);

                String defaultValue = "";
                if (!nullableIndex.isMemberNullable(memberShape)) {
                    defaultValue = target.accept(new MemberDefaultVisitor());
                }

                writer.writeYardOption("params", paramType, param, defaultValue, "");
            });
        });
    }

    private void renderAttributesDocumentation(RubyCodeWriter writer) {
        shape.members().forEach(memberShape -> {
            String attribute = symbolProvider.toMemberName(memberShape);
            Shape target = model.expectShape(memberShape.getTarget());
            String returnType = (String) symbolProvider.toSymbol(target)
                    .getProperty("docType").orElseThrow(IllegalArgumentException::new);

            writer.writeYardAttribute(attribute, () -> {
                new ShapeDocumentationGenerator(context, writer, symbolProvider, memberShape).render();
                writer.writeYardReturn(returnType, "");
            });
        });
    }

    private void renderToSMethod(RubyCodeWriter writer) {
        String fullQualifiedShapeName = settings.getModule() + "::Types::"
                + symbolProvider.toSymbol(shape).getName();

        boolean hasSensitiveMember = shape.members().stream()
                .anyMatch(memberShape -> memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent());

        if (shape.hasTrait(SensitiveTrait.class)) {
            // structure is itself sensitive
            writer
                    .openBlock("\ndef to_s")
                    .write("\"#<$L [SENSITIVE]>\"", fullQualifiedShapeName)
                    .closeBlock("end");
        } else if (hasSensitiveMember) {
            // at least one member is sensitive
            Iterator<MemberShape> iterator = shape.members().iterator();

            writer
                    .openBlock("\ndef to_s")
                    .write("'#<$L ' \\", fullQualifiedShapeName)
                    .indent();

            while (iterator.hasNext()) {
                MemberShape memberShape = iterator.next();
                String key = symbolProvider.toMemberName(memberShape);
                String value = "#{" + key + " || 'nil'}";
                boolean memberLiteral = false;

                if (memberShape.isBlobShape() || memberShape.isStringShape()) {
                    // Strings are wrapped in quotes
                    value = "\"" + value + "\"";
                    memberLiteral = true;
                } else if (memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent()) {
                    value = "[SENSITIVE]";
                    memberLiteral = true;
                }

                String quote = memberLiteral ? "'" : "\"";
                if (iterator.hasNext()) {
                    writer.write("$3L$1L=$2L, $3L \\", key, value, quote);
                } else {
                    writer.write("$3L$1L=$2L>$3L", key, value, quote);
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
