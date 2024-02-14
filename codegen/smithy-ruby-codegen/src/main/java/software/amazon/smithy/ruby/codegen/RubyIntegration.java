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
import software.amazon.smithy.codegen.core.SmithyIntegration;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.rulesengine.BuiltInBinding;
import software.amazon.smithy.ruby.codegen.rulesengine.FunctionBinding;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * JVM SPI for customizing Ruby code generation, registering new protocol
 * generators, renaming shapes, modifying the model, adding custom code, etc.
 */
@SmithyUnstableApi
public interface RubyIntegration extends SmithyIntegration<RubySettings, RubyCodeWriter, GenerationContext> {

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
     * Return all of the Middleware to be registered on the Client.
     *
     * @param middlewareBuilder - Client middleware to be modified
     * @param context           - Generation context to process within
     */
    default void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context) {
        // pass
    }

    /**
     * Returns a List of additional (non-middleware) Config to be added to the generated Client.
     *
     * @param context - Generation context to process within
     * @return List of ClientConfig to be added
     */
    default List<ClientConfig> getAdditionalClientConfig(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Returns a List of RubyRuntimePlugins to be added to the generated Client.
     *
     * @param context - Generation context to process within
     * @return List of RubyRuntimePlugins
     */
    default List<RubyRuntimePlugin> getRuntimePlugins(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Returns a List of additional Auth Schemes to be added to the generated Auth module and middleware.
     *
     * @param context - Generation context to process within
     * @return List of AuthSchemes to be added
     */
    default List<AuthScheme> getAdditionalAuthSchemes(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Returns a List of additional Gem Dependencies.
     *
     * @param context - Generation context to process within
     * @return List of RubyDependency to be added
     */
    default List<RubyDependency> getAdditionalGemDependencies(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Writes additional files.
     *
     * @param context - Generation context to process within
     * @return List of relative paths generated to be added to module requires.
     */
    default List<String> writeAdditionalFiles(GenerationContext context) {
        return Collections.emptyList();
    }

    /**
     * Additional Smithy rules engine built-in bindings supported by this integration.
     *
     * @return list of rules engine built-in bindings.
     */
    default List<BuiltInBinding> builtInBindings() {
        return Collections.emptyList();
    }

    /**
     * Additional Smithy rules engine function bindings supported by this integration.
     *
     * @return list of rules engine function bindings.
     */
    default List<FunctionBinding> functionBindings() {
        return Collections.emptyList();
    }
}
