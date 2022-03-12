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
import software.amazon.smithy.codegen.core.SmithyIntegration;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.utils.CodeWriter;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * JVM SPI for customizing Ruby code generation, registering new protocol
 * generators, renaming shapes, modifying the model, adding custom code, etc.
 */
@SmithyUnstableApi
public interface RubyIntegration extends SmithyIntegration<RubySettings, CodeWriter, GenerationContext> {

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
     * Gets a list of protocol generators to register.
     *
     * @return Returns the list of protocol generators to register.
     */
    default List<ProtocolGenerator> getProtocolGenerators() {
        return Collections.emptyList();
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
