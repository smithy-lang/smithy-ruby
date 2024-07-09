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
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.RubyRuntimePlugin;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.ruby.codegen.generators.rbs.OperationKeywordArgRbsVisitor;
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
    private final Set<RubyRuntimePlugin> runtimePlugins;
    private final List<ClientConfig> clientConfigList;

    public ClientGenerator(GenerateServiceDirective<GenerationContext, RubySettings> directive,
            List<ClientConfig> clientConfigList) {
        super(directive);
        this.operations = directive.operations();
        this.runtimePlugins = context.getRuntimePlugins();
        this.clientConfigList = clientConfigList;
    }

    @Override
    protected String getModule() {
        return "Client";
    }

    /**
     * Render/Generate the service client.
     */
    public void render() {
        List<String> additionalFiles = runtimePlugins.stream()
            .map(plugin -> plugin.writeAdditionalFiles(context))
            .flatMap(List::stream)
            .distinct()
            .sorted()
            .collect(Collectors.toList());
        additionalFiles.sort(String::compareTo);

        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .writeRequireRelativeAdditionalFiles(additionalFiles)
                    .openBlock("module $L", settings.getModule())
                    .call(() -> new ShapeDocumentationGenerator(
                            model, writer, symbolProvider, context.service()).render())
                    .openBlock("class Client < $T", Hearth.CLIENT)
                    .write("")
                    .call(() -> renderClassRuntimePlugins(writer))
                    .write("")
                    .call(() -> renderInitializeMethod(writer))
                    .write("\n# @return [Config] config")
                    .write("attr_reader :config\n")
                    .call(() -> renderOperations(writer))
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
                    .openBlock("class Client < $T", Hearth.CLIENT)
                    .write("")
                    .write("def self.plugins: () -> Hearth::PluginList[Config]")
                    .write("")
                    .openBlock("def initialize: (?::Hash[::Symbol, untyped] options) -> void |")
                    .call(() -> renderInitializeRbs(writer))
                    .closeBlock("")
                    .write("")
                    .write("attr_reader config: Config")
                    .write("")
                    .call(() -> renderRbsOperations(writer))
                    .closeBlock("end")
                    .closeBlock("end");
        });

        LOGGER.fine("Wrote client rbs to " + rbsFile());
    }

    private void renderInitializeRbs(RubyCodeWriter writer) {
        writer
                .openBlock("(")
                .call(() -> {
                    clientConfigList.forEach((clientConfig) -> {
                        String member = RubySymbolProvider.toMemberName(clientConfig.getName());
                        String rbsType = clientConfig.getRbsType();
                        writer.write("?$L: $L,", member, rbsType);
                    });
                })
                .unwrite(",\n")
                .closeBlock("\n) -> void");
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
    }

    private void renderInitializeMethod(RubyCodeWriter writer) {
        writer
                .writeYardParam("Hash", "options",
                        "Options used to construct an instance of {Config}")
                .openBlock("def initialize(options = {})")
                .write("super(options, Config)")
                .closeBlock("end");
    }

    private void renderOperations(RubyCodeWriter writer) {
        operations.stream()
                .filter((o) -> !Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(writer, o));

        context.eventStreamTransport().ifPresent(eventStreamTransport -> {
            operations.stream()
                    .filter((o) -> Streaming.isEventStreaming(model, o))
                    .sorted(Comparator.comparing((o) -> o.getId().getName()))
                    .forEach(o -> renderEventStreamOperation(writer, eventStreamTransport, o));
        });

    }

    private void renderRbsOperations(RubyCodeWriter writer) {
        operations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderRbsOperation(writer, o));
    }

    private void renderOperation(RubyCodeWriter writer, OperationShape operation) {
        Shape inputShape = model.expectShape(operation.getInputShape());
        Shape outputShape = model.expectShape(operation.getOutputShape());
        String classOperationName = symbolProvider.toSymbol(operation).getName();
        String operationName = RubyFormatter.toSnakeCase(classOperationName);
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
                .write("input = Params::$L.build(params, context: 'params')",
                        symbolProvider.toSymbol(inputShape).getName())
                .write("stack = $L::Middleware::$L.build(config)",
                        settings.getModule(), classOperationName)
                .openBlock("context = $T.new(", Hearth.CONTEXT)
                .write("request: $L,",
                        context.applicationTransport().getRequest()
                                .render(context))
                .write("response: $L,",
                        context.applicationTransport().getResponse()
                                .render(context))
                .write("config: config,")
                .write("operation_name: :$L,", operationName)
                .closeBlock(")")
                .write("context.config.logger.info(\"[#{context.invocation_id}] [#{self.class}#$L] params: #{params}, "
                        + "options: #{options}\")", operationName)
                .write("output = stack.run(input, context)")
                .openBlock("if output.error")
                .write("context.config.logger.error(\"[#{context.invocation_id}] [#{self.class}#$L] #{output.error} "
                        + "(#{output.error.class})\")", operationName)
                .write("raise output.error")
                .closeBlock("end")
                .write("context.config.logger.info(\"[#{context.invocation_id}] [#{self.class}#$L] #{output.data}\")",
                        operationName)
                .write("output")
                .closeBlock("end");
    }

    private void renderEventStreamOperation(
            RubyCodeWriter writer, ApplicationTransport eventStreamTransport, OperationShape operation) {
        Shape inputShape = model.expectShape(operation.getInputShape());
        String classOperationName = symbolProvider.toSymbol(operation).getName();
        String operationName = RubyFormatter.toSnakeCase(classOperationName);

        writer
                .write("")
                .call(() -> new ShapeDocumentationGenerator(model, writer, symbolProvider, operation).render())
                .openBlock("def $L(params = {}, options = {})", operationName)
                .write("event_stream_handler = options.delete(:event_stream_handler)")
                .write("raise ArgumentError, 'Missing `event_stream_handler`' unless event_stream_handler")
                .write("response_body = $T.new", RubyImportContainer.STRING_IO)
                .write("config = operation_config(options)")
                .write("input = Params::$L.build(params, context: 'params')",
                        symbolProvider.toSymbol(inputShape).getName())
                .write("stack = $L::Middleware::$L.build(config)",
                        settings.getModule(), classOperationName)
                .openBlock("context = $T.new(", Hearth.CONTEXT)
                .write("request: $L,",
                        eventStreamTransport.getRequest()
                                .render(context))
                .write("response: $L,",
                        eventStreamTransport.getResponse()
                                .render(context))
                .write("config: config,")
                .write("operation_name: :$L,", operationName)
                .closeBlock(")")
                .write("context.config.logger.info(\"[#{context.invocation_id}] [#{self.class}#$L] params: #{params}, "
                        + "options: #{options}\")", operationName)
                .write("output = stack.run(input, context)")
                .openBlock("if output.error")
                .write("context.config.logger.error(\"[#{context.invocation_id}] [#{self.class}#$L] #{output.error} "
                        + "(#{output.error.class})\")", operationName)
                .write("raise output.error")
                .closeBlock("end")
                .write("context.config.logger.info(\"[#{context.invocation_id}] [#{self.class}#$L] #{output.data}\")",
                        operationName)
                .write("output")
                .closeBlock("end");
    }

    private void renderRbsOperation(RubyCodeWriter writer, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        Shape outputShape = model.expectShape(operation.getOutputShape());
        Shape inputShape = model.expectShape(operation.getInputShape());
        boolean isStreaming = outputShape.members().stream()
                .anyMatch((m) -> m.getMemberTrait(model, StreamingTrait.class).isPresent());
        String streamingBlock = isStreaming ? " ?{ (::String) -> Hearth::BlockIO }" : "";
        String dataType = symbolProvider.toSymbol(outputShape).getName();
        String inputType = symbolProvider.toSymbol(inputShape).getName();

        RubyCodeWriter operationRbsWriter = new RubyCodeWriter("");
        operation.accept(new OperationKeywordArgRbsVisitor(context, operationRbsWriter));

        writer
                .openBlock("def $L: (?::Hash[::Symbol, untyped] params, "
                                + "?::Hash[::Symbol, untyped] options) $L -> Hearth::Output[Types::$L] |",
                        operationName,
                        streamingBlock,
                        dataType)
                .write("(?Types::$L params, ?::Hash[::Symbol, untyped] options) $L -> Hearth::Output[Types::$L] |",
                        inputType,
                        streamingBlock,
                        dataType)
                .call(() -> {
                    if (!inputShape.members().isEmpty()) {
                        writer
                                .openBlock("(")
                                .write(operationRbsWriter.toString().trim())
                                .closeBlock(")$L -> Hearth::Output[Types::$L]",
                                        streamingBlock, dataType);
                    } else {
                        writer.unwrite("|\n");
                    }
                })
                .closeBlock("");
    }
}
