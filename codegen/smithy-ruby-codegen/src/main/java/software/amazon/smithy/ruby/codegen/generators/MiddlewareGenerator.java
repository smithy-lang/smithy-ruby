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
import software.amazon.smithy.codegen.core.directed.GenerateServiceDirective;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Generate the middleware builders for the Client.
 */
@SmithyInternalApi
public class MiddlewareGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(MiddlewareGenerator.class.getName());

    private final Set<OperationShape> operations;
    private final MiddlewareBuilder middlewareBuilder;

    public MiddlewareGenerator(
            GenerateServiceDirective<GenerationContext, RubySettings> directive,
            MiddlewareBuilder middlewareBuilder
    ) {
        super(directive);
        this.operations = directive.operations();
        this.middlewareBuilder = middlewareBuilder;
    }

    @Override
    String getModule() {
        return "Middleware";
    }

    /**
     * Render/Generate the middleware for the service client.
     */
    public void render() {
        List<String> additionalFiles = middlewareBuilder.writeAdditionalFiles(context);
        additionalFiles.sort(String::compareTo);

        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .writeRequireRelativeAdditionalFiles(additionalFiles)
                    .addModule(settings.getModule())
                    .addModule("Middleware")
                    .call(() -> renderOperations(writer))
                    .write("")
                    .closeAllModules();
        });

        LOGGER.fine("Wrote client to " + rbFile());
    }

    private void renderOperations(RubyCodeWriter writer) {
        operations.stream()
                .filter((o) -> !Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderOperation(writer, o));
    }

    private void renderOperation(RubyCodeWriter writer, OperationShape operation) {
        String operationName = symbolProvider.toSymbol(operation).getName();

        writer
                .write("")
                .openBlock("class $L", operationName)
                .openBlock("def self.build(config, stubs)")
                .write("stack = $T.new", Hearth.MIDDLEWARE_STACK)
                .call(() -> middlewareBuilder.render(writer, context, operation))
                .write("stack")
                .closeBlock("end")
                .closeBlock("end");
        LOGGER.finer("Generated client middleware for operation " + operationName);
    }
}
