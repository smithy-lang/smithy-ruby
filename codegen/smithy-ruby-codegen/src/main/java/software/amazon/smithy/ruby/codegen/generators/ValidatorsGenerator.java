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

import java.util.Comparator;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.*;
import software.amazon.smithy.model.traits.EnumTrait;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.*;

public class ValidatorsGenerator extends ShapeVisitor.Default<Void>  {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyTypesWriter typesWriter;
    private final RubyTypeMapper typeMapper;

    public ValidatorsGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.typesWriter = new RubyTypesWriter();
        this.typeMapper = new RubyTypeMapper(context.getModel());
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Params")
                .call(() -> renderParams())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/params.rb";
        fileManifest.writeFile(fileName, writer.toString());

    }

    private void renderParams() {
        Stream<OperationShape> operations = model.shapes(OperationShape.class);
        operations.forEach(o -> renderParamsForOperation(writer, o));
    }

    private void renderParamsForOperation(RubyCodeWriter writer, OperationShape operation) {
        System.out.println("Generating builders for Operation: " + operation.getId());

        //TODO: An optional check on the Output Type being present
        if (!operation.getInput().isPresent()) {
            System.out.println("\tSKIPPING.  No Output type.");
            return;
        }
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    @Override
    public Void structureShape(StructureShape shape) {
        if (shape.hasTrait(ErrorTrait.class)) {
            System.out.println("Skipping " + shape.getId() + " because it is an error type.");
            return null;
        }
        System.out.println("Visit Structure Shape: " + shape.getId());
        String shapeName = shape.getId().getName();
        String membersBlock;

        if (shape.members().isEmpty()) {
            membersBlock = "nil";
        } else {
            membersBlock = shape
                    .members()
                    .stream()
                    .map(memberShape -> RubyFormatter.asSymbol(memberShape.getMemberName()))
                    .collect(Collectors.joining(",\n"));
        }
        membersBlock += ",";

        writer
                .write("")
                .openBlock(shapeName + " = Struct.new(")
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(")");

        String initTypes = shape.members().stream()
                .map(m -> "?" + RubyFormatter.toSnakeCase(m.getMemberName()) + ": " + typeFor(targetShape(m)))
                .collect(Collectors.joining(", "));

        String memberAttrTypes = shape.members().stream()
                .map(m -> "attr_accessor " + RubyFormatter.toSnakeCase(m.getMemberName()) + "(): " + typeFor(targetShape(m)))
                .collect(Collectors.joining("\n"));

        typesWriter
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
        String rubyType = m.accept(typeMapper);
        System.out.println("\t\tMapping to ruby type: " + m.getId() + " Smithy Type: " + m.getType() + " -> " + rubyType);
        return rubyType;
    }
}
