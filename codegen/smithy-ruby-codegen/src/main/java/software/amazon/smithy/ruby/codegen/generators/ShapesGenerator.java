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
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class ShapesGenerator extends ShapeVisitor.Default<Void> {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final SymbolProvider symbolProvider;

    public ShapesGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = context.getSymbolProvider();
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        //TODO: We need some mechanism to do both at once.
        rbsWriter
                .openBlock("module $L", settings.getModule())
                .openBlock("module Shapes");

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Shapes")
                .call(() -> renderShapes())
                .closeBlock("end")
                .closeBlock("end");

        rbsWriter
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/shapes.rb";
        fileManifest.writeFile(fileName, writer.toString());

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/shapes.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
    }

    private void renderShapes() {

        System.out.println(
                "Walking shapes from " + context.getService().getId()
                        + " to find shapes to generate");

        Model modelWithoutTraitShapes = ModelTransformer.create()
                .getModelWithoutTraitShapes(context.getModel());

        Set<Shape> serviceShapes = new TreeSet<>(
                new Walker(modelWithoutTraitShapes)
                        .walkShapes(context.getService()));

        for (Shape shape : serviceShapes) {
            shape.accept(this);
        }
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    @Override
    public Void structureShape(StructureShape structureShape) {
        if (structureShape.hasTrait(ErrorTrait.class)) {
            System.out.println("Skipping " + structureShape.getId()
                    + " because it is an error type.");
            return null;
        }

        Symbol symbol = symbolProvider.toSymbol(structureShape);
        System.out.println("Visit Structure Shape: " + structureShape.getId() + " Symbol: " + symbol);
        String shapeName = symbol.getName();
        String membersBlock;

        if (structureShape.members().isEmpty()) {
            membersBlock = "nil";
        } else {
            membersBlock = structureShape
                    .members()
                    .stream()
                    .map(memberShape -> RubyFormatter.asSymbol(
                            symbolProvider.toMemberName(memberShape)))
                    .collect(Collectors.joining(",\n"));
        }
        membersBlock += ",";

        writer
                .write("")
                .openBlock(shapeName + " = Struct.new(")
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(") do")
                .openBlock("")
                .write("include Seahorse::Structure")
                .openBlock("\ndef self.build(params, context='')")
                .call(() -> renderBuilderForStructureMembers(structureShape.members()))
                .closeBlock("end")
                .closeBlock("end");

        String initTypes = structureShape.members().stream()
                .map(m -> "?" + symbolProvider.toMemberName(m)
                        + ": " + typeFor(targetShape(m)))
                .collect(Collectors.joining(", "));

        String memberAttrTypes = structureShape.members().stream()
                .map(m -> "attr_accessor "
                        + RubyFormatter.toSnakeCase(m.getMemberName()) + "(): "
                        + typeFor(targetShape(m)))
                .collect(Collectors.joining("\n"));

        rbsWriter
                .write("")
                .openBlock("class " + shapeName + " < Struct[untyped]")
                .write("def initialize: (" + initTypes + ") -> untyped")
                .write(memberAttrTypes)
                .write("def self.build: (Hash, String) -> $L", shapeName)
                .closeBlock("end");
        return null;
    }

    private void renderBuilderForStructureMembers(Collection<MemberShape> members) {
        writer
                .write("Seahorse::Validator.validate_hash_like(params, context: context)")
                .write("type = new");

        members.forEach(member -> {
            Shape target = model.expectShape(member.getTarget());
            String memberName = symbolProvider.toMemberName(member);
            String memberSetter = "type." + memberName + " = ";
            String symbolName = RubyFormatter.asSymbol(memberName);
            String input = "params[" + symbolName + "]";
            String context = "\"#{context}[" + symbolName + "]\"";
            target.accept(new ShapesGenerator.MemberBuilder(writer, memberSetter, input, context));
        });

        writer.write("type");
    }

    @Override
    public Void listShape(ListShape listShape) {
        Symbol symbol = symbolProvider.toSymbol(listShape);
        System.out.println("Visit List Shape: " + listShape.getId() + " Symbol: " + symbol);
        String shapeName = listShape.getId().getName();
        String typeName = symbol.getName();
        Shape memberTarget =
                model.expectShape(listShape.getMember().getTarget());

        writer
                .write("")
                .openBlock("class $L < Array", shapeName)
                .openBlock("\ndef self.build(list, context='')")
                .write("Seahorse::Validator.validate!(list, Array, context: context)")
                .openBlock("\ndata = list.each_with_index.map do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberBuilder(writer, "", "element", "\"#{context}[#{index}]\"")))
                .closeBlock("end")
                .write("new(data)")
                .closeBlock("end")
                .closeBlock("end");

        rbsWriter
                .write("")
                .openBlock("class $L < Array[$L]", listShape.getId(), typeName)
                .write("def self.build: (Array, String) -> $L", typeName)
                .closeBlock("end");
        return null;
    }

    @Override
    public Void setShape(SetShape setShape) {
        Symbol symbol = symbolProvider.toSymbol(setShape);
        System.out.println("Visit Set Shape: " + setShape.getId() + " Symbol: " + symbol);
        String shapeName = setShape.getId().getName();
        String typeName = symbol.getName();
        Shape memberTarget =
                model.expectShape(setShape.getMember().getTarget());

        writer
                .write("")
                .openBlock("class $L < Set", shapeName)
                .openBlock("\ndef self.build(set, context='')")
                .write("Seahorse::Validator.validate!(set, Set, context: context)")
                .openBlock("\ndata = set.each_with_index.map do |element, index|")
                .call(() -> memberTarget
                        .accept(new MemberBuilder(writer, "", "element", "\"#{context}[#{index}]\"")))
                .closeBlock("end")
                .write("new(data)")
                .closeBlock("end")
                .closeBlock("end");

        rbsWriter
                .write("")
                .openBlock("class $L < Set[$L]", setShape.getId(), typeName)
                .write("def self.build: (Set, String) -> $L", typeName)
                .closeBlock("end");
        return null;
    }

    @Override
    public Void mapShape(MapShape mapShape) {
        Symbol symbol = symbolProvider.toSymbol(mapShape);
        System.out.println("Visit Map Shape: " + mapShape.getId() + " Symbol: " + symbol);
        String shapeName = mapShape.getId().getName();
        String typeName = symbol.getName();
        Shape valueTarget = model.expectShape(mapShape.getValue().getTarget());


        writer
                .write("")
                .openBlock("class $L < Hash", shapeName)
                .openBlock("\ndef self.build(params, context='')")
                .write("Seahorse::Validator.validate!(params, Hash, context: context)")
                .openBlock("\ntype = new\nparams.each do |key, value|")
                .call(() -> valueTarget
                        .accept(new MemberBuilder(writer, "type[key] = ", "value", "\"#{context}[#{key}]\"")))
                .closeBlock("end")
                .write("type")
                .closeBlock("end")
                .closeBlock("end");

        rbsWriter
                .write("")
                .openBlock("class $L < $L", mapShape.getId(), typeName)
                .write("def self.build: (Hash, String) -> $L", typeName)
                .closeBlock("end");
        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        // TODO: Generate a structure
        return null;
    }

    private Shape targetShape(MemberShape m) {
        return this.context.getModel().expectShape(m.getTarget());
    }

    private String typeFor(Shape m) {
        Symbol symbol = symbolProvider.toSymbol(m);
        return symbol.getName();
    }

    private static class MemberBuilder extends ShapeVisitor.Default<Void> {
        private final RubyCodeWriter writer;
        private final String memberSetter;
        private final String input;
        private final String context;

        MemberBuilder(RubyCodeWriter writer, String memberSetter, String input,
                      String context) {
            this.writer = writer;
            this.memberSetter = memberSetter;
            this.input = input;
            this.context = context;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write(memberSetter + input);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, $4L) if $3L", memberSetter, shapeName, input, context);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, $4L) if $3L", memberSetter, shapeName, input, context);
            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            // TODO: Need to implement a builder?
//            writer.write("Seahorse::Validator.validate!($L, "
//                    + "Hash, String, Array, TrueClass, FalseClass, Numeric, context: $L)", input, context);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, $4L) if $3L", memberSetter, shapeName, input, context);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, $4L) if $3L", memberSetter, shapeName, input, context);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String shapeName = shape.getId().getName();
            writer.write("$1L$2L.build($3L, $4L) if $3L", memberSetter, shapeName, input, context);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write(memberSetter + input); //TODO: does this need a conversion?
            return null;
        }
    }
}
