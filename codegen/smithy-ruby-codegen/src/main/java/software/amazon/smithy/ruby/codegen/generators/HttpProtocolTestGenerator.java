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
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyDependency;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.traits.SkipTest;
import software.amazon.smithy.ruby.codegen.traits.SkipTestsTrait;
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
        this.symbolProvider = context.symbolProvider();
    }

    /**
     * Render (Generate) the protocol tests.
     */
    public void render() {
        FileManifest fileManifest = context.fileManifest();

        if (TopDownIndex.of(model).getContainedOperations(
                        context.service()).stream()
                .noneMatch((operation) -> operation.hasTrait(HttpRequestTestsTrait.class)
                        || operation.hasTrait(HttpResponseTestsTrait.class))) {
            return;
        }

        writer
                .preamble()
                .includeRequires()
                .write("require_relative 'spec_helper'")
                .write("")
                .openBlock("module $L", settings.getModule())
                .openBlock("describe Client do")
                .openBlock("let(:client) do")
                .openBlock("Client.new(")
                .write("stub_responses: true,")
                .write("validate_input: false,")
                .write("endpoint: 'http://127.0.0.1',")
                .write("retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)")
                .closeBlock(")")
                .closeBlock("end")
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
                    .write("")
                    .writeDocstring(documentation)
                    .openBlock("it '$L'$L do", testCase.getId(), skipTest(operation, testCase.getId(), "response"))
                    .call(() -> renderResponseStubResponse(operation, testCase))
                    .call(() -> renderSkipBuild(operation))
                    .write("output = client.$L({}, "
                                    + "auth_resolver: $T.new)",
                            operationName, Hearth.ANONYMOUS_AUTH_RESOLVER)
                    .call(() -> {
                        if (Streaming.isStreaming(model, outputShape)) {
                            renderStreamingParamReader(outputShape);
                        }
                    })
                    .call(() -> writeBodyMatcher(testCase, outputShape))

                    .closeBlock("end");
        });
        writer.closeBlock("\nend");
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
                    .write("")
                    .writeDocstring(documentation)
                    .openBlock("it 'stubs $L'$L do", testCase.getId(),
                            skipTest(operation, testCase.getId(), "response"))
                    .call(() -> renderResponseStubInterceptor(testCase))
                    .write("interceptor = $T.new(read_after_transmit: proc)", Hearth.INTERCEPTOR)
                    .call(() -> renderSkipBuild(operation))
                    .write("client.stub_responses(:$L, data: $L)", operationName,
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .write("output = client.$L({}, "
                                    + "interceptors: [interceptor], "
                                    + "auth_resolver: $T.new)",
                            operationName, Hearth.ANONYMOUS_AUTH_RESOLVER)
                    // Note: This part is not required, but its an additional check on parsers
                    .call(() -> {
                        if (Streaming.isStreaming(model, outputShape)) {
                            renderStreamingParamReader(outputShape);
                        }
                    })
                    .call(() -> writeBodyMatcher(testCase, outputShape))
                    .closeBlock("end");
        });
        writer.closeBlock("\nend");
    }

    private void writeBodyMatcher(HttpResponseTestCase testCase, Shape outputShape) {
        if (testCase.getBodyMediaType().isPresent()
                && testCase.getBodyMediaType().get().equals("application/cbor")) {
            writer.write("expect(output.data.to_h).to match_cbor($L)",
                            getRubyHashFromParams(outputShape, testCase.getParams()))
                    .addUseImports(RubyDependency.HEARTH_CBOR_MATCHER);
        } else {
            writer.write("expect(output.data.to_h).to eq($L)",
                    getRubyHashFromParams(outputShape, testCase.getParams()));
        }
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
                    .write("")
                    .writeDocstring(documentation)
                    .openBlock("it '$L'$L do", testCase.getId(), skipTest(operation, testCase.getId(), "request"))
                    .call(() -> {
                        if (inputShape.members().stream().anyMatch((m) -> m.hasTrait(IdempotencyTokenTrait.class))) {
                            // auto generated tokens during protocol tests should always be this value
                            writer.write("allow(SecureRandom).to "
                                    + "receive(:uuid).and_return('00000000-0000-4000-8000-000000000000')");
                        }
                    })
                    .call(() -> renderRequestInterceptor(testCase))
                    .write("interceptor = $T.new(read_before_transmit: proc)", Hearth.INTERCEPTOR)
                    .write("opts = {interceptors: [interceptor]}")
                    .call(() -> {
                        if (testCase.getHost().isPresent()) {
                            writer.write("opts[:endpoint] = 'http://$L'", testCase.getHost().get());
                        }
                    })
                    .write("client.$L($L, **opts)", operationName,
                            getRubyHashFromParams(inputShape, testCase.getParams()))
                    .closeBlock("end");
        });
        writer.closeBlock("\nend");
    }

    // Shape should be an OperationShape or a StructureShape with error trait
    private String skipTest(Shape shape, String testCaseId, String testType) {
        if (shape.hasTrait(SkipTestsTrait.class)) {
            Optional<SkipTest> skipTest = shape.expectTrait(SkipTestsTrait.class).skipTest(testCaseId, testType);
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
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        for (StructureShape error : OperationIndex.of(model).getErrors(operation)) {
            error.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                writer.openBlock("\ndescribe '$L error' do", error.getId().getName());
                responseTests.getTestCases().forEach((testCase) -> {
                    if (testCase.getAppliesTo().isPresent()
                            && testCase.getAppliesTo().get().toString().equals("server")) {
                        return;
                    }
                    String documentation = testCase.getDocumentation().orElse("");

                    writer
                            .write("")
                            .writeDocstring(documentation)
                            .openBlock("it '$L'$L do", testCase.getId(),
                                    skipTest(error, testCase.getId(), "response"))
                            .call(() -> renderResponseStubResponse(operation, testCase))
                            .call(() -> renderSkipBuild(operation))
                            .openBlock("begin")
                            .write("output = client.$L({}, "
                                            + "auth_resolver: $T.new)",
                                    operationName, Hearth.ANONYMOUS_AUTH_RESOLVER)
                            .dedent()
                            .write("rescue Errors::$L => e", error.getId().getName())
                            .indent()
                            .write("expect(e.data.to_h).to eq($L)",
                                    getRubyHashFromParams(error, testCase.getParams()))
                            .closeBlock("end")
                            .closeBlock("end");

                    writer
                            .write("")
                            .writeDocstring(documentation)
                            .openBlock("it 'stubs $L'$L do", testCase.getId(),
                                    skipTest(error, testCase.getId(), "response"))
                            .write("client.stub_responses(:$L, error: { class: Errors::$L, data: $L })",
                                    operationName, error.getId().getName(),
                                    getRubyHashFromParams(error, testCase.getParams()))
                            .call(() -> renderSkipBuild(operation))
                            .openBlock("begin")
                            .write("output = client.$L({}, "
                                            + "auth_resolver: $T.new)",
                                    operationName, Hearth.ANONYMOUS_AUTH_RESOLVER)
                            .dedent()
                            .write("rescue Errors::$L => e", error.getId().getName())
                            .indent()
                            .write("expect(e.http_status).to eq($L)", testCase.getCode())
                            .write("expect(e.data.to_h).to eq($L)",
                                    getRubyHashFromParams(error, testCase.getParams()))
                            .closeBlock("end")
                            .closeBlock("end");
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

    private void renderSkipBuild(OperationShape operation) {
        String builderName = "Builders::" + context.symbolProvider().toSymbol(operation).getName();
        writer.write("allow($L).to receive(:build)", builderName);
    }

    private void renderResponseStubResponse(OperationShape operation, HttpResponseTestCase testCase) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        writer
                .write("response = Hearth::HTTP::Response.new")
                .write("response.status = $L", testCase.getCode())
                .call(() -> renderResponseStubHeaders(testCase.getHeaders()))
                .call(() -> renderResponseStubBody(testCase.getBody(), testCase.getBodyMediaType()))
                .write("client.stub_responses(:$L, response)", operationName);
    }

    private void renderResponseStubBody(Optional<String> body, Optional<String> bodyMediaType) {
        if (body.isPresent()) {
            if (bodyMediaType.isPresent()) {
                switch (bodyMediaType.get()) {
                    case "application/cbor":
                        writer.write("response.body.write($T.decode64('$L'))",
                                RubyImportContainer.BASE64, body.get());
                        writer.write("response.body.rewind");
                        return;
                    default:
                        // fallback to standard logic below
                        break;
                }
            }
            writer.write("response.body.write('$L')", body.get());
            writer.write("response.body.rewind");
        }
    }

    private void renderResponseStubHeaders(Map<String, String> headers) {
        Iterator<Map.Entry<String, String>> iterator = headers.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry header = iterator.next();
            writer.write("response.headers['$L'] = '$L'", header.getKey(), header.getValue());
        }
    }

    private void renderRequestInterceptor(HttpRequestTestCase testCase) {
        writer
                .openBlock("proc = proc do |context|")
                .write("request = context.request")
                .write("expect(request.http_method).to eq('$L')", testCase.getMethod())
                .call(() -> renderRequestInterceptorHost(testCase.getResolvedHost()))
                .write("expect(request.uri.path).to eq('$L')", testCase.getUri())
                .call(() -> renderRequestInterceptorQueryParams(testCase.getQueryParams()))
                .call(() -> renderRequestInterceptorForbidQueryParams(testCase.getForbidQueryParams()))
                .call(() -> renderRequestInterceptorRequireQueryParams(testCase.getRequireQueryParams()))
                .call(() -> renderRequestInterceptorHeaders(testCase.getHeaders()))
                .call(() -> renderRequestInterceptorForbiddenHeaders(testCase.getForbidHeaders()))
                .call(() -> renderRequestInterceptorRequiredHeaders(testCase.getRequireHeaders()))
                .call(() -> renderRequestInterceptorBody(testCase.getBody(), testCase.getBodyMediaType()))
                .closeBlock("end");
    }

    private void renderRequestInterceptorHost(Optional<String> resolvedHost) {
        if (resolvedHost.isPresent()) {
            writer.write("expect(request.uri.host).to eq('$L')", resolvedHost.get());
        }
    }

    private void renderRequestInterceptorBody(Optional<String> body, Optional<String> bodyMediaType) {
        if (body.isPresent()) {
            if (bodyMediaType.isPresent()) {
                switch (bodyMediaType.get()) {
                    case "application/json":
                        writer.write("expect(JSON.parse(request.body.read)).to eq(JSON.parse('$L'))", body.get());
                        break;
                    case "application/xml":
                        if (body.get().length() > 0) {
                            writer
                                    .write("expect($1T.parse(request.body.read)).to "
                                                    + "match_xml_node($1T.parse('$2L'))",
                                            Hearth.XML, body.get())
                                    .addUseImports(RubyDependency.HEARTH_XML_MATCHER);
                        } else {
                            writer.write("expect(request.body.read).to eq('$L')", body.get());
                        }
                        break;
                    case "application/x-www-form-urlencoded":
                        writer
                                .write("expect($1T.parse(request.body.read)).to "
                                                + "match_query_params($1T.parse('$2L'))",
                                        RubyImportContainer.CGI, body.get())
                                .addUseImports(RubyDependency.HEARTH_QUERY_PARAM_MATCHER);
                        break;
                    case "application/cbor":
                        writer.write("expect($1T.decode(request.body.read)).to "
                                                + "match_cbor($1T.decode($2T.decode64('$3L')))",
                                        Hearth.CBOR, RubyImportContainer.BASE64, body.get())
                                .addUseImports(RubyDependency.HEARTH_CBOR_MATCHER);
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

    private void renderRequestInterceptorHeaders(Map<String, String> headers) {
        if (!headers.isEmpty()) {
            writer.write("$L.each { |k, v| expect(request.headers[k]).to eq(v) } ", getRubyHashFromMap(headers));
        }
    }

    private void renderRequestInterceptorForbiddenHeaders(List<String> forbiddenHeaders) {
        if (!forbiddenHeaders.isEmpty()) {
            writer.write("$L.each { |k| expect(request.headers.key?(k)).to be(false) } ",
                    getRubyArrayFromList(forbiddenHeaders));
        }
    }

    private void renderRequestInterceptorRequiredHeaders(List<String> requiredHeaders) {
        if (!requiredHeaders.isEmpty()) {
            writer.write("$L.each { |k| expect(request.headers.key?(k)).to be(true) } ",
                    getRubyArrayFromList(requiredHeaders));
        }
    }

    private void renderRequestInterceptorQueryParams(List<String> queryParams) {
        if (!queryParams.isEmpty()) {
            writer
                    .write("expected_query = $T.parse($L.join('&'))",
                            RubyImportContainer.CGI, getRubyArrayFromList(queryParams))
                    .write("actual_query = $T.parse(request.uri.query)",
                            RubyImportContainer.CGI)
                    .openBlock("expected_query.each do |k, v|")
                    .write("expect(actual_query[k]).to eq(v)")
                    .closeBlock("end");
        }
    }

    private void renderRequestInterceptorForbidQueryParams(List<String> forbidQueryParams) {
        if (!forbidQueryParams.isEmpty()) {
            writer
                    .write("forbid_query = $L", getRubyArrayFromList(forbidQueryParams))
                    .write("actual_query = $T.parse(request.uri.query)",
                            RubyImportContainer.CGI)
                    .openBlock("forbid_query.each do |query|")
                    .write("expect(actual_query.key?(query)).to be false")
                    .closeBlock("end");
        }
    }

    private void renderRequestInterceptorRequireQueryParams(List<String> requireQueryParams) {
        if (!requireQueryParams.isEmpty()) {
            writer
                    .write("require_query = $L", getRubyArrayFromList(requireQueryParams))
                    .write("actual_query = $T.parse(request.uri.query)",
                            RubyImportContainer.CGI)
                    .openBlock("require_query.each do |query|")
                    .write("expect(actual_query.key?(query)).to be true")
                    .closeBlock("end");
        }
    }

    private void renderResponseStubInterceptor(HttpResponseTestCase testCase) {
        writer
                .openBlock("proc = proc do |context|")
                .write("expect(context.response.status).to eq($L)", testCase.getCode())
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
