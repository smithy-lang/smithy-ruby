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

import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Generate Config class for a Client.
 */
@SmithyInternalApi
public class ConfigGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(ConfigGenerator.class.getName());

    private final List<ClientConfig> clientConfigList;

    public ConfigGenerator(
            ContextualDirective<GenerationContext, RubySettings> directive, List<ClientConfig> clientConfigList) {
        super(directive);
        this.clientConfigList = clientConfigList;
    }

    @Override
    String getModule() {
        return "Config";
    }

    public void render() {
        write(writer -> {
            String membersBlock = "nil";
            if (!clientConfigList.isEmpty()) {
                membersBlock = clientConfigList
                        .stream()
                        .map(clientConfig -> RubyFormatter.asSymbol(
                                RubySymbolProvider.toMemberName(clientConfig.getName())))
                        .collect(Collectors.joining(",\n"));
            }
            membersBlock += ",";

            writer
                    .preamble()
                    .includeRequires()
                    .openBlock("module $L", settings.getModule())
                    .call(() -> renderConfigDocumentation(writer))
                    .openBlock("Config = ::Struct.new(")
                    .write(membersBlock)
                    .write("keyword_init: true")
                    .closeBlock(") do")
                    .indent()
                    .write("include $T", Hearth.CONFIGURATION)
                    .write("\nprivate\n")
                    .call(() -> renderValidateMethod(writer))
                    .write("")
                    .call(() -> renderDefaultsMethod(writer))
                    .closeBlock("end")
                    .closeBlock("end\n");
        });

        LOGGER.fine("Wrote config to " + rbFile());
    }

    /**
     * Render/generate the RBS types for Config.
     */
    public void renderRbs() {
        writeRbs(writer -> {
            writer
                    .openBlock("module $L", settings.getModule())
                    .write("Config: untyped")
                    .closeBlock("end");
        });
        LOGGER.fine("Wrote config rbs to " + rbsFile());
    }

    private void renderConfigDocumentation(RubyCodeWriter writer) {
        writer.writeYardMethod("initialize(*options)", () -> {
            clientConfigList.forEach((clientConfig) -> {
                String member = RubyFormatter.asSymbol(RubySymbolProvider.toMemberName(clientConfig.getName()));
                String returnType = clientConfig.getDocumentationType();
                String defaultValue = clientConfig.getDocumentationDefaultValue();
                String documentation = clientConfig.getDocumentation();
                writer.writeYardOption("args", returnType, member, defaultValue, documentation);
            });
        });
        clientConfigList.forEach((clientConfig) -> {
            String member = RubySymbolProvider.toMemberName(clientConfig.getName());
            writer.writeYardAttribute(member, () -> {
                writer.writeYardReturn(clientConfig.getDocumentationType(), "");
            });
        });
    }

    private void renderValidateMethod(RubyCodeWriter writer) {
        writer.openBlock("def validate!");
        clientConfigList.forEach(clientConfig -> {
            String member = RubySymbolProvider.toMemberName(clientConfig.getName());
            clientConfig.getConstraints().forEach(c ->
                    writer.write(c.render(member)));
        });
        writer.closeBlock("end");
    }

    private void renderDefaultsMethod(RubyCodeWriter writer) {
        writer
                .openBlock("def self.defaults")
                .openBlock("@defaults ||= {");

        clientConfigList.forEach(clientConfig -> {
            writer.write("$L: $L,", clientConfig.getName(), clientConfig.renderDefaults(context));

        });

        writer
                .unwrite(",\n")
                .closeBlock("\n}.freeze")
                .closeBlock("end");
    }
}
