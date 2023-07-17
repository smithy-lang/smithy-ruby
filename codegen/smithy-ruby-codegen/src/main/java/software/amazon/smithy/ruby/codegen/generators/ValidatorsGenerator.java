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
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.RequiredTrait;
import software.amazon.smithy.model.traits.RequiresLengthTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.CodegenUtils;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ValidatorsGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(ValidatorsGenerator.class.getName());

    protected final Set<ShapeId> generatedValidators;

    public ValidatorsGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.generatedValidators = new HashSet<>();
    }

    @Override
    String getModule() {
        return "Validators";
    }

    public void render() {
        write(writer -> {
            writer
                .includePreamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .apiPrivate()
                .openBlock("module Validators")
                .call(() -> renderValidators(writer))
                .write("")
                .closeBlock("end")
                .closeBlock("end");
            });
        LOGGER.fine("Wrote validators to " + rbFile());
    }

    private void renderValidators(RubyCodeWriter writer) {
        TreeSet<Shape> shapesToBeRendered = CodegenUtils.getAlphabeticalOrderedShapesSet();
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.service()));
        containedOperations.stream()
                .forEach(o -> {
                    Shape inputShape = model.expectShape(o.getInputShape());
                    shapesToBeRendered.add(inputShape);
                    generatedValidators.add(inputShape.toShapeId());

                    Iterator<Shape> it = new Walker(model).iterateShapes(inputShape);
                    while (it.hasNext()) {
                        Shape s = it.next();
                        if (!shapesToBeRendered.contains(s)) {
                            generatedValidators.add(s.getId());
                            shapesToBeRendered.add(s);
                        }
                    }
                });

        shapesToBeRendered.forEach((shape) -> shape.accept(new Visitor(writer)));
    }

    private final class Visitor extends ShapeVisitor.Default<Void> {

        private final RubyCodeWriter writer;

        private Visitor(RubyCodeWriter writer) {
            this.writer = writer;
        }

        @Override
        public Void structureShape(StructureShape structureShape) {
            Collection<MemberShape> members = structureShape.members();
            writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(structureShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("$T.validate_types!(input, $T, context: context)",
                        Hearth.VALIDATOR,
                        context.symbolProvider().toSymbol(structureShape))
                .call(() -> renderValidatorsForStructureMembers(members))
                .closeBlock("end")
                .closeBlock("end");

            return null;
        }

        private void renderValidatorsForStructureMembers(Collection<MemberShape> members) {
            members.forEach(member -> {
                Shape target = model.expectShape(member.getTarget());
                String symbolName = ":" + symbolProvider.toMemberName(member);
                String input = "input[" + symbolName + "]";
                String context = "\"#{context}[" + symbolName + "]\"";
                if (member.hasTrait(RequiredTrait.class)) {
                    writer.write("$T.validate_required!($L, context: $L)", Hearth.VALIDATOR, input, context);
                }
                target.accept(new MemberValidator(writer, symbolProvider, input, context, false));
            });
        }

        @Override
        public Void mapShape(MapShape mapShape) {
            Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

            writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(mapShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("$T.validate_types!(input, ::Hash, context: context)", Hearth.VALIDATOR)
                .openBlock("input.each do |key, value|")
                .write("$T.validate_types!(key, ::String, ::Symbol, context: \"#{context}.keys\")", Hearth.VALIDATOR)
                .call(() -> valueTarget
                    .accept(new MemberValidator(writer, symbolProvider, "value", "\"#{context}[:#{key}]\"", false)))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

            return null;
        }

        @Override
        public Void listShape(ListShape listShape) {
            Shape memberTarget =
                    model.expectShape(listShape.getMember().getTarget());

            writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(listShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("$T.validate_types!(input, ::Array, context: context)", Hearth.VALIDATOR)
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                    .accept(new MemberValidator(writer, symbolProvider, "element", "\"#{context}[#{index}]\"", false)))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

            return null;
        }

        @Override
        public Void unionShape(UnionShape unionShape) {
            Symbol unionType = context.symbolProvider().toSymbol(unionShape);
            String shapeName = unionType.getName();
            Collection<MemberShape> unionMemberShapes = unionShape.members();

            writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(unionShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("case input")
                .call(() -> unionMemberShapes.forEach(unionMemberShape -> {
                    String unionMemberName = symbolProvider.toMemberName(unionMemberShape);
                    writer
                            .write("when $T", context.symbolProvider().toSymbol(unionMemberShape))
                            .indent();
                    model.expectShape(unionMemberShape.getTarget())
                        .accept(new MemberValidator(writer, symbolProvider, "input.__getobj__", "context", false));
                    writer.dedent();
                }))
                .write("else")
                .write("  raise ArgumentError,")
                .write("        \"Expected #{context} to be a union member of \"\\")
                .write("        \"Types::" + shapeName + ", got #{input.class}.\"")
                .write("end") // end switch case
                .closeBlock("end") // end validate method
                .withQualifiedNamespace("Validators",
                    () -> renderValidatorsForUnionMembers(unionMemberShapes))
                .closeBlock("end");

            return null;
        }

        @Override
        public Void documentShape(DocumentShape documentShape) {
            writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(documentShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("$T.validate_types!(input, "
                        + "::Hash, ::String, ::Array, ::TrueClass, ::FalseClass, ::Numeric, context: context)",
                        Hearth.VALIDATOR)
                .write("case input")
                .openBlock("when ::Hash")
                .write("input.each do |k,v|")
                .indent()
                .write("validate!(v, context: \"#{context}[:#{k}]\")")
                .closeBlock("end")
                .dedent()
                .write("when ::Array")
                .indent()
                .openBlock("input.each_with_index do |v, i|")
                .write("validate!(v, context: \"#{context}[#{i}]\")")
                .closeBlock("end")
                .dedent()
                .write("end")
                .closeBlock("end")
                .closeBlock("end");

            return null;
        }

        private void renderValidatorsForUnionMembers(Collection<MemberShape> members) {
            members.forEach(member -> {
                String name = symbolProvider.toMemberName(member);
                Shape target = model.expectShape(member.getTarget());

                writer
                    .write("")
                    .openBlock("class $L", name)
                    .openBlock("def self.validate!(input, context:)")
                    .call(() -> target.accept(
                        new MemberValidator(writer, symbolProvider, "input", "context", true)))
                    .closeBlock("end")
                    .closeBlock("end");
            });
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        private static class MemberValidator extends ShapeVisitor.Default<Void> {
            private final RubyCodeWriter writer;
            private final SymbolProvider symbolProvider;
            private final String input;
            private final String context;
            private Boolean renderUnionMemberValidator;

            MemberValidator(RubyCodeWriter writer,
                            SymbolProvider symbolProvider,
                            String input,
                            String context,
                            Boolean renderUnionMemberValidator) {
                this.writer = writer;
                this.symbolProvider = symbolProvider;
                this.input = input;
                this.context = context;
                this.renderUnionMemberValidator = renderUnionMemberValidator;
            }

            @Override
            protected Void getDefault(Shape shape) {
                return null;
            }

            @Override
            public Void blobShape(BlobShape shape) {
                if (shape.hasTrait(StreamingTrait.class)) {
                    writer
                            .openBlock("unless $1L.respond_to?(:read) || $1L.respond_to?(:readpartial)",
                                    input)
                            .write("raise ArgumentError, \"Expected #{context} to be an IO like object,"
                                    + " got #{$L.class}\"", input)
                            .closeBlock("end");
                    if (shape.hasTrait(RequiresLengthTrait.class)) {
                        writer
                                .openBlock("\nunless $1L.respond_to?(:size)", input)
                                .write("raise ArgumentError, \"Expected #{context} to respond_to(:size)\"")
                                .closeBlock("end");
                    }
                } else {
                    writer.write("$T.validate_types!($L, ::String, context: $L)", Hearth.VALIDATOR, input, context);
                }
                return null;
            }

            @Override
            public Void booleanShape(BooleanShape shape) {
                writer.write("$T.validate_types!($L, ::TrueClass, ::FalseClass, context: $L)",
                        Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void listShape(ListShape shape) {
                String content = "$1L.validate!($2L, context: $3L) unless $2L.nil?";
                if (renderUnionMemberValidator) {
                    content = "Validators::" + content;
                }
                writer.write(content, symbolProvider.toSymbol(shape).getName(), input, context);
                return null;
            }

            @Override
            public Void byteShape(ByteShape shape) {
                writer.write("$T.validate_types!($L, ::Integer, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void shortShape(ShortShape shape) {
                writer.write("$T.validate_types!($L, ::Integer, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void integerShape(IntegerShape shape) {
                writer.write("$T.validate_types!($L, ::Integer, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void longShape(LongShape shape) {
                writer.write("$T.validate_types!($L, ::Integer, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void floatShape(FloatShape shape) {
                writer.write("$T.validate_types!($L, ::Float, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void documentShape(DocumentShape shape) {
                String content = "$1L.validate!($2L, context: $3L) unless $2L.nil?";
                if (renderUnionMemberValidator) {
                    content = "Validators::" + content;
                }
                writer.write(content, symbolProvider.toSymbol(shape).getName(), input, context);
                return null;
            }

            @Override
            public Void doubleShape(DoubleShape shape) {
                writer.write("$T.validate_types!($L, ::Float, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void bigDecimalShape(BigDecimalShape shape) {
                writer.write("$T.validate_types!($L, $T, context: $L)",
                    Hearth.VALIDATOR, input, RubyImportContainer.BIG_DECIMAL, context);
                return null;
            }

            @Override
            public Void mapShape(MapShape shape) {
                String content = "$1L.validate!($2L, context: $3L) unless $2L.nil?";
                if (renderUnionMemberValidator) {
                    content = "Validators::" + content;
                }

                writer.write(content, symbolProvider.toSymbol(shape).getName(), input, context);
                return null;
            }

            @Override
            public Void stringShape(StringShape shape) {
                writer.write("$T.validate_types!($L, ::String, context: $L)", Hearth.VALIDATOR, input, context);
                return null;
            }

            @Override
            public Void structureShape(StructureShape shape) {
                String content = "$1L.validate!($2L, context: $3L) unless $2L.nil?";
                if (renderUnionMemberValidator) {
                    content = "Validators::" + content;
                }
                writer.write(content, symbolProvider.toSymbol(shape).getName(), input, context);
                return null;
            }

            @Override
            public Void unionShape(UnionShape shape) {
                writer.write("$1L.validate!($2L, context: $3L) unless $2L.nil?",
                    symbolProvider.toSymbol(shape).getName(), input, context);
                return null;
            }

            @Override
            public Void timestampShape(TimestampShape shape) {
                writer.write("$T.validate_types!($L, $T, context: $L)",
                    Hearth.VALIDATOR, input, RubyImportContainer.TIME, context);
                return null;
            }
        }
    }
}
