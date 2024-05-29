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

import java.util.Collection;
import java.util.Comparator;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.IdempotencyTokenTrait;
import software.amazon.smithy.model.traits.SparseTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ParamsGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(ParamsGenerator.class.getName());

    public ParamsGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
    }

    @Override
    protected String getModule() {
        return "Params";
    }

    public void render() {
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .apiPrivate()
                    .addModule("Params")
                    .call(() -> renderParams(writer))
                    .write("")
                    .closeAllModules();
        });
        LOGGER.fine("Wrote params to " + rbFile());
    }

    private void renderParams(RubyCodeWriter writer) {
        Model modelWithoutTraitShapes = ModelTransformer.create()
                .getModelWithoutTraitShapes(model);

        new Walker(modelWithoutTraitShapes)
                .walkShapes(context.service())
                .stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach((shape) -> shape.accept(new Visitor(writer)));
    }

    private final class Visitor extends ShapeVisitor.Default<Void> {

        private final RubyCodeWriter writer;

        private Visitor(RubyCodeWriter writer) {
            this.writer = writer;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape structureShape) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(structureShape).getName())
                    .openBlock("def self.build(params, context:)")
                    .call(() -> renderBuilderForStructureMembers(
                            context.symbolProvider().toSymbol(structureShape), structureShape.members()))
                    .closeBlock("end")
                    .closeBlock("end");
            return null;
        }

        private void renderBuilderForStructureMembers(Symbol symbol, Collection<MemberShape> members) {
            writer
                    .write("$T.validate_types!(params, ::Hash, $T, context: context)",
                            Hearth.VALIDATOR, symbol)
                    .write("type = $T.new", symbol)
                    .write("$T.validate_unknown!(type, params, context: context) if params.is_a?(Hash)",
                            Hearth.VALIDATOR);

            members.forEach(member -> {
                Shape target = model.expectShape(member.getTarget());
                String memberName = symbolProvider.toMemberName(member);
                String memberSetter = "type." + memberName + " = ";
                String symbolName = RubyFormatter.asSymbol(memberName);
                String input = "params[" + symbolName + "]";
                String contextKey = "\"#{context}[" + symbolName + "]\"";
                target.accept(new MemberBuilder(model, writer, context.symbolProvider(),
                        memberSetter, input, contextKey, member, true));
            });

            writer.write("type");
        }

        @Override
        public Void listShape(ListShape listShape) {
            Shape memberTarget =
                    model.expectShape(listShape.getMember().getTarget());

            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(listShape).getName())
                    .openBlock("def self.build(params, context:)")
                    .write("$T.validate_types!(params, ::Array, context: context)", Hearth.VALIDATOR)
                    .write("data = []")
                    .call(() -> {
                        if (isComplexShape(memberTarget)) {
                            writer.openBlock("params.each_with_index do |element, index|");
                        } else {
                            writer.openBlock("params.each do |element|");
                        }
                    })
                    .call(() -> memberTarget
                            .accept(new MemberBuilder(model, writer, symbolProvider, "data << ",
                                    "element", "\"#{context}[#{index}]\"",
                                    listShape.getMember(),
                                    !listShape.hasTrait(SparseTrait.class))))
                    .closeBlock("end")
                    .write("data")
                    .closeBlock("end")
                    .closeBlock("end");
            return null;
        }

        @Override
        public Void mapShape(MapShape mapShape) {
            Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(mapShape).getName())
                    .openBlock("def self.build(params, context:)")
                    .write("$T.validate_types!(params, ::Hash, context: context)", Hearth.VALIDATOR)
                    .write("data = {}")
                    .openBlock("params.each do |key, value|")
                    .call(() -> valueTarget
                            .accept(new MemberBuilder(model, writer, context.symbolProvider(), "data[key] = ",
                                    "value", "\"#{context}[:#{key}]\"", mapShape.getValue(),
                                    !mapShape.hasTrait(SparseTrait.class))))
                    .closeBlock("end")
                    .write("data")
                    .closeBlock("end")
                    .closeBlock("end");
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            Symbol typeSymbol = context.symbolProvider().toSymbol(shape);

            writer
                    .write("")
                    .openBlock("class $L", name)
                    .openBlock("def self.build(params, context:)")
                    .write("return params if params.is_a?($T)", typeSymbol)
                    .write("$T.validate_types!(params, ::Hash, $T, context: context)",
                            Hearth.VALIDATOR, typeSymbol)
                    .openBlock("unless params.size == 1")
                    .write("raise ArgumentError,")
                    .indent(3)
                    .write("\"Expected #{context} to have exactly one member, got: #{params}\"")
                    .dedent(3)
                    .closeBlock("end")
                    .write("key, value = params.flatten")
                    .write("case key"); //start a case statement.  This does NOT indent

            for (MemberShape member : shape.members()) {
                Shape target = model.expectShape(member.getTarget());
                String memberClassName = symbolProvider.toMemberName(member);
                String memberName = RubyFormatter.asSymbol(memberClassName);
                writer.write("when $L", memberName)
                        .indent()
                        .openBlock("$T.new(", context.symbolProvider().toSymbol(member));
                String input = "params[" + memberName + "]";
                String contextString = "\"#{context}[" + memberName + "]\"";
                target.accept(new MemberBuilder(model, writer, symbolProvider, "", input, contextString,
                        member, false));
                writer.closeBlock(")")
                        .dedent();
            }
            String expectedMembers =
                    shape.members().stream().map((member) -> RubyFormatter.asSymbol(member.getMemberName()))
                            .collect(Collectors.joining(", "));
            writer.write("else")
                    .indent()
                    .write("raise ArgumentError,")
                    .indent(3)
                    .write("\"Expected #{context} to have one of $L set\"", expectedMembers)
                    .dedent(4);
            writer.write("end")  //end of case statement, NOT indented
                    .closeBlock("end")
                    .closeBlock("end");
            return null;
        }

        private boolean isComplexShape(Shape shape) {
            return shape.isStructureShape() || shape.isListShape() || shape.isMapShape()
                    || shape.isUnionShape() || shape.isOperationShape();
        }

        private static class MemberBuilder extends ShapeVisitor.Default<Void> {
            private final Model model;
            private final RubyCodeWriter writer;
            private final SymbolProvider symbolProvider;
            private final String memberSetter;
            private final String input;
            private final String context;
            private final MemberShape memberShape;
            private final boolean checkRequired;
            private final String rubySymbol;

            MemberBuilder(
                    Model model,
                    RubyCodeWriter writer,
                    SymbolProvider symbolProvider,
                    String memberSetter,
                    String input,
                    String context,
                    MemberShape memberShape,
                    boolean checkRequired
            ) {
                this.model = model;
                this.writer = writer;
                this.symbolProvider = symbolProvider;
                this.memberSetter = memberSetter;
                this.input = input;
                this.context = context;
                this.memberShape = memberShape;
                this.checkRequired = checkRequired;
                this.rubySymbol = RubyFormatter.asSymbol(symbolProvider.toMemberName(memberShape));
            }

            @Override
            protected Void getDefault(Shape shape) {
                if (checkRequired) {
                    writer.write("$1L$2L unless $2L.nil?", memberSetter, input);
                } else {
                    writer.write("$1L$2L", memberSetter, input);
                }
                return null;
            }

            @Override
            public Void floatShape(FloatShape shape) {
                if (checkRequired) {
                    writer.write("$1L$2L&.to_f unless $2L.nil?", memberSetter, input);
                } else {
                    writer.write("$1L$2L&.to_f", memberSetter, input);
                }
                return null;
            }


            @Override
            public Void doubleShape(DoubleShape shape) {
                if (checkRequired) {
                    writer.write("$1L$2L&.to_f unless $2L.nil?", memberSetter, input);
                } else {
                    writer.write("$1L$2L&.to_f", memberSetter, input);
                }
                return null;
            }

            @Override
            public Void blobShape(BlobShape shape) {
                if (shape.hasTrait(StreamingTrait.class)) {
                    writer
                            .write("io = $L || StringIO.new", input)
                            .openBlock("unless io.respond_to?(:read) "
                                    + "|| io.respond_to?(:readpartial)")
                            .write("io = StringIO.new(io)")
                            .closeBlock("end")
                            .write("$Lio", memberSetter);
                } else {
                    getDefault(shape);
                }
                return null;
            }

            @Override
            public Void stringShape(StringShape shape) {
                if (memberShape.hasTrait(IdempotencyTokenTrait.class)
                        || shape.hasTrait(IdempotencyTokenTrait.class)) {
                    writer.write("$L$L || $T.uuid", memberSetter, input, RubyImportContainer.SECURE_RANDOM);
                } else {
                    getDefault(shape);
                }
                return null;
            }

            @Override
            public Void listShape(ListShape shape) {
                defaultComplex(shape);
                return null;
            }

            @Override
            public Void mapShape(MapShape shape) {
                defaultComplex(shape);
                return null;
            }

            @Override
            public Void structureShape(StructureShape shape) {
                defaultComplex(shape);
                return null;
            }

            @Override
            public Void unionShape(UnionShape shape) {
                defaultComplex(shape);
                return null;
            }

            private void defaultComplex(Shape shape) {
                if (checkRequired) {
                    writer.write("$1L$2L.build($3L, context: $4L) unless $3L.nil?", memberSetter,
                            symbolProvider.toSymbol(shape).getName(), input, context);
                } else {
                    writer.write("$1L($2L.build($3L, context: $4L) unless $3L.nil?)", memberSetter,
                            symbolProvider.toSymbol(shape).getName(), input, context);
                }
            }
        }
    }
}
