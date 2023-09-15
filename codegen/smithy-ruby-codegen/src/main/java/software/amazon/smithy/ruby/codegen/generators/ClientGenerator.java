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

import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.GenerateServiceDirective;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.RubyRuntimePlugin;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Generate the service Client.
 */
@SmithyInternalApi
public class ClientGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(ClientGenerator.class.getName());

    private final Set<OperationShape> operations;
    private final MiddlewareBuilder middlewareBuilder;
    private final Set<RubyRuntimePlugin> runtimePlugins;
    private boolean hasOutputStreamingOperation = false;

    public ClientGenerator(
            GenerateServiceDirective<GenerationContext, RubySettings> directive,
            MiddlewareBuilder middlewareBuilder
    ) {
        super(directive);
        this.operations = directive.operations();
        this.middlewareBuilder = middlewareBuilder;
        this.runtimePlugins = context.getRuntimePlugins();

        operations.forEach(operation -> {
            Shape outputShape = model.expectShape(operation.getOutputShape());
            if (Streaming.isStreaming(model, outputShape)) {
                hasOutputStreamingOperation = true;
            }
        });
    }

    @Override
    String getModule() {
        return "Client";
    }

    /**
     * Render/Generate the service client.
     */
    public void render() {
        List<String> additionalFiles = middlewareBuilder.writeAdditionalFiles(context);
        additionalFiles.addAll(
                runtimePlugins.stream()
                        .map(plugin -> plugin.writeAdditionalFiles(context))
                        .flatMap(List::stream)
                        .distinct()
                        .sorted()
                        .collect(Collectors.toList())
        );
        additionalFiles.sort(String::compareTo);

        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .writeRequireRelativeAdditionalFiles(additionalFiles)
                    .openBlock("module $L", settings.getModule())
                    .call(() -> new ShapeDocumentationGenerator(
                            model, writer, symbolProvider, context.service()).render())
                    .openBlock("class Client")
                    .write("include $T", Hearth.CLIENT_STUBS)
                    .write("")
                    .call(() -> renderClassRuntimePlugins(writer))
                    .call(() -> renderInitializeMethod(writer))
                    .write("\n# @return [Config] config")
                    .write("attr_reader :config\n")
                    .call(() -> renderOperations(writer))
                    .write("\nprivate")
                    .call(() -> renderInitializeConfigMethod(writer))
                    .call(() -> renderOperationConfigMethod(writer))
                    .call(() -> {
                        if (hasOutputStreamingOperation) {
                            renderOutputStreamMethod(writer);
                        }
                    })
                    .closeBlock("end")
                    .closeBlock("end");
        });

        LOGGER.fine("Wrote client to " + rbFile());
    }

    /**
     * Render/generate the RBS types for the client.
     */
    public void renderRbs() {
        writeRbs(writer -> {
            writer
                    .preamble()
                    .openBlock("module $L", settings.getModule())
                    .openBlock("class Client")
                    .write("include $T\n", Hearth.CLIENT_STUBS)
                    .write("def self.plugins: () -> Hearth::PluginList\n")
                    .write("def initialize: (?Config, ?::Hash[::Symbol, untyped] options) -> void\n")
                    .write("attr_reader config: Config")
                    .write("")
                    .call(() -> renderRbsOperations(writer))
                    .closeBlock("end")
                    .closeBlock("end");
        });

        LOGGER.fine("Wrote client rbs to " + rbsFile());
    }

    private void renderClassRuntimePlugins(RubyCodeWriter writer) {
        writer.apiPrivate();
        if (runtimePlugins.isEmpty()) {
            writer.write("@plugins = $T.new", Hearth.PLUGIN_LIST);
        } else {
            writer.openBlock("@plugins = $T.new([", Hearth.PLUGIN_LIST);
            writer.write(
                    runtimePlugins.stream()
                            .map(p -> p.renderAdd(context))
                            .collect(Collectors.joining(",\n"))
            );
            writer.closeBlock("])");
        }


        writer
                .write("")
                .writeYardReturn("Hearth::PluginList", "")
                .openBlock("def self.plugins")
                .write("@plugins")
                .closeBlock("end\n");

    }

    private void renderInitializeMethod(RubyCodeWriter writer) {
        writer
                .writeYardParam("Hash", "options",
                        "Options used to construct an instance of {Config}")
                .openBlock("def initialize(options = {})")
                .write("@config = initialize_config(options)")
                .write("@stubs = $T.new", Hearth.STUBS)
                .closeBlock("end");
    }

    private void renderOperations(RubyCodeWriter writer) {
        operations.stream()
                .filter((o) -> !Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(writer, o));
    }

    private void renderRbsOperations(RubyCodeWriter writer) {
        operations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderRbsOperation(writer, o));
    }

    private void renderOperation(RubyCodeWriter writer, OperationShape operation) {
        Shape inputShape = model.expectShape(operation.getInputShape());
        Shape outputShape = model.expectShape(operation.getOutputShape());
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        boolean isStreaming = Streaming.isStreaming(model, outputShape);

        writer
                .write("")
                .call(() -> new ShapeDocumentationGenerator(model, writer, symbolProvider, operation).render())
                .call(() -> {
                    if (isStreaming) {
                        writer
                                .openBlock("def $L(params = {}, options = {}, &block)", operationName)
                                .write("response_body = output_stream(options, &block)");
                    } else {
                        writer
                                .openBlock("def $L(params = {}, options = {})", operationName)
                                .write("response_body = $T.new", RubyImportContainer.STRING_IO);
                    }
                })
                .write("config = operation_config(options)")
                .write("stack = $T.new", Hearth.MIDDLEWARE_STACK)
                .write("input = Params::$L.build(params, context: 'params')",
                        symbolProvider.toSymbol(inputShape).getName())
                .call(() -> middlewareBuilder
                        .render(writer, context, operation))
                .openBlock("resp = stack.run(")
                .write("input: input,")
                .openBlock("context: $T.new(", Hearth.CONTEXT)
                .write("request: $L,",
                        context.applicationTransport().getRequest()
                                .render(context))
                .write("response: $L,",
                        context.applicationTransport().getResponse()
                                .render(context))
                .write("params: params,")
                .write("logger: config.logger,")
                .write("operation_name: :$L,", operationName)
                .write("interceptors: config.interceptors")
                .closeBlock(")")
                .closeBlock(")")
                .write("raise resp.error if resp.error")
                .write("resp")
                .closeBlock("end");
        LOGGER.finer("Generated client operation method " + operationName);
    }

    private void renderRbsOperation(RubyCodeWriter writer, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        Shape outputShape = model.expectShape(operation.getOutputShape());
        boolean isStreaming = outputShape.members().stream()
                .anyMatch((m) -> m.getMemberTrait(model, StreamingTrait.class).isPresent());

        writer.writeInline("def $L: (?::Hash[::Symbol, untyped] params, ?::Hash[::Symbol, untyped] options)",
                operationName);
        if (isStreaming) {
            writer.writeInline("?{ (::String) -> Hearth::BlockIO }");
        }
        writer.write("-> Hearth::Output");
    }

    private void renderInitializeConfigMethod(RubyCodeWriter writer) {
        writer
                .openBlock("\ndef initialize_config(options)")
                .write("client_interceptors = options.delete(:interceptors)")
                .write("config = Config.new(**options)")
                .write("Client.plugins.each { |p| p.call(config) }")
                .write("config.plugins.each { |p| p.call(config) }")
                .write("config.interceptors.concat($T.new(client_interceptors)) if client_interceptors",
                        Hearth.INTERCEPTOR_LIST)
                .write("config.validate!")
                .write("config.freeze")
                .closeBlock("end");
    }

    private void renderOperationConfigMethod(RubyCodeWriter writer) {
        writer
                .openBlock("\ndef operation_config(options)")
                .write("return @config if options.empty?")
                .write("")
                .write("operation_plugins = options.delete(:plugins)")
                .write("operation_interceptors = options.delete(:interceptors)")
                .write("config = @config.merge(options)")
                .write("$T.new(operation_plugins).each { |p| p.call(config) } if operation_plugins",
                        Hearth.PLUGIN_LIST)
                .write("config.interceptors.concat($T.new(operation_interceptors)) if operation_interceptors",
                        Hearth.INTERCEPTOR_LIST)
                .write("config.validate!")
                .write("config.freeze")
                .closeBlock("end");
    }

    private void renderOutputStreamMethod(RubyCodeWriter writer) {
        writer
                .openBlock("\ndef output_stream(options = {}, &block)")
                .write("return options.delete(:output_stream) if options[:output_stream]")
                .write("return $T.new(block) if block", Hearth.BLOCK_IO)
                .write("\n$T.new", RubyImportContainer.STRING_IO)
                .closeBlock("end");
    }
}
