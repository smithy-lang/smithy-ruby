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
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.OperationIndex;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.utils.OptionalUtils;
import software.amazon.smithy.utils.StringUtils;

public class ParamsGenerator extends ShapeVisitor.Default<Void> {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;

    public ParamsGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Params", true);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Params")
                .call(() -> renderParams())
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/params.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderParams() {
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
    protected Void getDefault(Shape shape) {
        return null;
    }

    @Override
    public Void structureShape(StructureShape structureShape) {
        Symbol symbol = symbolProvider.toSymbol(structureShape);
        String shapeName = symbol.getName();

        writer
                .openBlock("module $L", shapeName)
                .openBlock("def self.build(params, context: '')")
                .call(() -> renderBuilderForStructureMembers(shapeName, structureShape.members()))
                .closeBlock("end")
                .closeBlock("end");
        return null;
    }

    private void renderBuilderForStructureMembers(String shapeName, Collection<MemberShape> members) {
        writer
                .write("Seahorse::Validator.validate!(params, Hash, Types::$L, context: context)", shapeName)
                .write("type = Types::$L.new", shapeName);

        members.forEach(member -> {
            Shape target = model.expectShape(member.getTarget());
            String memberName = symbolProvider.toMemberName(member);
            String memberSetter = "type." + memberName + " = ";
            String symbolName = RubyFormatter.asSymbol(memberName);
            String input = "params[" + symbolName + "]";
            String context = "\"#{context}[" + symbolName + "]\"";
            target.accept(new MemberBuilder(writer, memberSetter, input, context, true));
        });

        writer.write("type");
    }

    @Override
    public Void listShape(ListShape listShape) {
        String shapeName = listShape.getId().getName();
        Shape memberTarget =
                model.expectShape(listShape.getMember().getTarget());

        writer
                .openBlock("module $L", shapeName)
                .openBlock("def self.build(params, context: '')")
                .write("Seahorse::Validator.validate!(params, Array, context: context)")
                .openBlock("params.each_with_index.map do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberBuilder(writer, "", "element", "\"#{context}[#{index}]\"", true)))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
        return null;
    }

    @Override
    public Void setShape(SetShape setShape) {
        String shapeName = setShape.getId().getName();
        Shape memberTarget =
                model.expectShape(setShape.getMember().getTarget());

        writer
                .openBlock("module $L", shapeName)
                .openBlock("def self.build(params, context: '')")
                .write("Seahorse::Validator.validate!(params, Set, Array, context: context)")
                .write("data = Set.new")
                .openBlock("params.each_with_index do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberBuilder(writer, "data << ", "element", "\"#{context}[#{index}]\"", true)))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");
        return null;
    }

    @Override
    public Void mapShape(MapShape mapShape) {
        String shapeName = mapShape.getId().getName();
        Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());

        writer
                .openBlock("module $L", shapeName)
                .openBlock("def self.build(params, context: '')")
                .write("Seahorse::Validator.validate!(params, Hash, context: context)")
                .write("data = {}")
                .openBlock("params.each do |key, value|")
                .call(() -> valueTarget
                        .accept(new MemberBuilder(writer, "data[key] = ", "value", "\"#{context}[#{key}]\"", true)))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");
        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        String shapeName = symbol.getName();

        writer
                .openBlock("module $L", shapeName)
                .openBlock("def self.build(params, context: '')")
                .write("return params if params.is_a?(Types::$L)", shapeName)
                .write("Seahorse::Validator.validate!(params, Hash, Types::$L, context: context)", shapeName)
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
            String memberName = RubyFormatter.asSymbol(member.getMemberName());
            writer.write("when $L", memberName)
                    .indent()
                    .openBlock("Types::$L::$L.new(", shapeName, StringUtils.capitalize(member.getMemberName()));
            String input = "params[" + memberName + "]";
            String context = "\"#{context}[" + memberName + "]\"";
            target.accept(new MemberBuilder(writer, "", input, context, false));
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

    private static class MemberBuilder extends ShapeVisitor.Default<Void> {
        private final RubyCodeWriter writer;
        private final String memberSetter;
        private final String input;
        private final String context;
        private final boolean checkRequired;

        MemberBuilder(RubyCodeWriter writer, String memberSetter, String input,
                      String context, boolean checkRequired) {
            this.writer = writer;
            this.memberSetter = memberSetter;
            this.input = input;
            this.context = context;
            this.checkRequired = checkRequired;
        }

        private String checkRequired() {
            if (this.checkRequired) {
                return " if " + input;
            } else {
                return "";
            }
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write(memberSetter + input);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, context: $4L)$5L", memberSetter, shapeName, input, context,
                    checkRequired());
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, context: $4L)$5L", memberSetter, shapeName, input, context,
                    checkRequired());
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, context: $4L)$5L", memberSetter, shapeName, input, context,
                    checkRequired());
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, context: $4L)$5L", memberSetter, shapeName, input, context,
                    checkRequired());
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, context: $4L)$5L", memberSetter, shapeName, input, context,
                    checkRequired());
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write(memberSetter + input);
            return null;
        }
    }
}
