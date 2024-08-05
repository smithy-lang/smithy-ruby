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

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyDependency;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ModuleGenerator {
    private static final Logger LOGGER =
            Logger.getLogger(ModuleGenerator.class.getName());

    private static final String[] DEFAULT_REQUIRES = {
        "auth", "builders", "client", "config", "errors", "endpoint", "middleware",
        "paginators", "params", "parsers", "stubs", "telemetry", "types", "validators", "waiters"
    };

    private final GenerationContext context;
    private final RubySettings settings;
    private final Set<RubyDependency> rubyDependencies;

    public ModuleGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        this.context = directive.context();
        this.settings = directive.settings();
        this.rubyDependencies = context.getRubyDependencies();
    }

    public void render() {
        List<String> additionalFiles = context.integrations().stream()
                .map((integration) -> integration.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .toList();

        String fileName =
            settings.getGemName() + "/lib/" + settings.getGemName() + ".rb";

        context.writerDelegator().useFileWriter(fileName, settings.getModule(), writer -> {
            writer.preamble().includeRequires();
            // determine set of indirect dependencies - covered by requiring another
            Set<RubyDependency> indirectDependencies = new HashSet<>();
            rubyDependencies.forEach(rubyDependency -> {
                indirectDependencies.addAll(rubyDependency.getRubyDependencies());
            });

            rubyDependencies.forEach((rubyDependency -> {
                if (!indirectDependencies.contains(rubyDependency)) {
                    writer.write("require '$L'", rubyDependency.getImportPath());
                }
            }));
            writer.write("\n");

            for (String require : DEFAULT_REQUIRES) {
                writer.write("require_relative '$L/$L'", settings.getGemName(), require);
            }

            if (context.eventStreamTransport().isPresent()) {
                writer.write("require_relative '$L/event_stream'", settings.getGemName());
            }

            for (String require : additionalFiles) {
                writer.write("require_relative '$L'", require);
            }

            writer.write("");

            writer.openBlock("module $L", settings.getModule())
                .write("VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip")
                .closeBlock("end");
        });
        LOGGER.fine("Wrote module file to " + fileName);

        renderRbs();
    }

    /**
     * Render/generate the RBS types for the module.
     */
    private void renderRbs() {
        String fileName =
                settings.getGemName() + "/sig/" + settings.getGemName() + ".rbs";

        context.writerDelegator().useFileWriter(fileName, settings.getModule(), writer -> {
            writer
                    .preamble()
                    .openBlock("module $L", settings.getModule())
                    .write("VERSION: ::String")
                    .closeBlock("end");
        });
    }
}
