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
import software.amazon.smithy.utils.StringUtils;
import software.amazon.smithy.waiters.Acceptor;
import software.amazon.smithy.waiters.AcceptorState;
import software.amazon.smithy.waiters.Matcher;
import software.amazon.smithy.waiters.PathMatcher;
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
                    Waiter waiter = entry.getValue();
                    renderRbsWaiter(waiterName, waiter, operation);
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
                .call(() -> renderWaiterWaitDocumentation(operationName))
                .openBlock("def wait(params = {}, options = {})")
                .write("@waiter.wait(@client, params, options)")
                .closeBlock("end")
                .closeBlock("end");

        LOGGER.finer("Generated waiter " + waiterName + " for operation: " + operationName);
    }

    private void renderRbsWaiter(String waiterName, Waiter waiter, OperationShape operation) {
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
                            String keyValString = "$L: '$L'";
                            String value = matcher.getValue().toString();
                            // booleans shouldn't be string quoted
                            if (matcher.getMemberName().equals("success")) {
                                keyValString = "$L: $L";
                            }
                            if (matcher instanceof Matcher.InputOutputMember) {
                                Matcher.InputOutputMember pathMatcher = (Matcher.InputOutputMember) matcher;
                                value = pathMatcher.getValue().getPath();
                            }
                            if (matcher instanceof Matcher.OutputMember) {
                                Matcher.OutputMember pathMatcher = (Matcher.OutputMember) matcher;
                                value = pathMatcher.getValue().getPath();
                            }
                            writer.write(keyValString, matcher.getMemberName(), value);
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

    private void renderWaiterWaitDocumentation(String operationName) {
        writer
                .doc(() -> writer
                        .write("@param [Hash] params (see Client#$L)", operationName)
                        .write("@param [Hash] options (see Client#$L)", operationName)
                        .write("@return (see Client#$L)", operationName));
    }

    private void renderWaiterInitializeDocumentation(Waiter waiter) {
//        String maxWaitTimeDocumentation = "The maximum time in seconds to wait before the waiter gives up.";
//        String minDelayDocumentation = "The minimum time in seconds to delay polling attempts.";
//        String maxDelayDocumentation = "The maximum time in seconds to delay polling attempts.";
//
//        writer
//                .writeYardParam("Client", "client", "")
//                .writeYardParam("Hash", "options", "")
//                .writeYardOption(
//                        "options",
//                        "required, Integer",
//                        ":max_wait_time",
//                        "",
//                        maxWaitTimeDocumentation)
//                .writeYardOption(
//                        "options", "Integer", ":min_delay", "" + waiter.getMinDelay(), minDelayDocumentation)
//                .writeYardOption("options", "Integer", ":max_delay", "" + waiter.getMaxDelay(), maxDelayDocumentation);
    }
}
