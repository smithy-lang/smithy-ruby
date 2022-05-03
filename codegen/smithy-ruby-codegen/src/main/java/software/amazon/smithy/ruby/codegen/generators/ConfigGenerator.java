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

import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.ruby.codegen.ClientConfig;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ConfigGenerator {
    private static final Logger LOGGER =
            Logger.getLogger(ConfigGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final RubySymbolProvider symbolProvider;

    public ConfigGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.settings();
        this.model = context.model();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Config", false);
    }

    public void render(List<ClientConfig> clientConfigList) {
        FileManifest fileManifest = context.fileManifest();

        String membersBlock = "nil";
        if (!clientConfigList.isEmpty()) {
            membersBlock = clientConfigList
                    .stream()
                    .map(clientConfig -> RubyFormatter.asSymbol(symbolProvider.toMemberName(clientConfig.getName())))
                    .collect(Collectors.joining(",\n"));
        }
        membersBlock += ",";

        writer
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("Config = ::Struct.new(")
                .write(membersBlock)
                .write("keyword_init: true")
                .closeBlock(") do")
                .indent()
                .call(() -> renderBuildMethod(clientConfigList))
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

    public void renderRbs() {

    }

    private void renderBuildMethod(List<ClientConfig> clientConfigList) {
        writer
                .call(() -> renderBuildMethodDocumentation(clientConfigList))
                .openBlock("def self.build(options = {})")
                .write("config = Hearth::Config::Resolver.new($L::Config, defaults).build(options)",
                        settings.getModule())
                .write("validate!(config)")
                .write("config")
                .closeBlock("end");
    }

    private void renderBuildMethodDocumentation(List<ClientConfig> clientConfigList) {
        writer.writeDocs((w) -> {
            clientConfigList.forEach((clientConfig) -> {
                String member = RubyFormatter.asSymbol(symbolProvider.toMemberName(clientConfig.getName()));
                String defaultValue = clientConfig.getDefaultValue();
                if (defaultValue == null) {
                    defaultValue = "";
                }
                String documentation = clientConfig.getDocumentation();
                if (documentation == null) {
                    documentation = "";
                }

                w.writeYardOption("options", clientConfig.getType(), member, defaultValue, documentation);
            });
        });
    }

    private void renderValidateMethod(List<ClientConfig> clientConfigList) {
        writer.openBlock("def self.validate!(config)");
        clientConfigList.stream().forEach(clientConfig -> {
            String member = RubyFormatter.asSymbol(symbolProvider.toMemberName(clientConfig.getName()));
            String type = clientConfig.getType();
            if (type.equals("Boolean")) {
                type = "TrueClass, FalseClass";
            }
            writer.write("Hearth::Validator.validate!(config[$1L], $2L, context: 'config[$1L]')", member, type);
        });
        writer.closeBlock("end");
    }

    private void renderDefaultsMethod(List<ClientConfig> clientConfigList) {
        writer
                .openBlock("def self.defaults")
                .write("defaults = {}")
                .write("# TODO");
        clientConfigList.stream().forEach(clientConfig -> {
            // TODO
        });
        writer
                .write("defaults")
                .closeBlock("end");
    }
}
