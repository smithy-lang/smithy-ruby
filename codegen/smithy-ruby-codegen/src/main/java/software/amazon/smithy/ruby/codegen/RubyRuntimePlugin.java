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

import java.util.Collections;
import java.util.List;
import java.util.Objects;
import software.amazon.smithy.ruby.codegen.util.RubySource;
import software.amazon.smithy.utils.SmithyBuilder;

/**
 * Describes a runtime plugin to be added to a generated client.
 */
public class RubyRuntimePlugin {

    private final RenderAdd renderAdd;
    private final WriteAdditionalFiles writeAdditionalFiles;

    public RubyRuntimePlugin(Builder builder) {
        this.renderAdd = Objects.requireNonNull(builder.renderAdd);
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
    }

    /**
     * Generate code to add this plugin to the list of client class plugins.
     *
     * @param context generation context
     * @return rendered string
     */
    public String renderAdd(GenerationContext context) {
        return renderAdd.renderAdd(context);
    }

    /**
     * Write additional files required by this plugin.
     *
     * @param context generation context
     * @return relative paths of additional files written (for require)
     */
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return writeAdditionalFiles.writeAdditionalFiles(context);
    }

    public static Builder builder() {
        return new Builder();
    }

    @FunctionalInterface
    /**
     * Called to Render the addition of this plugin to list of client plugins.
     */
    public interface RenderAdd {
        /**
         * Called to Render the addition of this plugin to list of client plugins.
         *
         * @param context - additional context
         * @return rendered string used to add this plugin to the list of client plugins
         */
        String renderAdd(GenerationContext context);
    }

    /**
     * Builder for {@link RubyRuntimePlugin}.
     */
    public static class Builder implements SmithyBuilder<RubyRuntimePlugin> {
        private WriteAdditionalFiles writeAdditionalFiles = (context) -> Collections.emptyList();
        private RenderAdd renderAdd;

        /**
         * Used to copy a Ruby source file that defines a plugin into the generated SDK.
         * The copied file must be a plugin class (implements call method) under the Plugins namespace.
         * This method will apply the generated service's namespace to the source file.
         *
         * @param rubyFileName the file name (with path) of the ruby file to copy.
         * @return Return the Builder
         */
        public Builder rubySource(String rubyFileName) {
            this.writeAdditionalFiles = RubySource.rubySource(rubyFileName, "plugins/");
            return this;
        }

        /**
         * Plugins may be implemented via classes with the `call(config)` method.
         * Setting the pluginClass will initialize the provided class with no arguments
         * and add it to the list of client class plugins.
         *
         * @param pluginClass - the fully qualified class name of the plugin to add
         * @return this builder
         */
        public Builder pluginClass(String pluginClass) {
            this.renderAdd = (context) -> pluginClass + ".new";
            return this;
        }

        @Override
        public RubyRuntimePlugin build() {
            return new RubyRuntimePlugin(this);
        }
    }
}
