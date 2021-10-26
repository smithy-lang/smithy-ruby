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

import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class TypesGenerator extends ShapeVisitor.Default<Void> {
    private final GenerationContext context;
    private final RubySettings settings;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final SymbolProvider symbolProvider;

    public TypesGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = context.getSymbolProvider();
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        //TODO: We need some mechanism to do both at once.
        rbsWriter
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types");

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Types")
                .call(() -> renderTypes())
                .closeBlock("end")
                .closeBlock("end");

        rbsWriter
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/types.rb";
        fileManifest.writeFile(fileName, writer.toString());

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/types.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
    }

    private void renderTypes() {

        System.out.println(
                "Walking shapes from " + context.getService().getId()
                        + " to find types to generate");

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
    public Void structureShape(StructureShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        System.out.println("Visit Structure Shape: " + shape.getId() + " Symbol: " + symbol);
        String shapeName = symbol.getName();
        String membersBlock;

        if (shape.members().isEmpty()) {
            membersBlock = "nil";
        } else {
            membersBlock = shape
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
                .closeBlock(") { include Seahorse::Structure }");

        String initTypes = shape.members().stream()
                .map(m -> "?" + symbolProvider.toMemberName(m)
                        + ": " + typeFor(targetShape(m)))
                .collect(Collectors.joining(", "));

        String memberAttrTypes = shape.members().stream()
                .map(m -> "attr_accessor "
                        + RubyFormatter.toSnakeCase(m.getMemberName()) + "(): "
                        + typeFor(targetShape(m)))
                .collect(Collectors.joining("\n"));

        rbsWriter
                .write("")
                .openBlock("class " + shapeName + " < Struct[untyped]")
                .write("def initialize: (" + initTypes + ") -> untyped")
                .write(memberAttrTypes)
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
}
