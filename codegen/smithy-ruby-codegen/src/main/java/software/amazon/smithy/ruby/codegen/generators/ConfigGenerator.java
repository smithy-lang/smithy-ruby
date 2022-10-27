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
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
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
public class ConfigGenerator {
    private static final Logger LOGGER =
            Logger.getLogger(ConfigGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final SymbolProvider symbolProvider;

    /**
     * @param context generation context
     */
    public ConfigGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.settings();
        this.model = context.model();
        this.writer = new RubyCodeWriter(context.settings().getModule() + "::Config");
        this.rbsWriter = new RubyCodeWriter(context.settings().getModule() + "::Config");
        this.symbolProvider = context.symbolProvider();
    }

    /**
     * Render/Generate the Config for the client.
     * @param clientConfigList list of config to apply to the client.
     */
    public void render(List<ClientConfig> clientConfigList) {
        FileManifest fileManifest = context.fileManifest();

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
                .includePreamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .call(() -> renderConfigDocumentation(clientConfigList))
                .openBlock("Config = ::Struct.new(")
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(") do")
                .indent()
                .write("include $T", Hearth.CONFIGURATION)
                .write("\nprivate\n")
                .call(() -> renderValidateMethod(clientConfigList))
                .write("")
                .call(() -> renderDefaultsMethod(clientConfigList))
                .closeBlock("end")
                .closeBlock("end\n");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName()
                        + "/config.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote config to " + fileName);
    }

    /**
     * Render/generate the RBS types for Config.
     */
    public void renderRbs() {
        FileManifest fileManifest = context.fileManifest();

        rbsWriter
                .openBlock("module $L", settings.getModule())
                .write("Config: untyped")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/config.rbs";
        fileManifest.writeFile(fileName, rbsWriter.toString());
        LOGGER.fine("Wrote config rbs to " + fileName);
    }

    private void renderConfigDocumentation(List<ClientConfig> clientConfigList) {
        writer.writeYardMethod("initialize(*options)", () -> {
            clientConfigList.forEach((clientConfig) -> {
                String member = RubyFormatter.asSymbol(RubySymbolProvider.toMemberName(clientConfig.getName()));
                String returnType = clientConfig.getType();
                String defaultValue = clientConfig.getDocumentationDefaultValue();
                String documentation = clientConfig.getDocumentation();
                writer.writeYardOption("args", returnType, member, defaultValue, documentation);
            });
        });
        clientConfigList.forEach((clientConfig) -> {
            String member = RubySymbolProvider.toMemberName(clientConfig.getName());
            writer.writeYardAttribute(member, () -> {
                writer.writeYardReturn(clientConfig.getType(), "");
            });
        });
    }

    private void renderValidateMethod(List<ClientConfig> clientConfigList) {
        writer.openBlock("def validate!");
        clientConfigList.stream().forEach(clientConfig -> {
            String member = RubySymbolProvider.toMemberName(clientConfig.getName());
            String type = clientConfig.getType();
            if (type.equals("Boolean")) {
                type = "TrueClass, FalseClass";
            }
            writer.write("$3T.validate!($1L, $2L, context: 'options[:$1L]')",
                    member, type, Hearth.VALIDATOR);
            // TODO - add constraints here
        });
        writer.closeBlock("end");
    }

    private void renderDefaultsMethod(List<ClientConfig> clientConfigList) {
        writer
                .openBlock("def self.defaults")
                .openBlock("@defaults ||= {");

        clientConfigList.forEach(clientConfig -> {
            String defaults = clientConfig.getDefaults().getProviders().stream()
                    .map((p) -> p.providerFragment().render(context))
                    .collect(Collectors.joining(","));
            writer.write("$L: [$L],", clientConfig.getName(), defaults);
        });

        writer
                .unwrite(",\n")
                .closeBlock("\n}.freeze")
                .closeBlock("end");
    }
}
