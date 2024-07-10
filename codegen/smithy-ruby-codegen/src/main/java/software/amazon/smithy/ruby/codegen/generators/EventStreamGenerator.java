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
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public class EventStreamGenerator extends RubyGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(EventStreamGenerator.class.getName());

    private final Set<OperationShape> operations;

    public EventStreamGenerator(
            ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.operations = directive.operations();
    }

    @Override
    protected String getModule() {
        return "EventStream";
    }

    public void render() {
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .addModule("EventStream")
                    .call(() -> renderEventStreamHandlers(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth to " + rbFile());
    }

    private void renderEventStreamHandlers(RubyCodeWriter writer) {
        operations.stream()
                .filter((o) -> Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderEventStreamHandler(writer, o));
    }

    private void renderEventStreamHandler(RubyCodeWriter writer, OperationShape operation) {
        String operationName = symbolProvider.toSymbol(operation).getName();

        writer
                .write("")
                .openBlock("class $L", operationName)
                // TODO: Generate signal methods for input events
                // TODO: Generate on methods for output events (handlers)
                .closeBlock("end");
    }
}
