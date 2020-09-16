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

        writer.openBlock("module $L", settings.getModule())
                .openBlock("class Client < Seahorse::Client::Base")
                .openBlock("def initialize(*args)")
                .write("super")
                .closeBlock("end")
                .call(() -> renderOperations(writer))
                .call(() -> renderBuildRequest(writer))
                .write("private")
                .call(() -> renderSelfMethods(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/client.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderOperations(CodeWriter writer) {
        operations.sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(o -> {
                    String operation = RubyFormatter.toSnakeCase(o.getId().getName());
                    writer.openBlock("def $L(params = {}, options = {})", operation)
                            .write("req = build_request($L, params)", operation)
                            .write("req.send_request(options)")
                            .closeBlock("end");
                }
        );
    }

    private void renderBuildRequest(CodeWriter writer) {
        writer.openBlock("def build_request(operation_name, params = {})")
                .write("handlers = @handlers.for(operation_name)")
                .openBlock("context = Seahorse::Client::RequestContext.new(")
                .write("operation_name: operation_name,")
                .write("operation: config.api.operation(operation_name),")
                .write("client: self,")
                .write("params: params,")
                .write("config:config")
                .closeBlock(")")
                .write("context[:gem_name] = '$L'", settings.getGemName())
                .write("context[:gem_version] = '$L'", settings.getGemVersion())
                .write("Seahorse::Client::Request.new(handlers, context)")
                .closeBlock("end");
    }

    private void renderSelfMethods(CodeWriter writer) {
        writer
                .openBlock("class << self")
                .write("attr_reader :identifier")
                .openBlock("def errors_module")
                .write("Errors")
                .closeBlock("end")
                .closeBlock("end");
    }
}
