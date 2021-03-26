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
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.*;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.utils.StringUtils;

public class ClientGenerator {
    private final GenerationContext context;

    private final MiddlewareBuilder middlewareBuilder;
    private final List<ClientConfig> clientConfig;

    public ClientGenerator(GenerationContext context) {
        this.context = context;

        // Register all middleware
        this.middlewareBuilder = new MiddlewareBuilder();
        middlewareBuilder.addDefaultMiddleware(context);

        context.getIntegrations().forEach( (integration) -> {
            middlewareBuilder.register(integration.getClientMiddleware());
        });

        // get all config
        Set<ClientConfig> unorderedConfig = ClientConfig.defaultConfig(context);
        unorderedConfig.addAll(context.getApplicationTransport().getClientConfig());
        unorderedConfig.addAll(middlewareBuilder.getClientConfig(context));
        clientConfig = unorderedConfig.stream()
                .sorted(Comparator.comparing(ClientConfig::getName))
                .collect(Collectors.toList());
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        RubySettings settings = context.getRubySettings();
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .openBlock("module $L", settings.getModule())
                .write("# An API client for $L", settings.getService().getName())
                .write("# See {#initialize} for a full list of supported configuration options")
                .openBlock("class Client")
                .write("include Seahorse::ClientStubs")
                .write("\n@middleware = Seahorse::MiddlewareBuilder.new")
                .openBlock("\ndef self.middleware")
                .write("@middleware")
                .closeBlock("end")
                .call(() -> renderInitializeMethod(writer))
                .call(() -> renderOperations(writer))
                .write("\nprivate")
                .call(() -> renderApplyMiddlewareMethod(writer))
                .call(() -> renderOutputStreamMethod(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/client.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderInitializeMethod(RubyCodeWriter writer) {
        writer
                .call(() -> renderInitializeDocumentation(writer))
                .openBlock("def initialize(options = {})")
                .call(() -> {
                    clientConfig.forEach((cfg) -> {
                        if (StringUtils.isNotBlank(cfg.getInitializationCustomization())) {
                            writer.writeWithNoFormatting(cfg.getInitializationCustomization());
                        } else if (StringUtils.isEmpty(cfg.getDefaultValue())) {
                            writer.write("@$1L = options[:$1L]", cfg.getName());
                        } else {
                            writer.write("@$1L = options.fetch(:$1L, $2L)", cfg.getName(), cfg.getDefaultValue());
                        }
                    });
                })
                .closeBlock("end");
    }

    private void renderInitializeDocumentation(RubyCodeWriter writer) {
        writer.write("");
        writer.rdoc(() -> {
            writer.write("@overload initialize(options)");
            writer.write("  @param [Hash] options");
            clientConfig.forEach( (cfg) -> {
                if (StringUtils.isNotBlank(cfg.getDocumentation())) {
                    writer.write("  @option options [$L] :$L $L", cfg.getType(), cfg.getName(), StringUtils.isNotBlank(cfg.getDefaultValue()) ? "(" + cfg.getDefaultValue() + ")" : "");
                    writer.write("    $L", cfg.getDocumentation());
                    writer.write("");
                }
            });
        });
    }

    private void renderOperations(RubyCodeWriter writer) {
        // Generate each operation for the service. We do this here instead of via the operation visitor method to
        // limit it to the operations bound to the service.
        TopDownIndex topDownIndex = TopDownIndex.of(context.getModel());
        Set<OperationShape> containedOperations = new TreeSet<>(topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(writer, o) );
    }

    private void renderOperation(RubyCodeWriter writer, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(operation.getId().getName());
        writer
                .write("\n# TODO: Document ME!")
                .openBlock("def $L(params = {}, options = {})", operationName)
                .write("stack = Seahorse::MiddlewareStack.new")
                .call(() -> middlewareBuilder.render(writer, context, operation))
                .write("@middleware.apply(stack)")
                .openBlock("resp = stack.run(")
                .write("request: $L,", context.getApplicationTransport().getRequest().render(context))
                .write("response: $L,", context.getApplicationTransport().getResponse().render(context))
                .openBlock("context: {")
                .write("api_method: :$L,", operationName)
                .write("api_name: '$L',", operation.getId().getName())
                .write("params: params")
                .closeBlock("}")
                .closeBlock(")")
                .write("raise resp.error if resp.error && @raise_api_errors")
                .write("resp")
                .closeBlock("end");
    }

    private void renderApplyMiddlewareMethod(RubyCodeWriter writer) {
        writer
                .openBlock("\ndef apply_middleware(middleware_stack, middleware)")
                .write("Client.middleware.apply(middleware_stack)")
                .write("@middleware.apply(middleware_stack)")
                .write("Seahorse::MiddlewareBuilder.new(middleware).apply(middleware_stack)")
                .closeBlock("end");
    }

    private void renderOutputStreamMethod(RubyCodeWriter writer) {
        writer
                .openBlock("\ndef output_stream(options = {}, block = nil)")
                .write("return options[:output_stream] if options[:output_stream]")
                .write("return Seahorse::BlockIO.new(block) if block")
                .write("\nStringIO.new")
                .closeBlock("end");
    }
}
