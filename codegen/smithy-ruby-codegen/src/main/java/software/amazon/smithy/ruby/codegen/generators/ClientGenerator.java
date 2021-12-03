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

import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.DocumentationTrait;
import software.amazon.smithy.ruby.codegen.ClientConfig;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.utils.StringUtils;

public class ClientGenerator {
    private final GenerationContext context;
    private final RubySettings settings;
    private final MiddlewareBuilder middlewareBuilder;
    private final List<ClientConfig> clientConfig;
    private final SymbolProvider symbolProvider;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;

    public ClientGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();

        // Register all middleware
        this.middlewareBuilder = new MiddlewareBuilder();
        middlewareBuilder.addDefaultMiddleware(context);

        context.getIntegrations().forEach((integration) -> {
            middlewareBuilder.register(integration.getClientMiddleware());
        });

        // get all config
        Set<ClientConfig> unorderedConfig = ClientConfig.defaultConfig(context);
        unorderedConfig
                .addAll(context.getApplicationTransport().getClientConfig());
        unorderedConfig.addAll(middlewareBuilder.getClientConfig(context));
        unorderedConfig.addAll(context.getIntegrations()
                .stream()
                .map((i) -> i.getAdditionalClientConfig())
                .flatMap(Collection::stream)
                .collect(Collectors.toList())
        );

        clientConfig = unorderedConfig.stream()
                .sorted(Comparator.comparing(ClientConfig::getName))
                .collect(Collectors.toList());

        this.symbolProvider = new RubySymbolProvider(model, context.getRubySettings(), "Client", false);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();

        List<String> additionalFiles =
                middlewareBuilder.writeAdditionalFiles(context);
        for (String require : additionalFiles) {
            writer.write("require_relative '$L'", removeRbExtension(require));
        }

        if (additionalFiles.size() > 0) {
            writer.write("");
        }

        writer
                .openBlock("module $L", settings.getModule())
                .write("# An API client for $L",
                        settings.getService().getName())
                .write("# See {#initialize} for a full list of supported configuration options")
                .openBlock("class Client")
                .write("include Seahorse::ClientStubs")
                .write("\n@middleware = Seahorse::MiddlewareBuilder.new")
                .openBlock("\ndef self.middleware")
                .write("@middleware")
                .closeBlock("end")
                .call(() -> renderInitializeMethod())
                .call(() -> renderOperations())
                .write("\nprivate")
                .call(() -> renderApplyMiddlewareMethod())
                .call(() -> renderOutputStreamMethod())
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/client.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    public void renderRbs() {
        FileManifest fileManifest = context.getFileManifest();

        rbsWriter
                .openBlock("module $L", settings.getModule())
                .openBlock("class Client")
                .write("include Seahorse::ClientStubs\n")
                .write("def self.middleware: () -> untyped\n")
                .write("def initialize: (?::Hash[untyped, untyped] options) -> void")
                .call(() -> renderRbsOperations())
                .write("\nprivate\n")
                .write("def apply_middleware: (untyped middleware_stack, untyped middleware) -> untyped\n")
                .write("def output_stream: (?::Hash[untyped, untyped] options) { () -> untyped } -> untyped")
                .closeBlock("end")
                .closeBlock("end");

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/client.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
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
                .openBlock("def initialize(options = {})")
                .call(() -> {
                    clientConfig.forEach((cfg) -> {
                        if (StringUtils.isNotBlank(
                                cfg.getInitializationCustomization())) {
                            writer.writeWithNoFormatting(
                                    cfg.getInitializationCustomization());
                        } else if (StringUtils.isEmpty(cfg.getDefaultValue())) {
                            writer.write("@$1L = options[:$1L]", cfg.getName());
                        } else {
                            writer.write("@$1L = options.fetch(:$1L, $2L)",
                                    cfg.getName(), cfg.getDefaultValue());
                        }
                    });
                })
                .write("")
                .call(() -> {
                    clientConfig.forEach((cfg) -> {
                        if (StringUtils.isNotBlank(
                                cfg.getPostInitializeCustomization())) {
                            writer.writeWithNoFormatting(
                                    cfg.getPostInitializeCustomization());
                        }
                    });
                })
                .closeBlock("end");
    }

    private void renderInitializeDocumentation() {
        writer.write("");
        writer.rdoc(() -> {
            writer.write("@overload initialize(options)");
            writer.write("@param [Hash] options");
            clientConfig.forEach((cfg) -> {
                if (StringUtils.isNotBlank(cfg.getDocumentation())) {
                    writer.write("@option options [$L] :$L $L", cfg.getType(),
                            cfg.getName(),
                            StringUtils.isNotBlank(cfg.getDefaultValue())
                                    ? "(" + cfg.getDefaultValue() + ")" : "");
                    writer.write("  $L", cfg.getDocumentation());
                    writer.write("");
                }
            });
        });
    }

    private void renderOperations() {
        // Generate each operation for the service. We do this here instead of via the operation visitor method to
        // limit it to the operations bound to the service.
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(o));
    }

    private void renderRbsOperations() {
        // Generate each operation for the service. We do this here instead of via the operation visitor method to
        // limit it to the operations bound to the service.
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderRbsOperation(o));
    }

    private void renderOperation(OperationShape operation) {
        Symbol symbol = symbolProvider.toSymbol(operation);
        if (!operation.getInput().isPresent()) {
            throw new RuntimeException("Missing Input Shape for: " + operation.getId());
        }
        ShapeId inputShapeId = operation.getInput().get();
        Shape inputShape = model.expectShape(inputShapeId);
        String operationName =
                RubyFormatter.toSnakeCase(symbol.getName());
        writer
                .call(() -> renderOperationDocumentation(operation))
                .openBlock("def $L(params = {}, options = {}, &block)", operationName)
                .write("stack = Seahorse::MiddlewareStack.new")
                .write("input = Params::$L.build(params)", symbolProvider.toSymbol(inputShape).getName())
                .call(() -> middlewareBuilder
                        .render(writer, context, operation))
                .write("apply_middleware(stack, options[:middleware])\n")
                .openBlock("resp = stack.run(")
                .write("input: input,")
                .openBlock("context: Seahorse::Context.new(")
                .write("request: $L,",
                        context.getApplicationTransport().getRequest()
                                .render(context))
                .write("response: $L,",
                        context.getApplicationTransport().getResponse()
                                .render(context))
                .write("params: params,")
                .write("logger: @logger,")
                .write("operation_name: :$L", operationName)
                .closeBlock(")")
                .closeBlock(")")
                .write("raise resp.error if resp.error")
                .write("resp.data")
                .closeBlock("end");
    }

    private void renderRbsOperation(OperationShape operation) {
        Symbol symbol = symbolProvider.toSymbol(operation);
        String operationName =
                RubyFormatter.toSnakeCase(symbol.getName());

        rbsWriter.write("def $L: (?::Hash[untyped, untyped] params, ?::Hash[untyped, untyped] options)"
                + "{ () -> untyped } -> untyped", operationName);
    }

    private void renderOperationDocumentation(OperationShape operation) {
        writer.write("");
        writer.rdoc(() -> {
            Optional<DocumentationTrait> documentation =
                    operation.getTrait(DocumentationTrait.class);
            if (documentation.isPresent()) {
                writer.write("$L", documentation.get().getValue());
            } else {
                writer.write("UNDOCUMENTED: Service operation for $L",
                        operation.getId().getName());
            }
            writer.write("");
            writer.write("@param [Hash] params - See also: {Types::$LInput}",
                    operation.getId().getName());

            ShapeId inputShapeId = operation.getInput().get();
            StructureShape input =
                    model.expectShape(inputShapeId).asStructureShape().get();
            for (MemberShape memberShape : input.members()) {
                Shape target = model.expectShape(memberShape.getTarget());
                String symbolName = ":" + symbolProvider.toMemberName(memberShape);
                writer.write("@options param[$L] $L", symbolProvider.toSymbol(target).getName(),
                        symbolName);
                Optional<DocumentationTrait> memberDoc =
                        memberShape.getTrait(DocumentationTrait.class);
                if (memberDoc.isPresent()) {
                    writer.write("  $L", memberDoc.get().getValue());
                }
                writer.write("");
            }
        });
    }

    private void renderApplyMiddlewareMethod() {
        writer
                .openBlock(
                        "\ndef apply_middleware(middleware_stack, middleware)")
                .write("Client.middleware.apply(middleware_stack)")
                .write("@middleware.apply(middleware_stack)")
                .write("Seahorse::MiddlewareBuilder.new(middleware).apply(middleware_stack)")
                .closeBlock("end");
    }

    private void renderOutputStreamMethod() {
        writer
                .openBlock("\ndef output_stream(options = {}, &block)")
                .write("return options[:output_stream] if options[:output_stream]")
                .write("return Seahorse::BlockIO.new(block) if block")
                .write("\nStringIO.new")
                .closeBlock("end");
    }
}
