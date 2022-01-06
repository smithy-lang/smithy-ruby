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

package software.amazon.smithy.ruby.codegen;

import java.util.Collections;
import java.util.List;
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * JVM SPI for customizing Ruby code generation, registering new protocol
 * generators, renaming shapes, modifying the model, adding custom code, etc.
 */
@SmithyUnstableApi
public interface RubyIntegration {

    /**
     * Should this Integration be included for the given Service.
     *
     * @param service - service to check against
     * @param model   - model for additional context
     * @return true if this integration should apply to the service
     */
    default boolean includeFor(ServiceShape service, Model model) {
        return true;
    }

    /**
     * Gets the sort order of the customization from -128 to 127.
     *
     * <p>Customizations are applied according to this sort order. Lower values
     * are executed before higher values (for example, -128 comes before 0,
     * comes before 127). Customizations default to 0, which is the middle point
     * between the minimum and maximum order values. The customization
     * applied later can override the runtime configurations that provided
     * by customizations applied earlier.
     *
     * @return Returns the sort order, defaulting to 0.
     */
    default byte getOrder() {
        return 0;
    }

    /**
     * Gets a list of protocol generators to register.
     *
     * @return Returns the list of protocol generators to register.
     */
    default List<ProtocolGenerator> getProtocolGenerators() {
        return Collections.emptyList();
    }

    /**
     * Preprocess the model before code generation.
     *
     * <p>This can be used to remove unsupported features, remove traits
     * from shapes (e.g., make members optional), etc.
     *
     * @param context  - plugin context
     * @param model    model definition.
     * @param settings Setting used to generate.
     * @return Returns the updated model.
     */
    default Model preprocessModel(PluginContext context, Model model,
                                  RubySettings settings) {
        return model;
    }

    /**
     * Updates the {@link SymbolProvider} used when generating code.
     *
     * <p>This can be used to customize the names of shapes, the package
     * that code is generated into, add dependencies, add imports, etc.
     *
     * @param context        plugin context
     * @param settings       Setting used to generate.
     * @param model          Model being generated.
     * @param symbolProvider The original {@code SymbolProvider}.
     * @return The decorated {@code SymbolProvider}.
     */
    default SymbolProvider decorateSymbolProvider(
            PluginContext context,
            RubySettings settings,
            Model model,
            SymbolProvider symbolProvider
    ) {
        return symbolProvider;
    }

    /**
     * Processes the finalized model before runtime plugins are consumed and
     * code generation starts. This plugin can be used to add RuntimeClientPlugins
     * to the integration's list of plugin.
     *
     * @param context - generation context to process within
     */
    default void processFinalizedModel(GenerationContext context) {
        // pass
    }

    /**
     * Return all of the Middleware to be registered on the Client.
     *
     * @return list of middleware to be registered on the client
     */
    default List<Middleware> getClientMiddleware() {
        return Collections.emptyList();
    }

    /**
     * Returns a list of additional (non-middleware) Config
     * to be added to the generated Client.
     *
     * @return list of additional config
     */
    default List<ClientConfig> getAdditionalClientConfig() {
        return Collections.emptyList();
    }

    /**
     * Writes additional files.
     *
     * @param context - context for generation
     * @return List of relative paths generated to be added to module requires.
     */
    default List<String> writeAdditionalFiles(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Adds additional Gem Dependencies.
     *
     * @param context - context for generation
     * @return List of relative paths generated to be added to module requires.
     */
    default List<RubyDependency> additionalGemDependencies(
            GenerationContext context) {
        return Collections.emptyList();
    }
}
