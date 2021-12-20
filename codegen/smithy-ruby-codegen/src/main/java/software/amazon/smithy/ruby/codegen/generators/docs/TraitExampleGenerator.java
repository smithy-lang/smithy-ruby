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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.Arrays;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.node.ArrayNode;
import software.amazon.smithy.model.node.BooleanNode;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.NodeVisitor;
import software.amazon.smithy.model.node.NullNode;
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
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.ExamplesTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.utils.StringUtils;

public class TraitExampleGenerator {

    private final OperationShape operation;
    private final SymbolProvider symbolProvider;
    private final Model model;
    private final RubyCodeWriter writer;
    private final Optional<String> documentation;
    private final ObjectNode input;
    private final ObjectNode output;
    private final Optional<ExamplesTrait.ErrorExample> error;

    public TraitExampleGenerator(OperationShape operation, SymbolProvider symbolProvider,
                                 Model model, ExamplesTrait.Example example) {
        this.operation = operation;
        this.symbolProvider = symbolProvider;
        this.model = model;
        this.writer = new RubyCodeWriter();
        this.documentation = example.getDocumentation();
        this.input = example.getInput();
        this.output = example.getOutput();
        this.error = example.getError();
    }

    public String generate() {
        Symbol symbol = symbolProvider.toSymbol(operation);
        String operationName =
                RubyFormatter.toSnakeCase(symbol.getName());

        Shape operationInput = model.expectShape(operation.getInput().orElseThrow(IllegalArgumentException::new));
        Shape operationOutput = model.expectShape(operation.getOutput().orElseThrow(IllegalArgumentException::new));

        if (input.isEmpty()) {
            writer.write("resp = client.$L()", operationName);
        } else {
            writer
                    .writeInline("resp = client.$L(", operationName)
                    .writeInline(operationInput.accept(new ParamsToHashVisitor(model, input, symbolProvider)))
                    .write(")")
                    .write("")
                    .write("resp.to_h outputs the following:")
                    .write(operationOutput.accept(new ParamsToHashVisitor(model, output, symbolProvider)));
        }
        return writer.toString();
    }

    private static class ParamsToHashVisitor extends ShapeVisitor.Default<String> {

        private final Node node;
        private final Model model;
        private final SymbolProvider symbolProvider;

        ParamsToHashVisitor(Model model, Node node,
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
                            .accept(new ParamsToHashVisitor(model, element, symbolProvider)))
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
                            .accept(new ParamsToHashVisitor(model, element, symbolProvider)))
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
                                    new ParamsToHashVisitor(model, members.get(k), symbolProvider)))
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
                                .accept(new ParamsToHashVisitor(model, members.get(k), symbolProvider));
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
                                .accept(new ParamsToHashVisitor(model, members.get(k), symbolProvider));
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
            return node.accept(new NodeToHashVisitor());
        }
    }

    private static class NodeToHashVisitor implements NodeVisitor<String> {
        @Override
        public String arrayNode(ArrayNode node) {
            String elements = node.getElements().stream()
                    .map((element) -> element.accept(this))
                    .collect(Collectors.joining(", "));

            return "[" + elements + "]";
        }

        @Override
        public String booleanNode(BooleanNode node) {
            return node.getValue() ? "true" : "false";
        }

        @Override
        public String nullNode(NullNode node) {
            return "nil";
        }

        @Override
        public String numberNode(NumberNode node) {
            return node.getValue().toString();
        }

        @Override
        public String objectNode(ObjectNode node) {
            Map<StringNode, Node> members = node.getMembers();
            String memberStr = members.keySet().stream()
                    .map((k) -> "'" + RubyFormatter.toSnakeCase(k.toString()) + "' => " + members.get(k).accept(this))
                    .collect(Collectors.joining(", "));

            return "{" + memberStr + "}";
        }

        @Override
        public String stringNode(StringNode node) {
            return "'" + node.getValue() + "'";
        }
    }

}
