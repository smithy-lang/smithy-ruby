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

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.OperationIndex;
import software.amazon.smithy.model.knowledge.TopDownIndex;
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
import software.amazon.smithy.model.shapes.ResourceShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestCase;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestsTrait;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestCase;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestsTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;

public class HttpProtocolTestGenerator {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;

    public HttpProtocolTestGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Protocol", true);
    }

    public void render() {
        //TODO: Support filtering of tests through config
        FileManifest fileManifest = context.getFileManifest();

        writer
                .write("require '$L'\n", settings.getGemName())
                .openBlock("module $L", settings.getModule())
                .openBlock("describe Client do")
                // TODO: Ability to inject additional required config, eg credentials
                .write("let(:endpoint) { 'http://127.0.0.1' } ")
                .write("let(:client) { Client.new(stub_responses: true, endpoint: endpoint) }")
                .write("")
                .call(() -> renderTests())
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/spec/protocol_spec.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderTests() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
            writer.openBlock("describe '#$L' do", operationName);
            operation.getTrait(HttpRequestTestsTrait.class).ifPresent((requestTests) -> {
                renderRequestTests(operationName, operation.getInput(), requestTests);
            });
            writer.write("");
            operation.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                renderResponseTests(operationName, operation.getOutput(), responseTests);
            });
            renderErrorTests(operation);
            writer.closeBlock("end");
        });
    }

    private void renderResponseTests(String operationName,
                                     Optional<ShapeId> output,
                                     HttpResponseTestsTrait responseTests) {
        Shape outputShape = model.expectShape(output.orElseThrow(IllegalArgumentException::new));

        writer.openBlock("describe 'responses' do");
        responseTests.getTestCases().forEach((testCase) -> {
            writer
                    .call(() -> renderTestDocumentation(testCase.getDocumentation()))
                    .openBlock("it '$L' do", testCase.getId())
                    .call(() -> renderResponseMiddleware(testCase))
                    .write("middleware.remove_send.remove_build")
                    .write("output = client.$L({}, middleware: middleware)", operationName)
                    .write("expect(output.to_h).to eq($L)",
                            getRubyHashFromParams(outputShape, testCase.getParams(),
                                    ParamsToHashVisitor.TestType.RESPONSE))
                    .closeBlock("end");
        });
        writer.closeBlock("end");
    }

    private void renderRequestTests(String operationName,
                                    Optional<ShapeId> input,
                                    HttpRequestTestsTrait requestTests) {
        Shape inputShape = model.expectShape(input.orElseThrow(IllegalArgumentException::new));
        writer.openBlock("describe 'requests' do");
        requestTests.getTestCases().forEach((testCase) -> {
            writer
                    .write("") //formatting
                    .call(() -> renderTestDocumentation(testCase.getDocumentation()))
                    .openBlock("it '$L' do", testCase.getId())
                    .call(() -> renderRequestMiddleware(testCase))
                    .write("client.$L($L, middleware: middleware)", operationName,
                            getRubyHashFromParams(inputShape, testCase.getParams(),
                                    ParamsToHashVisitor.TestType.REQUEST))
                    .closeBlock("end");
        });
        writer.closeBlock("end");
    }

    private void renderErrorTests(OperationShape operation) {
        String operationName =
                RubyFormatter.toSnakeCase(operation.getId().getName());

        for (StructureShape error : OperationIndex.of(model).getErrors(operation)) {
            error.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                writer.openBlock("describe '$L Errors' do", error.getId().getName());
                responseTests.getTestCases().forEach((testCase) -> {
                    writer
                            .call(() -> renderTestDocumentation(testCase.getDocumentation()))
                            .openBlock("it '$L' do", testCase.getId())
                            .call(() -> renderResponseMiddleware(testCase))
                            .write("middleware.remove_send.remove_build")
                            .openBlock("begin")
                            .write("client.$L({}, middleware: middleware)", operationName)
                            .dedent()
                            .write("rescue Errors::$L => e", error.getId().getName())
                            .indent()
                            .write("expect(e.data.to_h).to eq($L)",
                                    getRubyHashFromParams(error, testCase.getParams(),
                                            ParamsToHashVisitor.TestType.RESPONSE))
                            .closeBlock("end")
                            .closeBlock("end");
                });
                writer.closeBlock("end");
            });
        }
    }

    private void renderTestDocumentation(Optional<String> documentation) {
        if (documentation.isPresent()) {
            writer.rdoc(() -> {
                writer.write(documentation.get());
            });
        }
    }

    private String getRubyHashFromParams(Shape ioShape, ObjectNode params, ParamsToHashVisitor.TestType testType) {
        return ioShape.accept(new ParamsToHashVisitor(model, params, testType, symbolProvider));
    }

    private String getRubyHashFromMap(Map<String, String> map) {
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        StringBuffer buffer = new StringBuffer("{ ");
        while (iterator.hasNext()) {
            Map.Entry header = iterator.next();
            buffer.append("'");
            buffer.append(header.getKey());
            buffer.append("' => '");
            buffer.append(header.getValue());
            buffer.append("'");
            if (iterator.hasNext()) {
                buffer.append(", ");
            }
        }
        buffer.append(" }");
        return buffer.toString();
    }

    private String getRubyArrayFromList(List<String> list) {
        Iterator iterator = list.iterator();
        StringBuffer buffer = new StringBuffer("[");
        while (iterator.hasNext()) {
            String element = (String) iterator.next();
            buffer.append("'");
            buffer.append(element);
            buffer.append("'");
            if (iterator.hasNext()) {
                buffer.append(", ");
            }
        }
        buffer.append("]");
        return buffer.toString();
    }

    private void renderResponseMiddleware(HttpResponseTestCase testCase) {
        writer
                .openBlock("middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|")
                .write("response = context.response")
                .write("response.status = $L", testCase.getCode())
                .call(() -> renderResponseMiddlewareHeaders(testCase.getHeaders()))
                .call(() -> renderResponseMiddlewareBody(testCase.getBody()))
                .write("Seahorse::Output.new")
                .closeBlock("end");
    }

    private void renderResponseMiddlewareBody(Optional<String> body) {
        if (body.isPresent()) {
            writer.write("response.body = StringIO.new('$L')", body.get());
        }
    }

    private void renderResponseMiddlewareHeaders(Map<String, String> headers) {
        if (!headers.isEmpty()) {
            writer.write("response.headers = Seahorse::HTTP::Headers.new(headers: $L)", getRubyHashFromMap(headers));
        }
    }

    private void renderRequestMiddleware(HttpRequestTestCase testCase) {
        writer
                .openBlock("middleware = Seahorse::MiddlewareBuilder.before_send do |input, context|")
                .write("request = context.request")
                .write("request_uri = URI.parse(request.url)")
                .write("expect(request.http_method).to eq('$L')", testCase.getMethod())
                .write("expect(request_uri.path).to eq('$L')", testCase.getUri())
                .call(() -> renderRequestMiddlewareQueryParams(testCase.getQueryParams()))
                .call(() -> renderRequestMiddlewareForbidQueryParams(testCase.getForbidQueryParams()))
                .call(() -> renderRequestMiddlewareRequireQueryParams(testCase.getRequireQueryParams()))
                .call(() -> renderRequestMiddlewareHeaders(testCase.getHeaders()))
                .call(() -> renderRequestMiddlewareForbiddenHeaders(testCase.getForbidHeaders()))
                .call(() -> renderRequestMiddlewareRequiredHeaders(testCase.getRequireHeaders()))
                .call(() -> renderRequestMiddlewareBody(testCase.getBody(), testCase.getBodyMediaType()))
                .write("Seahorse::Output.new")
                .closeBlock("end");
    }

    private void renderRequestMiddlewareBody(Optional<String> body, Optional<String> bodyMediaType) {
        // TODO: expand support for different body media types (eg xml).
        if (body.isPresent()) {
            if (bodyMediaType.isPresent()) {
                switch (bodyMediaType.get()) {
                    case "application/json":
                        writer.write("expect(JSON.parse(request.body.read)).to eq(JSON.parse('$L'))", body.get());
                        break;
                    default:
                        writer.write("expect(request.body.read).to eq('$L')", body.get());
                        break;
                }
            } else {
                writer.write("expect(request.body.read).to eq('$L')", body.get());
            }
        }
    }

    private void renderRequestMiddlewareHeaders(Map<String, String> headers) {
        if (!headers.isEmpty()) {
            writer.write("$L.each { |k, v| expect(request.headers[k]).to eq(v) } ", getRubyHashFromMap(headers));
        }
    }

    private void renderRequestMiddlewareForbiddenHeaders(List<String> forbiddenHeaders) {
        if (!forbiddenHeaders.isEmpty()) {
            writer.write("$L.each { |k| expect(request.headers.key?(k)).to be(false) } ",
                    getRubyArrayFromList(forbiddenHeaders));
        }
    }

    private void renderRequestMiddlewareRequiredHeaders(List<String> requiredHeaders) {
        if (!requiredHeaders.isEmpty()) {
            writer.write("$L.each { |k| expect(request.headers.key?(k)).to be(true) } ",
                    getRubyArrayFromList(requiredHeaders));
        }
    }

    private void renderRequestMiddlewareQueryParams(List<String> queryParams) {
        if (!queryParams.isEmpty()) {
            writer
                    .write("expected_query = CGI.parse($L.join('&'))", getRubyArrayFromList(queryParams))
                    .write("actual_query = CGI.parse(request_uri.query)")
                    .openBlock("expected_query.each do |k, v|")
                    .write("expect(v).to eq(actual_query[k])")
                    .closeBlock("end");
        }
    }

    private void renderRequestMiddlewareForbidQueryParams(List<String> forbidQueryParams) {
        if (!forbidQueryParams.isEmpty()) {
            writer
                    .write("forbid_query = $L", getRubyArrayFromList(forbidQueryParams))
                    .write("actual_query = CGI.parse(request_uri.query)")
                    .openBlock("forbid_query.each do |query|")
                    .write("expect(actual_query.key?(query)).to be false")
                    .closeBlock("end");
        }
    }

    private void renderRequestMiddlewareRequireQueryParams(List<String> requireQueryParams) {
        if (!requireQueryParams.isEmpty()) {
            writer
                    .write("require_query = $L", getRubyArrayFromList(requireQueryParams))
                    .write("actual_query = CGI.parse(request_uri.query)")
                    .openBlock("require_query.each do |query|")
                    .write("expect(actual_query.key?(query)).to be true")
                    .closeBlock("end");
        }
    }

    private static class ParamsToHashVisitor implements ShapeVisitor<String> {

        private final Node node;
        private final Model model;
        private final TestType testType;
        private final SymbolProvider symbolProvider;

        ParamsToHashVisitor(Model model, Node node, TestType testType, SymbolProvider symbolProvider) {
            this.node = node;
            this.model = model;
            this.testType = testType;
            this.symbolProvider = symbolProvider;
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
        public String listShape(ListShape shape) {
            if (node.isNullNode()) {
                return "nil";
            }
            ArrayNode arrayNode = node.expectArrayNode();
            Shape target = model.expectShape(shape.getMember().getTarget());

            String elements = arrayNode.getElements().stream()
                    .map((element) -> target.accept(new ParamsToHashVisitor(model, element, testType, symbolProvider)))
                    .collect(Collectors.joining(", "));

            return "[" + elements + "]";
        }

        @Override
        public String setShape(SetShape shape) {
            if (node.isNullNode()) {
                return "nil";
            }
            ArrayNode arrayNode = node.expectArrayNode();
            Shape target = model.expectShape(shape.getMember().getTarget());

            String elements = arrayNode.getElements().stream()
                    .map((element) -> target.accept(new ParamsToHashVisitor(model, element, testType, symbolProvider)))
                    .collect(Collectors.joining(", "));

            return "[" + elements + "]";
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
                            + target.accept(new ParamsToHashVisitor(model, members.get(k), testType, symbolProvider)))
                    .collect(Collectors.joining(", "));

            return "{" + memberStr + "}";
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
            if (node.isNullNode()) {
                return "nil";
            }
            NumberNode numberNode = node.expectNumberNode();
            return numberNode.getValue().toString();
        }

        @Override
        public String documentShape(DocumentShape shape) {
            return node.accept(new NodeToHashVisitor());
        }

        @Override
        public String doubleShape(DoubleShape shape) {
            if (node.isNullNode()) {
                return "nil";
            }
            NumberNode numberNode = node.expectNumberNode();
            return numberNode.getValue().toString();
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
        public String operationShape(OperationShape shape) {
            return null;
        }

        @Override
        public String resourceShape(ResourceShape shape) {
            return null;
        }

        @Override
        public String serviceShape(ServiceShape shape) {
            return null;
        }

        @Override
        public String stringShape(StringShape shape) {
            if (node.isNullNode()) {
                return "nil";
            }
            StringNode stringNode = node.expectStringNode();
            return "'" + stringNode.getValue() + "'";
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
                                .accept(new ParamsToHashVisitor(model, members.get(k), testType, symbolProvider));
                    })
                    .collect(Collectors.joining(", "));

            return "{" + memberStr + "}";
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
                                .accept(new ParamsToHashVisitor(model, members.get(k), testType, symbolProvider));
                    })
                    .collect(Collectors.joining(", "));
            return "{" + memberStr + "}";
        }

        @Override
        public String memberShape(MemberShape shape) {
            return null;
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

        enum TestType {
            REQUEST,
            RESPONSE
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
