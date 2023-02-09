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
import java.util.function.Consumer;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
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

public final class StructureGenerator
    implements Consumer<ShapeDirective<StructureShape, GenerationContext, RubySettings>> {
    @Override
    public void accept(ShapeDirective<StructureShape, GenerationContext, RubySettings> directive) {
        var model = directive.model();
        var shape = directive.shape();
        var symbolProvider = directive.context().symbolProvider();
        var settings = directive.context().settings();
        var namespace = settings.getModule() + "::Types";
        var rbFile = settings.getGemName() + "/lib/" + settings.getGemName() + "/types.rb";
        var rbsFile = settings.getGemName() + "/sig/" + settings.getGemName() + "/types.rbs";

        directive.context().writerDelegator().useFileWriter(rbFile, namespace, writer -> {
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
                .openBlock("$T = ::Struct.new(", symbolProvider.toSymbol(shape))
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(") do")
                .indent()
                .write("include $T", Hearth.STRUCTURE)
                .call(() -> renderStructureInitializeMethod(symbolProvider, writer, model, shape))
                .call(() -> renderStructureToSMethod(symbolProvider, writer, model, settings, shape))
                .closeBlock("end\n");
        });

        directive.context().writerDelegator().useFileWriter(rbsFile, namespace, writer -> {
            Symbol symbol = symbolProvider.toSymbol(shape);
            String shapeName = symbol.getName();
            writer.write(shapeName + ": untyped\n");
        });
    }

    private void renderStructureInitializeMethod(
        SymbolProvider symbolProvider,
        RubyCodeWriter writer,
        Model model,
        StructureShape structureShape
    ) {
        NullableIndex nullableIndex = new NullableIndex(model);
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

                        writer.write("self.$L ||= $L",
                                attribute,
                                target.accept(new MemberDefaultVisitor()));
                    });
                })
                .closeBlock("end");
        }
    }

    private void renderStructureToSMethod(
        SymbolProvider symbolProvider,
        RubyCodeWriter writer,
        Model model,
        RubySettings settings,
        StructureShape structureShape
    ) {
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
