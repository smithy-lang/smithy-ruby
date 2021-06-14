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

    public ValidatorsGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
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
        Set<Shape> inputShapes = ShapeCollector.inputShapes(model, context.getService().toShapeId(), true);
        Iterator<Shape> iterator = inputShapes.iterator();

        while (iterator.hasNext()) {
            Shape inputShape = iterator.next();
            inputShape.accept(this);

            // formatting
            if (iterator.hasNext()) {
                writer.write("");
            }
        }
    }

    @Override
    public Void structureShape(StructureShape structureShape) {
        Collection<MemberShape> members = structureShape.members();

        writer
                .openBlock("class $L", structureShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .write("v = Seahorse::Validator.new(input, context: context)")
                .call(() -> renderValidatorForMembers(members))
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape mapShape) {
        Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

        writer
                .openBlock("class $L", mapShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .write("v = Seahorse::Validator.new(input, context: context)")
                .openBlock("input.each do |key, value|")
                .write("v.validate_type!(key, String, Symbol)")
                .call(() -> valueTarget.accept(new MemberValidator(model, writer, "value", true)))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape listShape) {
        Shape memberTarget = model.expectShape(listShape.getMember().getTarget());

        writer
                .openBlock("class $L", listShape.getId().getName())
                .openBlock("def self.validate!(input, context:)")
                .write("v = Seahorse::Validator.new(input, context: context)")
                .write("v.validate_type!(input, Array)")
                .openBlock("input.each_with_index do |element, index|")
                .call(() -> memberTarget.accept(new MemberValidator(model, writer, "index", true)))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    private void renderValidatorForMembers(Collection<MemberShape> members) {
        members.forEach(member -> {
            Shape target = model.expectShape(member.getTarget());
            String symbolName = RubyFormatter.asSymbol(member.getMemberName());
            target.accept(new MemberValidator(model, writer, symbolName, false));
        });
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    private static class MemberValidator extends ShapeVisitor.Default<Void> {
        private final Model model;
        private final RubyCodeWriter writer;
        private final String symbolizedName;
        private final boolean validatorIsKey;

        MemberValidator(Model model, RubyCodeWriter writer, String symbolName, boolean validatorIsKey) {
            this.model = model;
            this.writer = writer;
            this.symbolizedName = symbolName;
            this.validatorIsKey = validatorIsKey;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("v.validate_type!($L, String)", symbolizedName);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("v.validate_type!($L, TrueClass, FalseClass)", symbolizedName);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String name = shape.getId().getName();
            writer.write("$L.validate!(input[$L], context: \"#{context}[$L]\")", name, symbolizedName, symbolizedName);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            String name = shape.getId().getName();
            writer.write("$L.validate!(input[$L], context: \"#{context}[$L]\")", name, symbolizedName, symbolizedName);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("v.validate_type!($L, Integer)", symbolizedName);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("v.validate_type!($L, Integer)", symbolizedName);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("v.validate_type!($L, Integer)", symbolizedName);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("v.validate_type!($L, Integer)", symbolizedName);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("v.validate_type!($L, Float)", symbolizedName);
            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            writer.write("v.validate_type!($L, Hash, String, Array, TrueClass, FalseClass, Numeric)", symbolizedName);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write("v.validate_type!($L, Float)", symbolizedName);
            return null;
        }

        @Override
        public Void bigDecimalShape(BigDecimalShape shape) {
            writer.write("v.validate_type!($L, BigDecimal)", symbolizedName);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String name = shape.getId().getName();
            String value;
            String context;

            if (validatorIsKey) {
                value = "value";
                context = "#{key}";
            } else {
                value = "input[" + symbolizedName + "]";
                context = symbolizedName;
            }

            writer.write("$L.validate!($L, context: \"#{context}[$L]\")", name, value, context);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("v.validate_type!($L, String)", symbolizedName);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String name = shape.getId().getName();
            String value;
            String context;

            if (validatorIsKey) {
                value = "element";
                context = "#{index}";
            } else {
                value = "input[" + symbolizedName + "]";
                context = symbolizedName;
            }
            writer.write("$L.validate!($L, context: \"#{context}[$L]\")", name, value, context);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            // TODO what do we do here
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("v.validate_type!($L, Time)", symbolizedName);
            return null;
        }
    }
}
