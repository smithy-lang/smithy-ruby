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

package software.amazon.smithy.ruby.codegen;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.build.SmithyBuildException;
import software.amazon.smithy.build.SmithyBuildPlugin;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.shapes.ModelSerializer;
import software.amazon.smithy.utils.IoUtils;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Plugin to trigger Ruby code generation.
 * Checks the environment for required dependencies and then shells out to
 * the ruby based code generation.
 */
@SmithyInternalApi
public class RubyCodegenPlugin implements SmithyBuildPlugin {
    private static final Logger LOGGER = Logger.getLogger(RubyCodegenPlugin.class.getName());
    private final Path root = Paths.get(".").toAbsolutePath().normalize();

    @Override
    public String getName() {
        return "ruby-codegen";
    }

    @Override
    public void execute(PluginContext context) {
        RubySettings settings = RubySettings.from(context.getSettings());
        ensureDirectoryExists(context);
        checkEnvironment(context);
        bundleInstall(context);
        runCommand(context, settings);

    }

    private void ensureDirectoryExists(PluginContext context) {
        try {
            Files.createDirectories(context.getFileManifest().getBaseDir());
        } catch (IOException e) {
            throw new SmithyBuildException("Error creating plugin directory for " + getName(), e);
        }
    }

    private void checkEnvironment(PluginContext context) {
       // TODO: Validate that ruby, bundler and gemfile all exist and are valid.
    }

    private void bundleInstall(PluginContext context) {
        List<String> command = List.of("bundle", "install");

        Appendable appendable = new StringBuilder();
        Map<String, String> env = new HashMap<>();

        // TODO: Figure out how to get the right path when running with gradle rather than smithy cli.
        // root is correct for smithy-cli.

        int result;
        try {
            result = IoUtils.runCommand(command, root, appendable, env);
        } catch (RuntimeException e) {
            throw new SmithyBuildException("Error running Ruby sdk code generation `" + String.join(" ", command)
                    + "': " + e.getMessage(), e);
        }

        if (result != 0) {
            throw new SmithyBuildException(("Error exit code " + result + "running in" + root + " returned from: `"
                    + String.join(" ", command) + "`: " + appendable).trim());
        }

        LOGGER.fine(() -> command.get(0) + " output: " + appendable);
    }

    private Map<String, String> prepareEnvironment(PluginContext context) {
        Map<String, String> env = new HashMap<>();
        env.putIfAbsent("SMITHY_ROOT_DIR", root.toString());
        env.putIfAbsent("SMITHY_PLUGIN_DIR", context.getFileManifest().getBaseDir().toString());
        env.putIfAbsent("SMITHY_PROJECTION_NAME", context.getProjectionName());
        return env;
    }


    private void runCommand(PluginContext context, RubySettings settings) {
        Path baseDir = context.getFileManifest().getBaseDir();
        List<String> command = new ArrayList<>(List.of("bundle", "exec", "generate-sdk"));
        command.add("--module");
        command.add(settings.getModule());
        // TODO: Translate all settings to ARGS

        InputStream inputStream = serializeModel(context.getModel());
        Appendable appendable = new StringBuilder();
        Map<String, String> env = new HashMap<>(); // TODO: Could add ENV from settings

        LOGGER.info(() -> "Running Ruby SDK code generation " + ": " + command);

        int result;
        try {
            result = IoUtils.runCommand(command, baseDir, inputStream, appendable, env);
        } catch (RuntimeException e) {
            throw new SmithyBuildException("Error running Ruby sdk code generation `" + String.join(" ", command)
                    + "': " + e.getMessage(), e);
        }

        if (result != 0) {
            throw new SmithyBuildException(("Error exit code " + result + " returned from: `"
                    + String.join(" ", command) + "`: " + appendable).trim());
        }

        LOGGER.fine(() -> command.get(0) + " output: " + appendable);
    }

    private InputStream serializeModel(Model model) {
        ModelSerializer serializer = ModelSerializer.builder()
                .includePrelude(false)
                .build();
        String jsonModel = Node.printJson(serializer.serialize(model));
        return new ByteArrayInputStream(jsonModel.getBytes(StandardCharsets.UTF_8));
    }
}
