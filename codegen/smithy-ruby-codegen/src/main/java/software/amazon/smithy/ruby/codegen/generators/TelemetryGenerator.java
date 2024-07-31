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
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.StringUtils;

public class TelemetryGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(ParamsGenerator.class.getName());

    private final Set<OperationShape> operations;

    public TelemetryGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.operations = directive.operations();
    }

    @Override
    protected String getModule() {
        return "Telemetry";
    }

    public void render() {
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .apiPrivate()
                    .addModule("Telemetry")
                    .call(() -> renderOperations(writer))
                    .write("")
                    .closeAllModules();
        });
        LOGGER.fine("Wrote telemetry to " + rbFile());
    }

    private void renderOperations(RubyCodeWriter writer) {
        operations.stream()
                .filter((o) -> !Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(writer, o));
    }

    private void renderOperation(RubyCodeWriter writer, OperationShape operation) {
        String classOperationName = symbolProvider.toSymbol(operation).getName();
        String operationName = RubyFormatter.toSnakeCase(classOperationName);
        String sdkId = settings.getSdkId();

        writer
                .write("")
                .openBlock("class $L", classOperationName)
                .openBlock("def self.in_span(context, &block)")
                .openBlock("attributes = {")
                .write("'rpc.service' => '$L',", sdkId)
                .write("'rpc.method' => '$L',", classOperationName)
                .write("'code.function' => '$L',", operationName)
                .write("'code.namespace' => '$L'", nameSpace())
                .closeBlock("}")
                .openBlock("context.tracer.in_span(")
                .write("'$L.$L',", StringUtils.trim(sdkId), classOperationName)
                .write("attributes: attributes,")
                .write("kind: $T,", Hearth.CLIENT_SPAN_KIND)
                .write("&block")
                .closeBlock(")")
                .closeBlock("end")
                .closeBlock("end");
    }
}
