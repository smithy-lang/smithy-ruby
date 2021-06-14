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

package software.amazon.smithy.ruby.codegen;

import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;

public class ShapeCollector extends ShapeVisitor.Default<Void> {

    private final Model model;
    private final boolean includeCollections;
    private final Set<Shape> collectedShapes;

    public ShapeCollector(Model model, boolean includeCollections) {
        this.model = model;
        this.includeCollections = includeCollections;
        this.collectedShapes = new HashSet<>();
    }

    public static Set<Shape> inputShapes(Model model, ShapeId serviceShapeId,
                                         boolean includeCollections) {
        ShapeCollector collector =
                new ShapeCollector(model, includeCollections);
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        TreeSet<OperationShape> operations =
                new TreeSet<>(topDownIndex.getContainedOperations(
                        model.expectShape(serviceShapeId)));
        for (OperationShape operation : operations) {
            operation.getInput()
                    .map(shapeId -> model.expectShape(shapeId)
                            .accept(collector))
                    .orElseGet(() -> null);
        }
        return collector.collectedShapes;
    }

    public static Set<Shape> outputShapes(Model model, ShapeId serviceShapeId,
                                          boolean includeCollections) {
        ShapeCollector collector =
                new ShapeCollector(model, includeCollections);
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        TreeSet<OperationShape> operations =
                new TreeSet<>(topDownIndex.getContainedOperations(
                        model.expectShape(serviceShapeId)));
        for (OperationShape operation : operations) {
            operation.getOutput()
                    .map(shapeId -> model.expectShape(shapeId)
                            .accept(collector))
                    .orElseGet(() -> null);
        }
        return collector.collectedShapes;
    }

    @Override
    public Void listShape(ListShape shape) {
        if (includeCollections && !collectedShapes.contains(shape)) {
            collectedShapes.add(shape);
            shape.getMember().accept(this);
        }
        return null;
    }

    @Override
    public Void setShape(SetShape shape) {
        if (includeCollections && !collectedShapes.contains(shape)) {
            collectedShapes.add(shape);
            shape.getMember().accept(this);
        }
        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        if (includeCollections && !collectedShapes.contains(shape)) {
            collectedShapes.add(shape);
            shape.getValue().accept(this);
            shape.getKey().accept(this);
        }
        return null;
    }

    @Override
    public Void structureShape(StructureShape shape) {
        if (!collectedShapes.contains(shape)) {
            collectedShapes.add(shape);
            for (MemberShape m : shape.members()) {
                m.accept(this);
            }
        }
        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        if (!collectedShapes.contains(shape)) {
            collectedShapes.add(shape);
            for (MemberShape m : shape.members()) {
                m.accept(this);
            }
        }
        return null;
    }

    @Override
    public Void memberShape(MemberShape shape) {
        model.expectShape(shape.getTarget()).accept(this);
        return null;
    }

    // No action required for other shape types.
    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }
}
