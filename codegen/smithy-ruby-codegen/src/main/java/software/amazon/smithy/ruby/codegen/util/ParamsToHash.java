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

package software.amazon.smithy.ruby.codegen.util;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.node.ArrayNode;
import software.amazon.smithy.model.node.BooleanNode;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.NumberNode;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.node.StringNode;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
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
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.utils.SmithyInternalApi;
import software.amazon.smithy.utils.StringUtils;

@SmithyInternalApi
public class ParamsToHash extends ShapeVisitor.Default<String> {

    private final Node node;
    private final Model model;
    private final SymbolProvider symbolProvider;

    public ParamsToHash(Model model, Node node,
                        SymbolProvider symbolProvider) {
        this.node = node;
        this.model = model;
        this.symbolProvider = symbolProvider;
    }

    @Override
    protected String getDefault(Shape shape) {
        return "";
    }

    @Override
    public String stringShape(StringShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        StringNode stringNode = node.expectStringNode();
        return StringUtils.escapeJavaString(stringNode.getValue(), "");
    }

    @Override
    public String blobShape(BlobShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        StringNode stringNode = node.expectStringNode();
        return "'" + stringNode.getValue() + "'";
    }

    @Override
    public String booleanShape(BooleanShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        BooleanNode booleanNode = node.expectBooleanNode();
        return booleanNode.getValue() ? "true" : "false";
    }

    @Override
    public String byteShape(ByteShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        NumberNode numberNode = node.expectNumberNode();
        return numberNode.getValue().toString();
    }

    @Override
    public String shortShape(ShortShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        NumberNode numberNode = node.expectNumberNode();
        return numberNode.getValue().toString();
    }

    @Override
    public String integerShape(IntegerShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        NumberNode numberNode = node.expectNumberNode();
        return numberNode.getValue().toString();
    }

    @Override
    public String longShape(LongShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        NumberNode numberNode = node.expectNumberNode();
        return numberNode.getValue().toString();
    }

    @Override
    public String floatShape(FloatShape shape) {
        return rubyFloat();
    }

    @Override
    public String doubleShape(DoubleShape shape) {
        return rubyFloat();
    }

    private String rubyFloat() {
        if (node.isNullNode()) {
            return "nil";
        }
        if (node.isStringNode()) {
            StringNode stringNode = node.expectStringNode();
            switch (stringNode.getValue()) {
                case "NaN":
                    return "Float::NAN";
                case "Infinity":
                    return "Float::INFINITY";
                case "-Infinity":
                    return "-Float::INFINITY";
                default:
                    throw new CodegenException("Unexpected string value for Float shape: "
                            + node
                            + " from: "
                            + node.getSourceLocation());
            }
        } else {
            NumberNode numberNode = node.expectNumberNode();
            return numberNode.getValue().toString();
        }
    }

    @Override
    public String bigIntegerShape(BigIntegerShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        NumberNode numberNode = node.expectNumberNode();
        return numberNode.getValue().toString();
    }

    @Override
    public String bigDecimalShape(BigDecimalShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        NumberNode numberNode = node.expectNumberNode();
        return numberNode.getValue().toString();
    }

    @Override
    public String timestampShape(TimestampShape shape) {
        if (node.isNullNode()) {
            return "";
        }
        if (node.isNumberNode()) {
            return "Time.at(" + node.expectNumberNode().getValue().toString() + ")";
        }
        return "Time.parse('" + node + "')";
    }

    @Override
    public String listShape(ListShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        ArrayNode arrayNode = node.expectArrayNode();
        Shape target = model.expectShape(shape.getMember().getTarget());

        String elements = arrayNode.getElements().stream()
                .map((element) -> target
                        .accept(new ParamsToHash(model, element, symbolProvider)))
                .collect(Collectors.joining(",\n"));

        return "[\n" + indent(elements) + "\n]";
    }

    @Override
    public String setShape(SetShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        ArrayNode arrayNode = node.expectArrayNode();
        Shape target = model.expectShape(shape.getMember().getTarget());

        String elements = arrayNode.getElements().stream()
                .map((element) -> target
                        .accept(new ParamsToHash(model, element, symbolProvider)))
                .collect(Collectors.joining(",\n"));

        return "[\n" + indent(elements) + "\n]";
    }

    @Override
    public String mapShape(MapShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        ObjectNode objectNode = node.expectObjectNode();
        Shape target = model.expectShape(shape.getValue().getTarget());
        Map<StringNode, Node> members = objectNode.getMembers();

        String memberStr = members.keySet().stream()
                .map((k) -> "'" + k.toString() + "' => "
                        +
                        target.accept(
                                new ParamsToHash(model, members.get(k), symbolProvider)))
                .collect(Collectors.joining(",\n"));

        return "{\n" + indent(memberStr) + "\n}";
    }

    @Override
    public String structureShape(StructureShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        ObjectNode objectNode = node.expectObjectNode();
        Map<StringNode, Node> members = objectNode.getMembers();

        Map<String, MemberShape> shapeMembers = shape.getAllMembers();

        String memberStr = members.keySet().stream()
                .map((k) -> {
                    MemberShape member = shapeMembers.get(k.toString());
                    return symbolProvider.toMemberName(member) + ": "
                            + (model.expectShape(member.getTarget()))
                            .accept(new ParamsToHash(model, members.get(k), symbolProvider));
                })
                .collect(Collectors.joining(",\n"));

        return "{\n" + indent(memberStr) + "\n}";
    }

    @Override
    public String unionShape(UnionShape shape) {
        if (node.isNullNode()) {
            return "nil";
        }
        ObjectNode objectNode = node.expectObjectNode();
        Map<StringNode, Node> members = objectNode.getMembers();
        Map<String, MemberShape> shapeMembers = shape.getAllMembers();

        String memberStr = members.keySet().stream()
                .map((k) -> {
                    MemberShape member = shapeMembers.get(k.toString());
                    return RubyFormatter.toSnakeCase(symbolProvider.toMemberName(member)) + ": "
                            + (model.expectShape(member.getTarget()))
                            .accept(new ParamsToHash(model, members.get(k), symbolProvider));
                })
                .collect(Collectors.joining(", "));
        return "{\n" + indent(memberStr) + "\n}";
    }

    private String indent(String s) {
        return Arrays.stream(s.split("\n"))
                .map((l) -> "  " + l)
                .collect(Collectors.joining("\n"));
    }

    @Override
    public String documentShape(DocumentShape shape) {
        return node.accept(new NodeToHash());
    }
}

