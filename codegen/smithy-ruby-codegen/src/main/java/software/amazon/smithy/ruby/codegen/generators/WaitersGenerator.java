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
import java.util.Map;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.StringUtils;
import software.amazon.smithy.waiters.WaitableTrait;
import software.amazon.smithy.waiters.Waiter;

public class WaitersGenerator {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;

    public WaitersGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.symbolProvider = context.getSymbolProvider();
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderWaiters())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/waiters.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderWaiters() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            if (operation.hasTrait(WaitableTrait.class)) {
                Map<String, Waiter> waiters = operation.getTrait(WaitableTrait.class).get().getWaiters();
                Iterator iterator = waiters.entrySet().iterator();

                while (iterator.hasNext()) {
                    Map.Entry entry = (Map.Entry) iterator.next();
                    String waiterName = (String) entry.getKey();
                    Waiter waiter = (Waiter) entry.getValue();
                    renderWaiter(waiterName, waiter, operation);
                }
            }
        });
    }

    private void renderWaiter(String waiterName, Waiter waiter, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(operation.getId().getName());
        writer
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
                .write("operation_name: $L,", operationName)
                .call(() -> renderAcceptors(waiter))
                .closeBlock(")")
                .closeBlock("}.merge(options))")
                .write("@tags = $L", waiter.getTags()) // fix this
                .closeBlock("end")
                .write("\n")
                .write("attr_reader :tags")
                .write("\n")
                .call(() -> renderWaiterWaitDocumentation(operationName))
                .openBlock("def wait(params = {}, options = {})")
                .write("@waiter.wait(@client, params, options)")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderWaiterDocumentation(Waiter waiter) {
        if (waiter.getDocumentation().isPresent()) {
            writer.rdoc(() -> {
                writer.write(StringUtils.wrap(waiter.getDocumentation().get(), 80));
            });
        }
    }

    private void renderAcceptors(Waiter waiter) {
        //waiter.getAcceptors();
        // todo, needs toHash?
    }

    private void renderWaiterWaitDocumentation(String operationName) {
        writer
                .rdoc(() -> {
                    writer
                            .write("@param [Hash] params (see Client#$L)", operationName)
                            .write("@param [Hash] options (see Client#$L)", operationName)
                            .write("@return (see Client#$L)", operationName);
                });
    }

    private void renderWaiterInitializeDocumentation(Waiter waiter) {
        String maxWaitTime = "@option options [required, Integer] :max_wait_time The maximum time in seconds to "
                + "wait before the waiter gives up.";
        String minDelay = "@option options [Integer] :min_delay (" + waiter.getMinDelay() + ") The minimum time in "
                + "seconds to delay polling attempts.";
        String maxDelay = "@option options [Integer] :max_delay (" + waiter.getMaxDelay() + ") The maximum time in "
                + "seconds to delay polling attempts.";

        writer.rdoc(() -> {
            writer
                    .write("@param [Client] client")
                    .write("@param [Hash] options")
                    .write(StringUtils.wrap(maxWaitTime, 80))
                    .write(StringUtils.wrap(minDelay, 80))
                    .write(StringUtils.wrap(maxDelay, 80));
        });
    }
}
