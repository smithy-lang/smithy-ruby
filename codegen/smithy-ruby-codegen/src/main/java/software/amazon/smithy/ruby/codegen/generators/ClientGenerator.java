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

import java.util.Comparator;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.utils.CodeWriter;

public class ClientGenerator {
    private final RubySettings settings;
    private final Stream<OperationShape> operations;

    public ClientGenerator(RubySettings settings, Stream<OperationShape> operations) {
        this.settings = settings;
        this.operations = operations;
    }

    public void render(FileManifest fileManifest) {
        CodeWriter writer = RubyCodeWriter.createDefault();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("class Client")
                .call(() -> renderInitializeMethod(writer))
                .call(() -> renderOperations(writer))
                .write("private")
                .call(() -> renderOutputStreamMethod(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/client.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderInitializeMethod(CodeWriter writer) {
        writer
                .openBlock("def initialize(options = {})")
                .write("@region = NawsRegion.resolve(options)")
                .write("@endpoint = options[:endpoint] || Regions[@region].url(options)")
                .openBlock("@signer = NawsAuth.signer_for(options.merge(")
                .write("service: 's3',")
                .write("region: @region,")
                .write("uri_escape_path: false")
                .closeBlock("))")
                .write("@stub_responses = options.fetch(:stub_responses, false)")
                .write("@max_attempts = options.fetch(:max_attempts, 4)")
                .write("@max_delay = options.fetch(:max_delay, 8)")
                .write("@raise_api_errors = options.fetch(:raise_api_errors, true)")
                .write("@middleware = Seahorse::MiddlewareBuilder.new(options[:middleware])")
                .closeBlock("end");
    }

    private void renderOperations(CodeWriter writer) {
        operations.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(o -> {
            String operation = RubyFormatter.toSnakeCase(o.getId().getName());
            MiddlewareBuilder middlewareBuilder = new MiddlewareBuilder(o.getId().getName());
            writer
                    .openBlock("def $L(params = {}, options = {})", operation)
                    .write("stack = Seahorse::MiddlewareStack.new")
                    .call(() -> middlewareBuilder.render(writer))
                    .write("@middleware.apply(stack)")
                    .write("raise resp.error if resp.error && @raise_api_errors")
                    .write("resp")
                    .closeBlock("end");
        });
    }

    private void renderOutputStreamMethod(CodeWriter writer) {
        writer
                .openBlock("def output_stream(options = {}, block = nil)")
                .write("return options[:output_stream] if options[:output_stream]")
                .write("return Seahorse::BlockIO.new(block) if block")
                .write("Seahorse::BufferedIO.new")
                .closeBlock("end");
    }
}
