/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

package software.amazon.smithy.ruby.codegen.util;

import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntEnumShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.traits.DefaultTrait;

/**
 * Default value constrains:
 * enum: can be set to any valid string value of the enum.
 * intEnum: can be set to any valid integer value of the enum.
 * document: can be set to null, `true, false, string, numbers, an empty list, or an empty map.
 * list: can only be set to an empty list.
 * map: can only be set to an empty map.
 * structure: no default value.
 * union: no default value.
 * <p>
 * See https://awslabs.github.io/smithy/2.0/spec/type-refinement-traits.html?highlight=required#default-value-constraints
 */
public final class DefaultValueRetriever extends ShapeVisitor.Default<String> {

    private final Node defaultNode;

    public DefaultValueRetriever(MemberShape memberShape) {
        this.defaultNode = memberShape.expectTrait(DefaultTrait.class).toNode();
    }

    @Override
    protected String getDefault(Shape shape) {
        return "nil";
    }

    @Override
    public String blobShape(BlobShape shape) {
        return getDefaultString();
    }

    @Override
    public String booleanShape(BooleanShape shape) {
        return getDefaultBoolean();
    }

    @Override
    public String stringShape(StringShape shape) {
        return getDefaultString();
    }

    @Override
    public String byteShape(ByteShape shape) {
        return String.valueOf(getDefaultNumber().byteValue());
    }

    @Override
    public String shortShape(ShortShape shape) {
        return String.valueOf(getDefaultNumber().shortValue());
    }

    @Override
    public String integerShape(IntegerShape shape) {
        return String.valueOf(getDefaultNumber().intValue());
    }

    @Override
    public String longShape(LongShape shape) {
        return String.valueOf(getDefaultNumber().longValue());
    }

    @Override
    public String floatShape(FloatShape shape) {
        return String.valueOf(getDefaultNumber().doubleValue()) + ".to_f";
    }

    @Override
    public String doubleShape(DoubleShape shape) {
        return String.valueOf(getDefaultNumber().doubleValue()) + ".to_f";
    }

    @Override
    public String bigIntegerShape(BigIntegerShape shape) {
        return String.valueOf(getDefaultNumber().intValue());
    }

    @Override
    public String bigDecimalShape(BigDecimalShape shape) {
        return String.valueOf(getDefaultNumber().floatValue());
    }

    @Override
    public String enumShape(EnumShape shape) {
        return getDefaultString();
    }

    @Override
    public String intEnumShape(IntEnumShape shape) {
        return String.valueOf(getDefaultNumber().intValue());
    }

    @Override
    public String listShape(ListShape shape) {
        if (defaultNode.asArrayNode().isPresent()) {
            return "[]";
        }
        return "nil";
    }

    @Override
    public String mapShape(MapShape shape) {
        if (defaultNode.asObjectNode().isPresent()) {
            return "{}";
        }
        return "nil";
    }

    @Override
    public String documentShape(DocumentShape shape) {
        if (defaultNode.asNumberNode().isPresent()) {
            return getDefaultNumber().toString();
        }

        if (defaultNode.asBooleanNode().isPresent()) {
            return getDefaultBoolean();
        }

        if (defaultNode.asStringNode().isPresent()) {
            return getDefaultString();
        }

        if (defaultNode.asArrayNode().isPresent()) {
            return "[]";
        }

        if (defaultNode.asObjectNode().isPresent()) {
            return "{}";
        }

        return "nil";
    }

    @Override
    public String timestampShape(TimestampShape shape) {
        if (defaultNode.isStringNode()) {
            return "Time.parse(" + getDefaultString() + ")";
        } else if (defaultNode.isNumberNode()) {
            return "Time.at(" + String.valueOf(getDefaultNumber()) + ")";
        } else {
            return "nil";
        }
    }

    private String getDefaultString() {
        return String.format("\"%s\"", defaultNode.expectStringNode().getValue());
    }

    private String getDefaultBoolean() {
        return String.valueOf(defaultNode.expectBooleanNode().getValue());
    }

    private Number getDefaultNumber() {
        return defaultNode.expectNumberNode().getValue();
    }
}
