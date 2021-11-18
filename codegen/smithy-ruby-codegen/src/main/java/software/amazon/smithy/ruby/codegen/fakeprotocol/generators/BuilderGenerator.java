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

package software.amazon.smithy.ruby.codegen.fakeprotocol.generators;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class BuilderGenerator extends ShapeVisitor.Default<Void> {

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedBuilders;
    private final RubyCodeWriter writer;

    public BuilderGenerator(GenerationContext context) {
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.generatedBuilders = new HashSet<>();
        this.context = context;
        this.writer = new RubyCodeWriter();
    }

    public void render(FileManifest fileManifest) {

        writer
                .write("require 'base64'\n")
                .openBlock("module $L", settings.getModule())
                .openBlock("module Builders")
                .call(() -> renderBuilders())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/builders.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderBuilders() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderBuildersForOperation(o));
    }

    private void renderBuildersForOperation(OperationShape operation) {
        // Operations MUST have an Input type, even if it is empty
        if (!operation.getInput().isPresent()) {
            throw new RuntimeException("Missing Input Shape for: " + operation.getId());
        }
        ShapeId inputShapeId = operation.getInput().get();

        Shape inputShape = model.expectShape(inputShapeId);

        writer
                .write("\n# Operation Builder for $L", operation.getId().getName())
                .openBlock("class $L", operation.getId().getName())
                .openBlock("def self.build(http_req, input:)")
                .closeBlock("end")
                .closeBlock("end");

        generatedBuilders.add(operation.toShapeId());

        Iterator<Shape> it = new Walker(model).iterateShapes(inputShape);
        while (it.hasNext()) {
            Shape s = it.next();
            if (!generatedBuilders.contains(s.getId())) {
                generatedBuilders.add(s.getId());
                s.accept(this);
            } else {
                System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
            }
        }
    }

    @Override
    public Void structureShape(StructureShape shape) {
        writer
                .write("\n# Structure Builder for $L", shape.getId().getName())
                .openBlock("class $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape shape) {
        writer
                .write("\n# List Builder for $L", shape.getId().getName())
                .openBlock("class $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("[]")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        writer
                .write("\n# Map Builder for $L", shape.getId().getName())
                .openBlock("class $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape shape) {
        writer
                .write("\n# Set Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("Set.new")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        writer
                .write("\n# Set Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }
}



