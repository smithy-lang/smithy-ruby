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

import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.directed.GenerateUnionDirective;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.SensitiveTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.RubyGeneratorBase;
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
    protected String getModule() {
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
                    .openBlock("class Unknown < $T", symbolProvider.toSymbol(shape))
                    .openBlock("def initialize(name:, value:)")
                    .write("super({name: name, value: value})")
                    .closeBlock("end")
                    .write("")
                    .openBlock("def to_h")
                    .write("{ unknown: super(__getobj__) }")
                    .closeBlock("end")
                    .closeBlock("end")
                    .closeBlock("end\n");
        });

        writeRbs(writer -> {
            Symbol symbol = symbolProvider.toSymbol(shape);
            writer.openBlock("class $T < $T", symbol, Hearth.UNION);

            for (MemberShape memberShape : shape.members()) {
                String memberName = symbolProvider.toMemberName(memberShape);
                Shape target = model.expectShape(memberShape.getTarget());

                writer
                        .openBlock("class $L < $T", memberName, symbol)
                        .write("def to_h: () -> { $L: $L }", RubyFormatter.toSnakeCase(memberName),
                                target.accept(new UnionToHValueRbsVisitor()))
                        .write("def to_s: () -> String")
                        .closeBlock("end\n");
            }

            writer
                    .openBlock("class Unknown < $T", symbol)
                    .write("def to_h: () -> { unknown: { name: ::String, value: untyped } }")
                    .write("def to_s: () -> String")
                    .closeBlock("end")
                    .closeBlock("end\n");
        });
    }

    private void renderUnionToSMethod(RubyCodeWriter writer, MemberShape memberShape) {
        if (!memberShape.getMemberTrait(model, SensitiveTrait.class).isPresent()) {
            return;
        }

        String fullQualifiedShapeName = settings.getModule() + "::Types::"
                + symbolProvider.toMemberName(memberShape);
        writer
                .write("")
                .openBlock("def to_s")
                .write("\"#<$L [SENSITIVE]>\"", fullQualifiedShapeName)
                .closeBlock("end");
    }

    private class UnionToHValueRbsVisitor extends ShapeVisitor.Default<String> {
        @Override
        protected String getDefault(Shape shape) {
            Symbol symbol = symbolProvider.toSymbol(shape);
            return symbol.getProperty("rbsType") .orElse("untyped").toString();
        }

        @Override
        public String listShape(ListShape shape) {
            Shape target = model.expectShape(shape.getMember().getTarget());
            return "::Array[" + target.accept(this) + "]";
        }

        @Override
        public String mapShape(MapShape shape) {
            Shape target = model.expectShape(shape.getValue().getTarget());
            return "::Hash[::String, " + target.accept(this) + "]";
        }

        @Override
        public String structureShape(StructureShape shape) {
            return "::Hash[::Symbol, untyped]";
        }

        @Override
        public String unionShape(UnionShape shape) {
            return "::Hash[::Symbol, untyped]";
        }
    }
}
