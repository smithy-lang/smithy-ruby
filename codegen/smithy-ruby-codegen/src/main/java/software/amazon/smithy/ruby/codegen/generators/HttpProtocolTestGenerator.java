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
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.IdempotencyTokenTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestCase;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestsTrait;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestCase;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestsTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.trait.SkipTest;
import software.amazon.smithy.ruby.codegen.trait.SkipTestsTrait;
import software.amazon.smithy.ruby.codegen.util.ParamsToHash;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
/**
 * Generate Protocol Tests.
 */
public class HttpProtocolTestGenerator {

    private static final Logger LOGGER =
            Logger.getLogger(HttpProtocolTestGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;

    /**
     * @param context generation context
     */
    public HttpProtocolTestGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.settings();
        this.model = context.model();
        this.writer = new RubyCodeWriter(context.settings().getModule());
        this.symbolProvider = new RubySymbolProvider(model, settings, "Protocol", true);
    }

    /**
     * Render (Generate) the protocol tests.
     */
    public void render() {
        FileManifest fileManifest = context.fileManifest();

        writer
                .includePreamble()
                .includeRequires()
                .write("require '$L'\n", settings.getGemName())
                .write("require 'hearth/xml/node_matcher'")
                .write("require 'hearth/query/param_matcher'")
                .write("")
                .openBlock("module $L", settings.getModule())
                .openBlock("describe Client do")
                // TODO: Ability to inject additional required config, eg credentials
                .write("let(:endpoint) { 'http://127.0.0.1' } ")
                .write("let(:config) { Config.new(stub_responses: true, endpoint: endpoint) }")
                .write("let(:client) { Client.new(config) }")
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
        topDownIndex.getContainedOperations(context.service()).stream().forEach((operation) -> {
            String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
            writer.openBlock("describe '#$L' do", operationName);
            operation.getTrait(HttpRequestTestsTrait.class).ifPresent((requestTests) -> {
                renderRequestTests(operation, requestTests);
            });
            writer.write("");
            operation.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                renderResponseTests(operation, responseTests);
                renderResponseStubberTests(operation, responseTests);
            });
            renderErrorTests(operation);
            writer.closeBlock("\nend\n");
        });
    }

    private void renderResponseTests(OperationShape operation,
                                     HttpResponseTestsTrait responseTests) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        Shape outputShape = model.expectShape(operation.getOutputShape());

        writer.openBlock("\ndescribe 'responses' do");
        responseTests.getTestCases().forEach((testCase) -> {
            if (testCase.getAppliesTo().isPresent() && testCase.getAppliesTo().get().toString().equals("server")) {
                return;
            }
            String documentation = testCase.getDocumentation().orElse("");
            writer
                    .writeDocstring(documentation)
                    .openBlock("it '$L'$L do", testCase.getId(), skipTest(operation, testCase.getId(), "response"))
                    .call(() -> renderResponseMiddleware(testCase))
                    .write("middleware.remove_send.remove_build.remove_retry")
                    .write("output = client.$L({}, middleware: middleware)", operationName)
                    .call(() -> {
                        if (Streaming.isStreaming(model, outputShape)) {
                            renderStreamingParamReader(outputShape);
                        }
                    })
                    .write("expect(output.data.to_h).to eq($L)",
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .closeBlock("end");
            LOGGER.finer(
                    "Generated protocol response test for operation " + operationName + " test: " + testCase.getId());

        });
        writer.closeBlock("end");
    }

    private void renderResponseStubberTests(OperationShape operation,
                                            HttpResponseTestsTrait responseTests) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        Shape outputShape = model.expectShape(operation.getOutputShape());

        writer.openBlock("\ndescribe 'stubs' do");
        responseTests.getTestCases().forEach((testCase) -> {
            if (testCase.getAppliesTo().isPresent() && testCase.getAppliesTo().get().toString().equals("server")) {
                return;
            }
            String documentation = testCase.getDocumentation().orElse("");
            writer
                    .writeDocstring(documentation)
                    .openBlock("it 'stubs $L'$L do", testCase.getId(),
                            skipTest(operation, testCase.getId(), "response"))
                    .call(() -> renderResponseStubMiddleware(testCase))
                    .write("middleware.remove_build.remove_retry")
                    .write("client.stub_responses(:$L, $L)", operationName,
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .write("output = client.$L({}, middleware: middleware)", operationName)
                    // Note: This part is not required, but its an additional check on parsers
                    .call(() -> {
                        if (Streaming.isStreaming(model, outputShape)) {
                            renderStreamingParamReader(outputShape);
                        }
                    })
                    .write("expect(output.data.to_h).to eq($L)",
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .closeBlock("end");
            LOGGER.finer("Generated protocol stubs test for operation " + operationName + " test: "
                    + testCase.getId());

        });
        writer.closeBlock("end");
    }

    private void renderRequestTests(OperationShape operation, HttpRequestTestsTrait requestTests) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        Shape inputShape = model.expectShape(operation.getInputShape());
        writer.openBlock("\ndescribe 'requests' do");
        requestTests.getTestCases().forEach((testCase) -> {
            if (testCase.getAppliesTo().isPresent() && testCase.getAppliesTo().get().toString().equals("server")) {
                return;
            }
            String documentation = testCase.getDocumentation().orElse("");
            writer
                    .writeDocstring(documentation)
                    .openBlock("it '$L'$L do", testCase.getId(), skipTest(operation, testCase.getId(), "request"))
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

    private String skipTest(OperationShape operation, String testCaseId, String testType) {
        if (operation.hasTrait(SkipTestsTrait.class)) {
            Optional<SkipTest> skipTest = operation.expectTrait(SkipTestsTrait.class).skipTest(testCaseId, testType);
            if (skipTest.isPresent()) {
                if (skipTest.get().getId().equals(testCaseId)) {
                    if (skipTest.get().getReason().isPresent()) {
                        return writer.format(", skip: '$L' ", skipTest.get().getReason().get());
                    } else {
                        return ", skip: true ";
                    }
                }
            }
        }
        return "";
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
                            .write("middleware.remove_send.remove_build.remove_retry")
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
            writer.write("response.headers = Hearth::HTTP::Headers.new($L)", getRubyHashFromMap(headers));
        }
    }

    private void renderRequestMiddleware(HttpRequestTestCase testCase) {
        writer
                .openBlock("middleware = Hearth::MiddlewareBuilder.before_send do |input, context|")
                .write("request = context.request")
                .write("request_uri = URI.parse(request.url)")
                .write("expect(request.http_method).to eq('$L')", testCase.getMethod())
                .call(() -> renderRequestMiddlewareHost(testCase.getResolvedHost()))
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

    private void renderRequestMiddlewareHost(Optional<String> resolvedHost) {
        if (resolvedHost.isPresent()) {
            writer.write("expect(request_uri.host).to eq('$L')", resolvedHost.get());
        }
    }

    private void renderRequestMiddlewareBody(Optional<String> body, Optional<String> bodyMediaType) {
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
                        writer
                                .write("expect(CGI.parse(request.body.read)).to "
                                                + "match_query_params(CGI.parse('$L'))",
                                        body.get());
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

    private void renderStreamingParamReader(Shape outputShape) {
        MemberShape streamingMember = outputShape.members().stream()
                .filter((m) -> m.getMemberTrait(model, StreamingTrait.class).isPresent())
                .findFirst().get();

        String memberName = symbolProvider.toMemberName(streamingMember);

        // rewind and read the stream
        // overwrite the output.data member with the string to allow string compare
        writer
                .write("output.data.$L.rewind", memberName)
                .write("output.data.$1L = output.data.$1L.read", memberName)
                .write("output.data.$1L = nil if output.data.$1L.empty?", memberName);
    }
}
