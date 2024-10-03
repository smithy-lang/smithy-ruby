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

package software.amazon.smithy.ruby.codegen.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.ruby.codegen.ClientFragment;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Describes config values to be added to generated Client classes.
 */
@SmithyUnstableApi
public class ConfigProviderChain implements ConfigDefaults {

    private final List<ConfigProvider> providers;
    private Optional<String> documentationDefaultOverride;

    /**
     * @param builder builder to construct the chain from.
     */
    public ConfigProviderChain(Builder builder) {
        this.providers = builder.providers;
        documentationDefaultOverride = Optional.empty();
    }

    /**
     * @return a new builder
     */
    public static Builder builder() {
        return new Builder();
    }

    @Override
    public String renderDefault(GenerationContext context) {
        return "[" + providers.stream()
                .map((p) -> p.providerFragment().render(context))
                .collect(Collectors.joining(", ")) + "]";
    }

    /**
     * @return a string if there should be documentation for the default.
     */
    public Optional<String> getDocumentationDefault() {
        if (documentationDefaultOverride.isPresent()) {
            return documentationDefaultOverride;
        }

        return providers.stream().map((p) -> p.getDocumentationDefault())
                .filter((d) -> d.isPresent())
                .map((d) -> d.get())
                .findFirst();
    }

    @Override
    public void setDocumentationDefault(String documentationDefault) {
        this.documentationDefaultOverride = Optional.of(documentationDefault);
    }

    @Override
    public void addToConfigCollection(Set<ClientConfig> configCollection) {
        providers.forEach(p -> configCollection.addAll(p.providerFragment().getClientConfig()));
    }

    /**
     * Builder for generating an ordered list of config providers.
     */
    public static class Builder implements SmithyBuilder<ConfigProviderChain> {
        private final List<ConfigProvider> providers;

        protected Builder() {
            providers = new ArrayList<>();
        }

        public Builder provider(ConfigProvider provider) {
            this.providers.add(provider);
            return this;
        }

        /**
         * @param value static value
         * @return this builder
         */
        public Builder staticProvider(String value) {
            this.providers.add(new StaticConfigProvider(value));
            return this;
        }

        /**
         * @param rubyProcBody The body of a ruby proc that provides a default value. The proc body is wrapped
         *                     in a proc with a single argument, cfg, which is the config object.
         *                     As an example, a proc body of "cfg.logger" would be equivalent to
         *                     "proc { |cfg| cfg.logger }"
         * @return this builder
         */
        public Builder dynamicProvider(String rubyProcBody) {
            this.providers.add(new DynamicConfigProvider("proc { |cfg| " + rubyProcBody + " }"));
            return this;
        }

        /**
         * @param providerFragment a ClientFragment to provide a value
         * @return this builder
         */
        public Builder dynamicProvider(ClientFragment providerFragment) {
            this.providers.add(new DynamicConfigProvider(providerFragment));
            return this;
        }

        /**
         * @param environmentKey ENV key to get value from
         * @param type           ruby type to attempt to coerce the value to
         * @return this builder
         */
        public Builder envProvider(String environmentKey, String type) {
            this.providers.add(new EnvConfigProvider(environmentKey, type));
            return this;
        }

        /**
         * @param configKey the key in the shared config files
         * @param type      ruby type to attempt to coerce the value to
         * @return this builder
         */
        public Builder sharedConfigProvider(String configKey, String type) {
            this.providers.add(new SharedConfigProvider(configKey, type));
            return this;
        }

        @Override
        public ConfigProviderChain build() {
            return new ConfigProviderChain(this);
        }
    }
}
