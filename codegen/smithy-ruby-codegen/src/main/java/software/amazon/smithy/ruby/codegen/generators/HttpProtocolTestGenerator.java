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
import java.util.logging.Logger;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.OperationIndex;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.IdempotencyTokenTrait;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestCase;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestsTrait;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestCase;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestsTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.util.ParamsToHash;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class HttpProtocolTestGenerator {

    private static final Logger LOGGER =
            Logger.getLogger(HttpProtocolTestGenerator.class.getName());

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
                .writePreamble()
                .write("require '$L'\n", settings.getGemName())
                .write("require 'hearth/xml/node_matcher'")
                .write("")
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
        LOGGER.fine("Wrote protocol tests to " + fileName);
    }

    private void renderTests() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        writer.write("");
        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
            writer.openBlock("describe '#$L' do", operationName);
            operation.getTrait(HttpRequestTestsTrait.class).ifPresent((requestTests) -> {
                renderRequestTests(operationName, operation.getInputShape(), requestTests);
            });
            writer.write("");
            operation.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                renderResponseTests(operationName, operation.getOutputShape(), responseTests);
                renderResponseStubberTests(operationName, operation.getOutputShape(), responseTests);
            });
            renderErrorTests(operation);
            writer.closeBlock("\nend\n");
        });
    }

    private void renderResponseTests(String operationName,
                                     ShapeId output,
                                     HttpResponseTestsTrait responseTests) {
        Shape outputShape = model.expectShape(output);

        writer.openBlock("\ndescribe 'responses' do");
        responseTests.getTestCases().forEach((testCase) -> {
            if (testCase.getAppliesTo().isPresent() && testCase.getAppliesTo().get().toString().equals("server")) {
                return;
            }
            String documentation = testCase.getDocumentation().orElse("");
            writer
                    .writeDocstring(documentation)
                    .openBlock("it '$L' do", testCase.getId())
                    .call(() -> renderResponseMiddleware(testCase))
                    .write("middleware.remove_send.remove_build")
                    .write("output = client.$L({}, middleware: middleware)", operationName)
                    .write("expect(output.to_h).to eq($L)",
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .closeBlock("end");
            LOGGER.finer(
                    "Generated protocol response test for operation " + operationName + " test: " + testCase.getId());

        });
        writer.closeBlock("end");
    }

    private void renderResponseStubberTests(String operationName,
                                            ShapeId output,
                                            HttpResponseTestsTrait responseTests) {
        Shape outputShape = model.expectShape(output);

        writer.openBlock("\ndescribe 'response stubs' do");
        responseTests.getTestCases().forEach((testCase) -> {
            if (testCase.getAppliesTo().isPresent() && testCase.getAppliesTo().get().toString().equals("server")) {
                return;
            }
            String documentation = testCase.getDocumentation().orElse("");
            writer
                    .writeDocstring(documentation)
                    .openBlock("it 'stubs $L' do", testCase.getId())
                    .call(() -> renderResponseStubMiddleware(testCase))
                    .write("middleware.remove_build")
                    .write("client.stub_responses(:$L, $L)", operationName,
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .write("output = client.$L({}, middleware: middleware)", operationName)
                    // Note: This part is not required, but its an additional check on parsers
                    .write("expect(output.to_h).to eq($L)",
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .closeBlock("end");
            LOGGER.finer("Generated protocol response stubber test for operation " + operationName + " test: "
                    + testCase.getId());

        });
        writer.closeBlock("end");
    }

    private void renderRequestTests(String operationName,
                                    ShapeId input,
                                    HttpRequestTestsTrait requestTests) {
        Shape inputShape = model.expectShape(input);
        writer.openBlock("\ndescribe 'requests' do");
        requestTests.getTestCases().forEach((testCase) -> {
            if (testCase.getAppliesTo().isPresent() && testCase.getAppliesTo().get().toString().equals("server")) {
                return;
            }
            String documentation = testCase.getDocumentation().orElse("");
            writer
                    .writeDocstring(documentation)
                    .openBlock("it '$L' do", testCase.getId())
                    .call(() -> {
                        if (inputShape.members().stream().anyMatch((m) -> m.hasTrait(IdempotencyTokenTrait.class))) {
                            // auto generated tokens during protocol tests should always be this value
                            writer.write("allow(SecureRandom).to "
                                    + "receive(:uuid).and_return('00000000-0000-4000-8000-000000000000')");
                        }
                    })
                    .call(() -> renderRequestMiddleware(testCase))
                    .write("opts = {middleware: middleware}")
                    .call(() -> {
                        if (testCase.getHost().isPresent()) {
                            writer.write("opts[:endpoint] = 'http://$L'", testCase.getHost().get());
                        }
                    })
                    .write("client.$L($L, **opts)", operationName,
                            getRubyHashFromParams(inputShape, testCase.getParams()))
                    .closeBlock("end");
            LOGGER.finer(
                    "Generated protocol request test for operation " + operationName + " test: " + testCase.getId());

        });
        writer.closeBlock("end");
    }

    private void renderErrorTests(OperationShape operation) {
        String operationName =
                RubyFormatter.toSnakeCase(operation.getId().getName());

        for (StructureShape error : OperationIndex.of(model).getErrors(operation)) {
            error.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                writer.openBlock("\ndescribe '$L Errors' do", error.getId().getName());
                responseTests.getTestCases().forEach((testCase) -> {
                    if (testCase.getAppliesTo().isPresent()
                            && testCase.getAppliesTo().get().toString().equals("server")) {
                        return;
                    }
                    String documentation = testCase.getDocumentation().orElse("");

                    writer
                            .writeDocstring(documentation)
                            .openBlock("it '$L' do", testCase.getId())
                            .call(() -> renderResponseMiddleware(testCase))
                            .write("middleware.remove_send.remove_build")
                            .openBlock("begin")
                            .write("client.$L({}, middleware: middleware)", operationName)
                            .dedent()
                            .write("rescue Errors::$L => e", error.getId().getName())
                            .indent()
                            .write("expect(e.data.to_h).to eq($L)",
                                    getRubyHashFromParams(error, testCase.getParams()))
                            .closeBlock("end")
                            .closeBlock("end");

                    LOGGER.finer("Generated protocol error test for operation " + operationName + " test: "
                            + testCase.getId());

                });
                writer.closeBlock("end");
            });
        }
    }

    private String getRubyHashFromParams(Shape ioShape, ObjectNode params) {
        return ioShape.accept(new ParamsToHash(model, params, symbolProvider));
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
                .openBlock("middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|")
                .write("response = context.response")
                .write("response.status = $L", testCase.getCode())
                .call(() -> renderResponseMiddlewareHeaders(testCase.getHeaders()))
                .call(() -> renderResponseMiddlewareBody(testCase.getBody()))
                .write("Hearth::Output.new")
                .closeBlock("end");
    }

    private void renderResponseMiddlewareBody(Optional<String> body) {
        if (body.isPresent()) {
            writer.write("response.body = StringIO.new('$L')", body.get());
        }
    }

    private void renderResponseMiddlewareHeaders(Map<String, String> headers) {
        if (!headers.isEmpty()) {
            writer.write("response.headers = Hearth::HTTP::Headers.new(headers: $L)", getRubyHashFromMap(headers));
        }
    }

    private void renderRequestMiddleware(HttpRequestTestCase testCase) {
        writer
                .openBlock("middleware = Hearth::MiddlewareBuilder.before_send do |input, context|")
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
                .write("Hearth::Output.new")
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
                    case "application/xml":
                        if (body.get().length() > 0) {
                            writer
                                    .write("expect(Hearth::XML.parse(request.body.read)).to "
                                                    + "match_xml_node(Hearth::XML.parse('$L'))",
                                            body.get());
                        } else {
                            writer.write("expect(request.body.read).to eq('$L')", body.get());
                        }
                        break;
                    case "application/x-www-form-urlencoded":
                        // query params in the body - parse and compare
                        writer.write("expect(CGI.parse(request.body.read)).to eq(CGI.parse('$L'))", body.get());
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
                    .write("expect(actual_query[k]).to eq(v)")
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

    private void renderResponseStubMiddleware(HttpResponseTestCase testCase) {
        writer
                .openBlock("middleware = Hearth::MiddlewareBuilder.after_send do |input, context|")
                .write("response = context.response")
                .write("expect(response.status).to eq($L)", testCase.getCode())
                .closeBlock("end");
    }
}
