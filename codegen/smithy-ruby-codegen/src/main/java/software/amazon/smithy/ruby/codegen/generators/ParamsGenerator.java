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
import java.util.Optional;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntEnumShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.DefaultTrait;
import software.amazon.smithy.model.traits.IdempotencyTokenTrait;
import software.amazon.smithy.model.traits.RequiredTrait;
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
    String getModule() {
        return "Params";
    }

    public void render() {
        write(writer -> {
            writer
                    .includePreamble()
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
                    .openBlock("module $L", symbolProvider.toSymbol(structureShape).getName())
                    .openBlock("def self.build(params, context: '')")
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
                    .openBlock("module $L", symbolProvider.toSymbol(listShape).getName())
                    .openBlock("def self.build(params, context: '')")
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
                    .openBlock("module $L", symbolProvider.toSymbol(mapShape).getName())
                    .openBlock("def self.build(params, context: '')")
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
                    .openBlock("module $L", name)
                    .openBlock("def self.build(params, context: '')")
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
            private final Optional<String> defaultValue;
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

                // Note: No need to check for box trait for V1 Smithy models.
                // Smithy convert V1 to V2 model and populate Default trait automatically
                boolean containsRequiredAndDefaultTraits =
                        memberShape.hasTrait(DefaultTrait.class)
                                && !memberShape.expectTrait(DefaultTrait.class).toNode().isNullNode()
                                && memberShape.hasTrait(RequiredTrait.class);

                if (containsRequiredAndDefaultTraits) {
                    Shape targetShape = model.expectShape(memberShape.getTarget());
                    this.defaultValue = Optional.of(targetShape.accept(new DefaultValueRetriever(model, memberShape)));
                } else {
                    this.defaultValue = Optional.empty();
                }
            }

            @Override
            protected Void getDefault(Shape shape) {
                if (defaultValue.isPresent()) {
                    writer.write("$1Lparams.fetch($2L, $3L)", memberSetter, rubySymbol, defaultValue.get());
                } else {
                    writer.write("$L$L", memberSetter, input);
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
                if (defaultValue.isPresent()) {
                    if (checkRequired) {
                        writer.write("$1L$2L.build(params.fetch($3L, $5L), context: $4L)",
                                memberSetter, symbolProvider.toSymbol(shape).getName(), rubySymbol, context,
                                defaultValue.get());
                    } else {
                        writer.write("$1L($2L.build(params.fetch($3L, $5L), context: $4L))",
                                memberSetter, symbolProvider.toSymbol(shape).getName(), rubySymbol, context,
                                defaultValue.get());
                    }
                    return;
                }

                if (checkRequired) {
                    writer.write("$1L$2L.build($3L, context: $4L) unless $3L.nil?", memberSetter,
                            symbolProvider.toSymbol(shape).getName(), input, context);
                } else {
                    writer.write("$1L($2L.build($3L, context: $4L) unless $3L.nil?)", memberSetter,
                            symbolProvider.toSymbol(shape).getName(), input, context);
                }
            }
        }

        /**
         * Default value constrains:
         * enum: can be set to any valid string value of the enum.
         * intEnum: can be set to any valid integer value of the enum.
         * document: can be set to null, `true, false, string, numbers, an empty list, or an empty map.
         * list: can only be set to an empty list.
         * map: can only be set to an empty map.
         * structure: no default value.
         * union: no default value.
         * <p>
         * See https://awslabs.github.io/smithy/2.0/spec/type-refinement-traits.html?highlight=required#default-value-constraints
         */
        private static final class DefaultValueRetriever extends ShapeVisitor.Default<String> {

            private final MemberShape memberShape;
            private final Node defaultNode;
            private final Model model;

            private DefaultValueRetriever(Model model, MemberShape memberShape) {
                this.model = model;
                this.memberShape = memberShape;
                this.defaultNode = memberShape.expectTrait(DefaultTrait.class).toNode();
            }

            @Override
            protected String getDefault(Shape shape) {
                return "nil";
            }

            @Override
            public String blobShape(BlobShape shape) {
                return getDefaultString();
            }

            @Override
            public String booleanShape(BooleanShape shape) {
                return getDefaultBoolean();
            }

            @Override
            public String stringShape(StringShape shape) {
                return getDefaultString();
            }

            @Override
            public String byteShape(ByteShape shape) {
                return String.valueOf(getDefaultNumber().byteValue());
            }

            @Override
            public String shortShape(ShortShape shape) {
                return String.valueOf(getDefaultNumber().shortValue());
            }

            @Override
            public String integerShape(IntegerShape shape) {
                return String.valueOf(getDefaultNumber().intValue());
            }

            @Override
            public String longShape(LongShape shape) {
                return String.valueOf(getDefaultNumber().longValue());
            }

            @Override
            public String floatShape(FloatShape shape) {
                return String.valueOf(getDefaultNumber().shortValue());
            }

            @Override
            public String doubleShape(DoubleShape shape) {
                return String.valueOf(getDefaultNumber().doubleValue());
            }

            @Override
            public String bigIntegerShape(BigIntegerShape shape) {
                return String.valueOf(getDefaultNumber().intValue());
            }

            @Override
            public String bigDecimalShape(BigDecimalShape shape) {
                return String.valueOf(getDefaultNumber().floatValue());
            }

            @Override
            public String enumShape(EnumShape shape) {
                return shape.getEnumValues().get(getDefaultString());
            }

            @Override
            public String intEnumShape(IntEnumShape shape) {
                return String.valueOf(getDefaultNumber().intValue());
            }

            @Override
            public String listShape(ListShape shape) {
                if (defaultNode.asArrayNode().isPresent()) {
                    return "[]";
                }
                return "nil";
            }

            @Override
            public String mapShape(MapShape shape) {
                if (defaultNode.asObjectNode().isPresent()) {
                    return "{}";
                }
                return "nil";
            }

            @Override
            public String documentShape(DocumentShape shape) {
                if (defaultNode.asNumberNode().isPresent()) {
                    return getDefaultNumber().toString();
                }

                if (defaultNode.asBooleanNode().isPresent()) {
                    return getDefaultBoolean();
                }

                if (defaultNode.asStringNode().isPresent()) {
                    return getDefaultString();
                }

                if (defaultNode.asArrayNode().isPresent()) {
                    return "[]";
                }

                if (defaultNode.asObjectNode().isPresent()) {
                    return "{}";
                }

                return "nil";
            }

            @Override
            public String timestampShape(TimestampShape shape) {
                if (defaultNode.isStringNode()) {
                    return getDefaultString();
                } else if (defaultNode.isNumberNode()) {
                    return String.valueOf(getDefaultNumber());
                } else {
                    return "nil";
                }
            }

            private String getDefaultString() {
                return String.format("\"%s\"", defaultNode.expectStringNode().getValue());
            }

            private String getDefaultBoolean() {
                return String.valueOf(defaultNode.expectBooleanNode().getValue());
            }

            private Number getDefaultNumber() {
                return defaultNode.expectNumberNode().getValue();
            }
        }
    }
}
