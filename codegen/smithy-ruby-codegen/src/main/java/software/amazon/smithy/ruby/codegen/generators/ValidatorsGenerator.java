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

import java.util.Collection;
import java.util.Comparator;
import java.util.Set;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.OperationIndex;
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
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.utils.OptionalUtils;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ValidatorsGenerator extends ShapeVisitor.Default<Void> {
    private static final Logger LOGGER =
            Logger.getLogger(ValidatorsGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;

    public ValidatorsGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Validators", true);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        writer
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Validators")
                .call(() -> renderValidators())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/validators.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote validators to " + fileName);
    }

    private void renderValidators() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        OperationIndex operationIndex = OperationIndex.of(model);
        Walker walker = new Walker(model);
        Set<Shape> inputShapes = topDownIndex.getContainedOperations(context.getService()).stream()
                .flatMap(operation -> OptionalUtils.stream(operationIndex.getInputShape(operation)))
                .flatMap(input -> walker.walkShapes(input).stream())
                .collect(Collectors.toSet());

        inputShapes.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(inputShape -> inputShape.accept(this));
    }

    @Override
    public Void structureShape(StructureShape structureShape) {
        Collection<MemberShape> members = structureShape.members();
        String name = symbolProvider.toSymbol(structureShape).getName();
        writer
                .write("")
                .openBlock("class $L", name)
                .openBlock("def self.validate!(input, context:)")
                .write("Hearth::Validator.validate!(input, Types::$L, context: context)", name)
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
            target.accept(new MemberValidator(writer, symbolProvider, input, context));
        });
    }

    @Override
    public Void mapShape(MapShape mapShape) {
        Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

        writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(mapShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("Hearth::Validator.validate!(input, ::Hash, context: context)")
                .openBlock("input.each do |key, value|")
                .write("Hearth::Validator.validate!(key, ::String, ::Symbol, context: \"#{context}.keys\")")
                .call(() -> valueTarget
                        .accept(new MemberValidator(writer, symbolProvider, "value", "\"#{context}[:#{key}]\"")))
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
                .write("Hearth::Validator.validate!(input, ::Array, context: context)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberValidator(writer, symbolProvider, "element", "\"#{context}[#{index}]\"")))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape setShape) {
        Shape memberTarget =
                model.expectShape(setShape.getMember().getTarget());

        writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(setShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("Hearth::Validator.validate!(input, ::Set, context: context)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberValidator(writer, symbolProvider, "element", "\"#{context}[#{index}]\"")))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void unionShape(UnionShape unionShape) {
        String shapeName = symbolProvider.toSymbol(unionShape).getName();
        Collection<MemberShape> unionMemberShapes = unionShape.members();

        writer
                .write("")
                .openBlock("class $L", shapeName)
                .openBlock("def self.validate!(input, context:)")
                .write("case input")
                .call(() -> unionMemberShapes.forEach(unionMemberShape -> {
                    String unionMemberName = symbolProvider.toMemberName(unionMemberShape);
                    writer
                            .write("when Types::" + shapeName + "::" + unionMemberName)
                            .indent();
                    model.expectShape(unionMemberShape.getTarget())
                            .accept(new MemberValidator(writer, symbolProvider, "input.__getobj__",
                                    "context"));
                    writer.dedent();
                }))
                .write("else")
                .write("  raise ArgumentError,")
                .write("        \"Expected #{context} to be a union member of \"\\")
                .write("        \"Types::" + shapeName + ", got #{input.class}.\"")
                .write("end") // end switch case
                .closeBlock("end") // end validate method
                .call(() -> renderValidatorsForUnionMembers(unionMemberShapes))
                .closeBlock("end");

        return null;
    }

    @Override
    public Void documentShape(DocumentShape documentShape) {
        writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(documentShape).getName())
                .openBlock("def self.validate!(input, context:)")
                .write("Hearth::Validator.validate!(input, "
                        + "::Hash, ::String, ::Array, ::TrueClass, ::FalseClass, ::Numeric, context: context)")
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
                    .call(() -> target.accept(new MemberValidator(writer, symbolProvider, "input", "context")))
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

        MemberValidator(RubyCodeWriter writer, SymbolProvider symbolProvider, String input,
                        String context) {
            this.writer = writer;
            this.symbolProvider = symbolProvider;
            this.input = input;
            this.context = context;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::String, context: $L)", input, context);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::TrueClass, ::FalseClass, context: $L)", input, context);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer.write("Validators::$1L.validate!($2L, context: $3L) unless $2L.nil?", name, input, context);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer.write("Validators::$1L.validate!($2L, context: $3L) unless $2L.nil?", name, input, context);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Float, context: $L)", input, context);
            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer.write("Validators::$1L.validate!($2L, context: $3L) unless $2L.nil?", name, input, context);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Float, context: $L)", input, context);
            return null;
        }

        @Override
        public Void bigDecimalShape(BigDecimalShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::BigDecimal, context: $L)", input, context);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer.write("Validators::$1L.validate!($2L, context: $3L) unless $2L.nil?", name, input, context);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::String, context: $L)", input, context);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer.write("Validators::$1L.validate!($2L, context: $3L) unless $2L.nil?", name, input, context);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String name = symbolProvider.toSymbol(shape).getName();
            writer.write("Validators::$1L.validate!($2L, context: $3L) unless $2L.nil?", name, input, context);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("Hearth::Validator.validate!($L, ::Time, context: $L)", input, context);
            return null;
        }
    }
}
