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
import java.util.logging.Logger;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ClientGenerator {
    private static final Logger LOGGER =
            Logger.getLogger(ClientGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final SymbolProvider symbolProvider;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;

    public ClientGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.settings();
        this.model = context.model();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, context.settings(), "Client", false);
    }

    public void render(MiddlewareBuilder middlewareBuilder) {
        FileManifest fileManifest = context.fileManifest();

        writer.writePreamble();

        List<String> additionalFiles =
                middlewareBuilder.writeAdditionalFiles(context);
        for (String require : additionalFiles) {
            writer.write("require_relative '$L'", removeRbExtension(require));
            LOGGER.finer("Adding client require: " + require);
        }

        if (additionalFiles.size() > 0) {
            writer.write("");
        }

        writer
                .openBlock("module $L", settings.getModule())
                .write("# An API client for $L",
                        settings.getService().getName())
                .write("# See {#initialize} for a full list of supported configuration options");

        String documentation = new ShapeDocumentationGenerator(model, symbolProvider, context.service()).render();

        writer
                .writeInline("$L", documentation)
                .openBlock("class Client")
                .write("include Hearth::ClientStubs")
                .write("\n@middleware = Hearth::MiddlewareBuilder.new")
                .openBlock("\ndef self.middleware")
                .write("@middleware")
                .closeBlock("end\n")
                .call(() -> renderInitializeMethod())
                .call(() -> renderOperations(middlewareBuilder))
                .write("\nprivate")
                .call(() -> renderApplyMiddlewareMethod())
                .call(() -> renderOutputStreamMethod())
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/client.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote client to " + fileName);
    }

    public void renderRbs() {
        FileManifest fileManifest = context.fileManifest();

        rbsWriter
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("class Client")
                .write("include Hearth::ClientStubs\n")
                .write("def self.middleware: () -> untyped\n")
                .write("def initialize: (?::Hash[untyped, untyped] options) -> void")
                .call(() -> renderRbsOperations())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/client.rbs";
        fileManifest.writeFile(fileName, rbsWriter.toString());
        LOGGER.fine("Wrote client rbs to " + fileName);
    }

    private Object removeRbExtension(String s) {
        if (s != null && s.endsWith(".rb")) {
            return s.split(".rb")[0];
        }
        return s;
    }

    private void renderInitializeMethod() {
        writer
                .call(() -> renderInitializeDocumentation())
                .openBlock("def initialize(config = $L::Config.build, options = {})", settings.getModule())
                .write("@config = config")
                .write("@middleware = Hearth::MiddlewareBuilder.new(options[:middleware])")
                .write("@stubs = Hearth::Stubbing::Stubs.new")
                .write("@retry_quota = Hearth::Retry::RetryQuota.new")
                .write("@client_rate_limiter = Hearth::Retry::ClientRateLimiter.new")
                .closeBlock("end");
    }

    private void renderInitializeDocumentation() {
        writer.writeDocs((w) -> {
            w.write("@param [Config] config");
        });
    }

    private void renderOperations(MiddlewareBuilder middlewareBuilder) {
        // Generate each operation for the service. We do this here instead of via the operation visitor method to
        // limit it to the operations bound to the service.
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.service()));
        containedOperations.stream()
                .filter((o) -> !Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(o, middlewareBuilder));
    }

    private void renderRbsOperations() {
        // Generate each operation for the service. We do this here instead of via the operation visitor method to
        // limit it to the operations bound to the service.
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.service()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderRbsOperation(o));
    }

    private void renderOperation(OperationShape operation, MiddlewareBuilder middlewareBuilder) {
        Symbol symbol = symbolProvider.toSymbol(operation);
        ShapeId inputShapeId = operation.getInputShape();
        Shape inputShape = model.expectShape(inputShapeId);
        Shape outputShape = model.expectShape(operation.getOutputShape());
        String operationName =
                RubyFormatter.toSnakeCase(symbol.getName());

        String documentation = new ShapeDocumentationGenerator(model, symbolProvider, operation).render();

        writer
                .write("")
                .writeInline("$L", documentation)
                .openBlock("def $L(params = {}, options = {}, &block)", operationName)
                .write("stack = Hearth::MiddlewareStack.new")
                .write("input = Params::$L.build(params)", symbolProvider.toSymbol(inputShape).getName())
                .call(() -> {
                    if (outputShape.members().stream()
                            .anyMatch((m) -> m.getMemberTrait(model, StreamingTrait.class).isPresent())) {
                       writer.write("response_body = output_stream(options, &block)");
                    } else {
                        writer.write("response_body = StringIO.new");
                    }
                })
                .call(() -> middlewareBuilder
                        .render(writer, context, operation))
                .write("apply_middleware(stack, options[:middleware])\n")
                .openBlock("resp = stack.run(")
                .write("input: input,")
                .openBlock("context: Hearth::Context.new(")
                .write("request: $L,",
                        context.applicationTransport().getRequest()
                                .render(context))
                .write("response: $L,",
                        context.applicationTransport().getResponse()
                                .render(context))
                .write("params: params,")
                .write("logger: @config.logger,")
                .write("operation_name: :$L", operationName)
                .closeBlock(")")
                .closeBlock(")")
                .write("raise resp.error if resp.error")
                .write("resp")
                .closeBlock("end");
        LOGGER.finer("Generated client operation method " + operationName);
    }

    private void renderRbsOperation(OperationShape operation) {
        Symbol symbol = symbolProvider.toSymbol(operation);
        String operationName =
                RubyFormatter.toSnakeCase(symbol.getName());

        rbsWriter.write("def $L: (?::Hash[untyped, untyped] params, ?::Hash[untyped, untyped] options)"
                + "{ () -> untyped } -> untyped", operationName);
    }

    private void renderApplyMiddlewareMethod() {
        writer
                .openBlock(
                        "\ndef apply_middleware(middleware_stack, middleware)")
                .write("Client.middleware.apply(middleware_stack)")
                .write("@middleware.apply(middleware_stack)")
                .write("Hearth::MiddlewareBuilder.new(middleware).apply(middleware_stack)")
                .closeBlock("end");
    }

    private void renderOutputStreamMethod() {
        writer
                .openBlock("\ndef output_stream(options = {}, &block)")
                .write("return options[:output_stream] if options[:output_stream]")
                .write("return Hearth::BlockIO.new(block) if block")
                .write("\nStringIO.new")
                .closeBlock("end");
    }
}
