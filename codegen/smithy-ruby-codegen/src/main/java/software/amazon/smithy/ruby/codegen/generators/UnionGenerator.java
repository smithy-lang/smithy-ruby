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

import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.directed.GenerateUnionDirective;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.SensitiveTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public final class UnionGenerator extends RubyGeneratorBase {

    private final UnionShape shape;

    public UnionGenerator(GenerateUnionDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.shape = directive.shape();
    }

    @Override
    String getModule() {
        return "Types";
    }

    public void render() {
        write(writer -> {
            writer
                    .call(() -> new ShapeDocumentationGenerator(model, writer, symbolProvider, shape).render())
                    .openBlock("class $T < $T", symbolProvider.toSymbol(shape), Hearth.UNION);

            for (MemberShape memberShape : shape.members()) {
                writer
                        .call(() -> new ShapeDocumentationGenerator(
                                model, writer, symbolProvider, memberShape).render())
                        .openBlock("class $L < $T",
                                symbolProvider.toMemberName(memberShape), symbolProvider.toSymbol(shape))
                        .openBlock("def to_h")
                        .write("{ $L: super(__getobj__) }",
                                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)))
                        .closeBlock("end")
                        .call(() -> renderUnionToSMethod(writer, memberShape))
                        .closeBlock("end\n");
            }

            writer
                    .writeDocstring("Handles unknown future members")
                    .openBlock("class Unknown < $T", symbolProvider.toSymbol(shape))
                    .openBlock("def to_h")
                    .write("{ unknown: super(__getobj__) }")
                    .closeBlock("end\n")
                    .openBlock("def to_s")
                    .write("\"#<$L::Types::Unknown #{__getobj__ || 'nil'}>\"", settings.getModule())
                    .closeBlock("end")
                    .closeBlock("end")
                    .closeBlock("end\n");
        });

        writeRbs(writer -> {
            Symbol symbol = symbolProvider.toSymbol(shape);
            writer.openBlock("class $T < $T", symbol, Hearth.UNION);

            for (MemberShape memberShape : shape.members()) {
                writer
                    .openBlock("class $L < $T", symbolProvider.toMemberName(memberShape), symbol)
                    .write("def to_h: () -> { $L: Hash[Symbol, $T] }",
                            RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)), symbol)
                    .write("def to_s: () -> String")
                    .closeBlock("end\n");
            }

            writer
                .openBlock("class Unknown < $T", symbol)
                .write("def to_h: () -> { unknown: Hash[Symbol, $T] }", symbol)
                .write("def to_s: () -> String")
                .closeBlock("end")
                .closeBlock("end\n");
        });
    }

    private void renderUnionToSMethod(RubyCodeWriter writer, MemberShape memberShape) {
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
