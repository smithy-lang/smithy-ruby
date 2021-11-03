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
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.CaseUtils;
import software.amazon.smithy.utils.OptionalUtils;

public class ValidatorsGenerator extends ShapeVisitor.Default<Void> {
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
        this.symbolProvider = context.getSymbolProvider();
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Validators")
                .call(() -> renderValidators())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/validators.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderValidators() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        OperationIndex operationIndex = OperationIndex.of(model);
        Walker walker = new Walker(model);
        Set<Shape> inputShapes = topDownIndex.getContainedOperations(context.getService()).stream()
                .flatMap(operation -> OptionalUtils.stream(operationIndex.getInput(operation)))
                .flatMap(input -> walker.walkShapes(input).stream())
                .collect(Collectors.toSet());

        inputShapes.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(inputShape -> inputShape.accept(this));
    }

    @Override
    public Void structureShape(StructureShape structureShape) {
        Collection<MemberShape> members = structureShape.members();

        writer
                .write("")
                .openBlock("class $L", structureShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .call(() -> renderValidatorsForStructureMembers(members))
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    private void renderValidatorsForStructureMembers(Collection<MemberShape> members) {
        members.forEach(member -> {
            Shape target = model.expectShape(member.getTarget());
            String symbolName = RubyFormatter.asSymbol(member.getMemberName());
            String input = "input[" + symbolName + "]";
            String context = "\"#{context}[" + symbolName + "]\"";
            target.accept(new MemberValidator(writer, input, context));
        });
    }

    @Override
    public Void mapShape(MapShape mapShape) {
        Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

        writer
                .write("")
                .openBlock("class $L", mapShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .write("Seahorse::Validator.validate!(input, Hash, context: context)")
                .openBlock("input.each do |key, value|")
                .write("Seahorse::Validator.validate!(key, String, Symbol, context: \"#{context}.keys\")")
                .call(() -> valueTarget
                        .accept(new MemberValidator(writer, "value", "\"#{context}[#{key}]\"")))
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
                .openBlock("class $L", listShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .write("Seahorse::Validator.validate!(input, Array, context: context)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberValidator(writer, "element", "\"#{context}[#{index}]\"")))
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
                .openBlock("class $L", setShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .write("Seahorse::Validator.validate!(input, Set, context: context)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberValidator(writer, "element", "\"#{context}[#{index}]\"")))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void unionShape(UnionShape unionShape) {
        String shapeName = unionShape.getId().getName();
        Collection<MemberShape> unionMemberShapes = unionShape.members();

        writer
                .write("")
                .openBlock("class $L", shapeName)
                .openBlock("def self.validate!(input, context:)")
                .write("case input")
                .call(() -> unionMemberShapes.forEach(unionMemberShape -> {
                    String unionMemberName = CaseUtils.toPascalCase(unionMemberShape.getMemberName());
                    writer
                            .write("when Types::" + shapeName + "::" + unionMemberName)
                            .write("  $L.validate!(input.__getobj__, context: context)", unionMemberName);
                }))
                .write("when Types::" + shapeName + "::Unknown")
                .write("  nil")
                .write("else")
                .write("  raise ArgumentError,")
                .write("        \"Expect #{context} to be a union member of \"\\")
                .write("        \"Types::" + shapeName + ", got #{input.class}.\"")
                .write("end") // end switch case
                .closeBlock("end") // end validate method
                .call(() -> renderValidatorsForUnionMembers(unionMemberShapes))
                .closeBlock("end");

        return null;
    }

    private void renderValidatorsForUnionMembers(Collection<MemberShape> members) {
        members.forEach(member -> {
            String name = CaseUtils.toPascalCase(member.getMemberName());
            Shape target = model.expectShape(member.getTarget());

            writer
                    .write("") // formatting
                    .openBlock("class $L", name)
                    .openBlock("def self.validate!(input, context:)")
                    .call(() -> target.accept(new MemberValidator(writer, "input", "context")))
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
        private final String input;
        private final String context;

        MemberValidator(RubyCodeWriter writer, String input,
                        String context) {
            this.writer = writer;
            this.input = input;
            this.context = context;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("Seahorse::Validator.validate!($L, String, context: $L)", input, context);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("Seahorse::Validator.validate!($L, TrueClass, FalseClass, context: $L)", input, context);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String name = shape.getId().getName();
            writer.write("$1L.validate!($2L, context: $3L) if $2L", name, input, context);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            String name = shape.getId().getName();
            writer.write("$1L.validate!($2L, context: $3L) if $2L", name, input, context);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Integer, context: $L)", input, context);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Float, context: $L)", input, context);
            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            writer.write("Seahorse::Validator.validate!($L, "
                    + "Hash, String, Array, TrueClass, FalseClass, Numeric, context: $L)", input, context);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Float, context: $L)", input, context);
            return null;
        }

        @Override
        public Void bigDecimalShape(BigDecimalShape shape) {
            writer.write("Seahorse::Validator.validate!($L, BigDecimal, context: $L)", input, context);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String name = shape.getId().getName();
            writer.write("$1L.validate!($2L, context: $3L) if $2L", name, input, context);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("Seahorse::Validator.validate!($L, String, context: $L)", input, context);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String name = shape.getId().getName();
            writer.write("$1L.validate!($2L, context: $3L) if $2L", name, input, context);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String name = shape.getId().getName();
            writer.write("$1L.validate!($2L, context: $3L) if $2L", name, input, context);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("Seahorse::Validator.validate!($L, Time, context: $L)", input, context);
            return null;
        }
    }
}
