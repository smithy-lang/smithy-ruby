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

import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;

/**
 * Maps Shapes to their RBS type (eg string to String, list to Array[Type]).
 */
public class RubyTypeMapper extends ShapeVisitor.Default<String> {
    private final Model model;

    public RubyTypeMapper(Model model) {
        this.model = model;
    }

    @Override
    protected String getDefault(Shape shape) {
        return "untyped";
    }

    @Override
    public String booleanShape(BooleanShape shape) {
        return "bool";
    }

    @Override
    public String listShape(ListShape shape) {
        Shape member = model.expectShape(shape.getMember().getTarget());
        return "Array[" + member.accept(this) + "]";
    }

    @Override
    public String setShape(SetShape shape) {
        return "Set"; //TODO: Is this right?
    }

    @Override
    public String byteShape(ByteShape shape) {
        return "Integer";
    }

    @Override
    public String shortShape(ShortShape shape) {
        return "Integer";
    }

    @Override
    public String integerShape(IntegerShape shape) {
        return "Integer";
    }

    @Override
    public String longShape(LongShape shape) {
        return "Integer";
    }

    @Override
    public String floatShape(FloatShape shape) {
        return "Float";
    }

    @Override
    public String doubleShape(DoubleShape shape) {
        return "Float";
    }

    @Override
    public String bigIntegerShape(BigIntegerShape shape) {
        return "BigNum";
    }

    @Override
    public String mapShape(MapShape shape) {
        //TODO: Infer type of value
        // is symbol the right type for key or should it be String?
        return "Hash[Symbol, untyped]";
    }

    @Override
    public String stringShape(StringShape shape) {
        return "String";
    }

    @Override
    public String structureShape(StructureShape shape) {
        return shape.getId().getName();
    }

    @Override
    public String unionShape(UnionShape shape) {
        return shape.getId()
                .getName(); //TODO: Right now this will jsut be a struct.  but pending union type
    }

    @Override
    public String timestampShape(TimestampShape shape) {
        return "Time";
    }
}
