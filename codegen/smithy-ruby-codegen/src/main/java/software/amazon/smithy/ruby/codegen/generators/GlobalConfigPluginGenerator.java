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

import java.nio.file.Paths;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Generate Config class for a Client.
 */
@SmithyInternalApi
public class GlobalConfigPluginGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(ConfigGenerator.class.getName());

    public GlobalConfigPluginGenerator(
            ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
    }

    @Override
    protected String getModule() {
        return "Plugins";
    }

    @Override
    public String rbFile() {
        return Paths.get(settings.getGemName(), "lib", settings.getGemName(),
                RubyFormatter.toSnakeCase(getModule()), "global_config.rb").toString();
    }

    public void render() {
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .addModule("Plugins")
                    .openBlock("class GlobalConfig")
                    .write("")
                    .call(() -> renderCallMethod(writer))
                    .write("")
                    .closeBlock("end")
                    .closeAllModules();
        });
        LOGGER.fine("Wrote config defaults plugin to " + rbFile());
    }

    private void renderCallMethod(RubyCodeWriter writer) {
        writer
                .openBlock("def call(config)")
                .write("options = config.options")
                .openBlock("$T.config.each do |key, value|", Hearth.HEARTH)
                .write("config[key] = value unless options.key?(key)")
                .closeBlock("end")
                .closeBlock("end");
    }
}
