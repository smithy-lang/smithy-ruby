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

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.utils.SmithyInternalApi;
import software.amazon.smithy.waiters.Acceptor;
import software.amazon.smithy.waiters.AcceptorState;
import software.amazon.smithy.waiters.Matcher;
import software.amazon.smithy.waiters.WaitableTrait;
import software.amazon.smithy.waiters.Waiter;

@SmithyInternalApi
public class WaitersGenerator {

    private static final Logger LOGGER =
            Logger.getLogger(WaitersGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final RubySymbolProvider symbolProvider;

    public WaitersGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(context.getModel(), settings, "Waiters", false);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();

        writer
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderWaiters())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/waiters.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote waiters to " + fileName);
    }

    public void renderRbs() {
        FileManifest fileManifest = context.getFileManifest();

        rbsWriter
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderRbsWaiters())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/waiters.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
        LOGGER.fine("Wrote waiters rbs to " + typesFile);
    }

    private void renderWaiters() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            if (operation.hasTrait(WaitableTrait.class)) {
                Map<String, Waiter> waiters = operation.getTrait(WaitableTrait.class).get().getWaiters();
                Iterator<Map.Entry<String, Waiter>> iterator = waiters.entrySet().iterator();

                while (iterator.hasNext()) {
                    Map.Entry<String, Waiter> entry = iterator.next();
                    String waiterName = entry.getKey();
                    Waiter waiter = entry.getValue();
                    renderWaiter(waiterName, waiter, operation);
                    if (iterator.hasNext()) {
                        writer.write("");
                    }
                }
            }
        });
    }

    private void renderRbsWaiters() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            if (operation.hasTrait(WaitableTrait.class)) {
                Map<String, Waiter> waiters = operation.getTrait(WaitableTrait.class).get().getWaiters();
                Iterator<Map.Entry<String, Waiter>> iterator = waiters.entrySet().iterator();

                while (iterator.hasNext()) {
                    Map.Entry<String, Waiter> entry = iterator.next();
                    String waiterName = entry.getKey();
                    renderRbsWaiter(waiterName);
                    if (iterator.hasNext()) {
                        rbsWriter.write("");
                    }
                }
            }
        });
    }

    private void renderWaiter(String waiterName, Waiter waiter, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        writer
                .write("")
                .call(() -> renderWaiterDocumentation(waiter))
                .openBlock("class $L", waiterName)
                .call(() -> renderWaiterInitializeDocumentation(waiter))
                .openBlock("def initialize(client, options = {})")
                .write("@client = client")
                .openBlock("@waiter = Seahorse::Waiters::Waiter.new({")
                .write("max_wait_time: options[:max_wait_time],")
                .write("min_delay: $L || options[:min_delay],", waiter.getMinDelay())
                .write("max_delay: $L || options[:max_delay],", waiter.getMaxDelay())
                .openBlock("poller: Seahorse::Waiters::Poller.new(")
                .write("operation_name: :$L,", operationName)
                .call(() -> renderAcceptors(waiter))
                .closeBlock(")")
                .closeBlock("}.merge(options))")
                .call(() -> renderWaiterTags(waiter))
                .closeBlock("end")
                .write("")
                .write("attr_reader :tags")
                .write("")
                .call(() -> renderWaiterWaitDocumentation(operation, operationName))
                .openBlock("def wait(params = {}, options = {})")
                .write("@waiter.wait(@client, params, options)")
                .closeBlock("end")
                .closeBlock("end");

        LOGGER.finer("Generated waiter " + waiterName + " for operation: " + operationName);
    }

    private void renderRbsWaiter(String waiterName) {
        rbsWriter
                .write("")
                .openBlock("class $L", waiterName)
                .write("def initialize: (untyped client, ?::Hash[untyped, untyped] options) -> void\n")
                .write("attr_reader tags: untyped\n")
                .write("def wait: (?::Hash[untyped, untyped] params, ?::Hash[untyped, untyped] options) -> untyped")
                .closeBlock("end");
    }

    private void renderWaiterDocumentation(Waiter waiter) {
        if (waiter.getDocumentation().isPresent()) {
            writer.writeDocstring(waiter.getDocumentation().get());
        }
        if (waiter.isDeprecated()) {
            writer.writeYardDeprecated("This waiter is deprecated.", "");
        }
    }

    private void renderWaiterTags(Waiter waiter) {
        String tags = waiter.getTags().stream()
                .map((tag) -> "\"" + tag + "\"")
                .collect(Collectors.joining(", "));
        writer.write("@tags = [$L]", tags);
    }

    private void renderAcceptors(Waiter waiter) {
        List<Acceptor> acceptorsList = waiter.getAcceptors();

        if (acceptorsList.isEmpty()) {
            writer.write("acceptors: []");
        } else {
            writer.openBlock("acceptors: [");
            Iterator<Acceptor> iterator = acceptorsList.iterator();

            while (iterator.hasNext()) {
                Acceptor acceptor = iterator.next();
                Matcher<?> matcher = acceptor.getMatcher();
                AcceptorState state = acceptor.getState();
                writer
                        .openBlock("{")
                        .write("state: '$L',", state)
                        .openBlock("matcher: {")
                        .call(() -> {
                            matcher.accept(new AcceptorVisitor());
                        })
                        .closeBlock("}");

                if (iterator.hasNext()) {
                    writer.closeBlock("},");
                } else {
                    writer.closeBlock("}");
                }
            }
            writer.closeBlock("]");
        }
    }

    private String translatePath(String path) {
        //TODO: This needs to use a JMESPathExpression to parse the path and actually correctly translate names
        // This will not work correctly in all cases
        return Arrays.stream(path.split("[.]"))
                .map((m) -> RubyFormatter.toSnakeCase(m)).collect(Collectors.joining("."));
    }

    private void renderWaiterWaitDocumentation(OperationShape operation, String operationName) {
        String operationReturnType = "Types::" + symbolProvider.toSymbol(operation).getName();

        String operationReference = "(see Client#" + operationName + ")";
        writer
                .writeYardParam("Hash", "params", operationReference)
                .writeYardParam("Hash", "options", operationReference)
                .writeYardReturn(operationReturnType, operationReference);
    }

    private void renderWaiterInitializeDocumentation(Waiter waiter) {
        writer
                .writeYardParam("Client", "client", "")
                .writeYardParam("Hash", "options", "")
                .writeYardOption(
                        "options",
                        "required, Integer",
                        ":max_wait_time",
                        "",
                        "The maximum time in seconds to wait before the waiter gives up.")
                .writeYardOption(
                        "options",
                        "Integer",
                        ":min_delay",
                        "" + waiter.getMinDelay(),
                        "The minimum time in seconds to delay polling attempts.")
                .writeYardOption(
                        "options",
                        "Integer",
                        ":max_delay",
                        "" + waiter.getMaxDelay(),
                        "The maximum time in seconds to delay polling attempts.");
    }

    private class AcceptorVisitor implements Matcher.Visitor<Void> {

        @Override
        public Void visitOutput(Matcher.OutputMember outputPath) {
            writer
                    .openBlock("$L: {", outputPath.getMemberName())
                    .write("path: $L", translatePath(outputPath.getValue().getPath()))
                    .write("comparator: \"$L\"", outputPath.getValue().getComparator())
                    .write("expected: '$L'", outputPath.getValue().getExpected())
                    .closeBlock("}");
            return null;
        }

        @Override
        public Void visitInputOutput(Matcher.InputOutputMember inputOutputPath) {
            writer
                    .openBlock("$L: {", inputOutputPath.getMemberName())
                    .write("path: $L", translatePath(inputOutputPath.getValue().getPath()))
                    .write("comparator: \"$L\"", inputOutputPath.getValue().getComparator())
                    .write("expected: '$L'", inputOutputPath.getValue().getExpected())
                    .closeBlock("}");
            return null;
        }

        @Override
        public Void visitSuccess(Matcher.SuccessMember success) {
            writer.write("$L: $L", success.getMemberName(), success.getValue() ? "true" : "false");
            return null;
        }

        @Override
        public Void visitErrorType(Matcher.ErrorTypeMember errorType) {
            writer.write("$L: '$L'", errorType.getMemberName(), errorType.getValue());
            return null;
        }

        @Override
        public Void visitUnknown(Matcher.UnknownMember unknown) {
            return null;
        }
    }
}
