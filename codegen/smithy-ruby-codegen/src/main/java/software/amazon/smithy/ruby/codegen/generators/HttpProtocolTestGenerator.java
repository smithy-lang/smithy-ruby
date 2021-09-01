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

import java.util.Locale;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.protocoltests.traits.HttpRequestTestsTrait;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestsTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

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
        this.symbolProvider = context.getSymbolProvider();
    }

    public void render() {
        //TODO: Skip writing of file if no tests defined
        //TODO: Support filtering of tests through config
        FileManifest fileManifest = context.getFileManifest();

        writer
                .write("require 'webmock/rspec'\n") // TODO: Add to test dependencies?
                .openBlock("module $L", settings.getModule())
                .openBlock("describe Client do")
                // TODO: Ability to inject additional required config, eg credentials
                .write("let(:endpoint) { 'http://127.0.0.1' } ")
                .write("let(:client) { Client.new(endpoint: endpoint) }")
                .write("\n")
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
            String operationName =
                    RubyFormatter.toSnakeCase(operation.getId().getName());
            writer.openBlock("describe '#$L' do", operationName);
            operation.getTrait(HttpRequestTestsTrait.class).ifPresent((requestTests) -> {
                renderRequestTests(operation, requestTests);
            });

            operation.getTrait(HttpResponseTestsTrait.class).ifPresent((responseTests) -> {
                renderResponseTests(operation, responseTests);
            });
            writer.closeBlock("end");

        });
    }

    private void renderResponseTests(OperationShape operation, HttpResponseTestsTrait responseTests) {
        writer.openBlock("describe 'responses' do");
        writer.closeBlock("end");
    }

    private void renderRequestTests(OperationShape operation, HttpRequestTestsTrait requestTests) {
        String operationName =
                RubyFormatter.toSnakeCase(operation.getId().getName());

        writer.openBlock("describe 'requests' do");
        requestTests.getTestCases().forEach((testCase) -> {
            String responseBody = "{}";
            writer.openBlock("\nit '$L' do", testCase.getId());
            writer.write("stub_request(:$L, \"#{endpoint}$L\")", testCase.getMethod().toLowerCase(Locale.ROOT),
                    testCase.getUri())
                    .indent()
                    // TODO: This is not protocol agnostic.
                    // We need some way to skip any parsing and return from the stack.
                    .write(".to_return(body: '$L')", responseBody)
                    .dedent();
            // TODO: convert the params
            writer.write("client.$L($L)", operationName, "id: '1'");

            writer.closeBlock("end");
        });
        writer.closeBlock("end");
    }
}
