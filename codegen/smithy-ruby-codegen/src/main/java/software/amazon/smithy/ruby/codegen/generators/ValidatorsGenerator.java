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
import java.util.Iterator;
import java.util.Set;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
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
import software.amazon.smithy.ruby.codegen.ShapeCollector;

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
        Set<Shape> inputShapes = ShapeCollector
                .inputShapes(model, context.getService().toShapeId(), true);
        Iterator<Shape> iterator = inputShapes.iterator();

        while (iterator.hasNext()) {
            Shape inputShape = iterator.next();

            writer
                    .openBlock("class $L", inputShape.getId().getName())
                    .openBlock("def self.validate!(input, context:)")
                    .call(() -> inputShape.accept(this))
                    .closeBlock("end")
                    .closeBlock("end");

            // formatting
            if (iterator.hasNext()) {
                writer.write("");
            }
        }
    }

    private String typeFor(Shape m) {
        Symbol symbol = symbolProvider.toSymbol(m);
        System.out.println(
                "\t\tMapping to ruby type: " + m.getId() + " Smithy Type: "
                        + m.getType() + " -> " + symbol);
        return symbol.getName();
    }

    @Override
    public Void structureShape(StructureShape structureShape) {
        Collection<MemberShape> members = structureShape.members();

        members.forEach(member -> {
            Shape target = model.expectShape(member.getTarget());
            String symbolName = RubyFormatter.asSymbol(member.getMemberName());
            String input = "input[" + symbolName + "]";
            target.accept(
                    new MemberValidator(model, writer, input, symbolName));
        });

        return null;
    }

    @Override
    public Void mapShape(MapShape mapShape) {
        Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

        writer
                .write("Seahorse::Validator.validate!(input, Hash, context: context)")
                .openBlock("input.each do |key, value|")
                .write("Seahorse::Validator.validate!(key, String, Symbol, context: \"#{context}.keys\")")
                .call(() -> valueTarget
                        .accept(new MemberValidator(model, writer, "value",
                                "#{index}")))
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape listShape) {
        Shape memberTarget =
                model.expectShape(listShape.getMember().getTarget());

        writer
                .write("Seahorse::Validator.validate!(input, Array, context: context)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberValidator(model, writer, "element",
                                "#{index}")))
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape setShape) {
        Shape memberTarget =
                model.expectShape(setShape.getMember().getTarget());

        writer
                .write("Seahorse::Validator.validate!(input, Set, context: context)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberValidator(model, writer, "element",
                                "#{index}")))
                .closeBlock("end");

        return null;
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    private static class MemberValidator extends ShapeVisitor.Default<Void> {
        private final Model model;
        private final RubyCodeWriter writer;
        private final String input;
        private final String context;

        MemberValidator(Model model, RubyCodeWriter writer, String input,
                        String context) {
            this.model = model;
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
            writer.write(
                    "Seahorse::Validator.validate!($L, String, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, TrueClass, FalseClass, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String name = shape.getId().getName();
            writer.write("$L.validate!($L, context: \"#{context}[$L]\")", name,
                    input, context);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            String name = shape.getId().getName();
            writer.write("$L.validate!($L, context: \"#{context}[$L]\")", name,
                    input, context);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Integer, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Integer, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Integer, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Integer, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Float, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            writer.write("Seahorse::Validator.validate!($L, "
                            +
                            "Hash, String, Array, TrueClass, FalseClass, Numeric, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Float, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void bigDecimalShape(BigDecimalShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, BigDecimal, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String name = shape.getId().getName();
            writer.write("$L.validate!($L, context: \"#{context}[$L]\")", name,
                    input, context);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, String, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String name = shape.getId().getName();
            writer.write("$L.validate!($L, context: \"#{context}[$L]\")", name,
                    input, context);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            // TODO
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write(
                    "Seahorse::Validator.validate!($L, Time, context: \"#{context}[$L]\")",
                    input, context);
            return null;
        }
    }
}
