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

import java.util.Objects;
import java.util.Set;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Describes config values to be added to generated Client classes.
 */
@SmithyUnstableApi
public class ClientConfig {

    private final String name;
    private final String type;
    private final String documentation;
    private final String documentationDefaultValue;
    private final String documentationType;
    private final ConfigProviderChain defaults;
    private final boolean allowOperationOverride;
    private final boolean requiresDeepCopy;

    /**
     * @param builder builder to construct from.
     */
    public ClientConfig(Builder builder) {
        this.name = builder.name;
        this.type = builder.type;
        this.documentation = builder.documentation;
        this.documentationDefaultValue = builder.documentationDefaultValue;
        this.documentationType = builder.documentationType;
        this.defaults = builder.defaults;
        this.allowOperationOverride = builder.allowOperationOverride;
        this.requiresDeepCopy = builder.requiresDeepCopy;
    }

    /**
     * @return The name of the config - this will be the initialization parameter name as well
     * as the member variable name.
     */
    public String getName() {
        return name;
    }

    /**
     * @return The Ruby type of the config (eg String, Integer, Boolean, ect).
     */
    public String getType() {
        return type;
    }

    /**
     * @return Documentation string to be added to the initialize method.
     */
    public String getDocumentation() {
        if (documentation != null) {
            return documentation;
        }
        return "";
    }

    /**
     * @return Documented default value.
     */
    public String getDocumentationDefaultValue() {
        if (documentationDefaultValue != null) {
            return documentationDefaultValue;
        }
        return defaults.getDocumentationDefault().orElse("");
    }

    /**
     * @return Documented type
     */
    public String getDocumentationType() {
        if (documentationType != null) {
            return documentationType;
        }
        return type;
    }

    /**
     * @return chain of defaults to use.
     */
    public ConfigProviderChain getDefaults() {
        return defaults;
    }

    /**
     * If true, this config can be overridden
     * per operation.
     *
     * @return allowOperationOverride
     */
    public boolean allowOperationOverride() {
        return allowOperationOverride;
    }

    /**
     * If true this config needs to be deep copied.
     *
     * @return requiresDeepCopy
     */
    public boolean requiresDeepCopy() {
        return requiresDeepCopy;
    }

    public String renderGetConfigValue() {
        String getConfigValue = "config." + getName();
        if (allowOperationOverride()) {
            getConfigValue = "options.fetch(:" + getName() + ", config." + getName() + ")";
        }
        return getConfigValue;
    }

    /**
     * @param configCollection set of config to add this ClientConfig and all of its dependent config to.
     */
    public void addToConfigCollection(Set<ClientConfig> configCollection) {
        if (!configCollection.contains(this)) {
            configCollection.add(this);
            defaults.getProviders().forEach((p) -> {
                p.providerFragment().getClientConfig()
                        .forEach((c) -> c.addToConfigCollection(configCollection));
            });
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        ClientConfig that = (ClientConfig) o;
        return Objects.equals(getName(), that.getName())
                && Objects.equals(getType(), that.getType());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getName(), getType());
    }

    public static Builder builder() {
        return new Builder();
    }

    /**
     * Builder for ClientConfig.
     */
    public static class Builder implements SmithyBuilder<ClientConfig> {
        private String name;
        private String type;
        private String documentation;
        private String documentationDefaultValue;
        private String documentationType;
        private ConfigProviderChain defaults;
        private boolean allowOperationOverride = false;
        private boolean requiresDeepCopy = false;

        /**
         * @param name name of the config option.
         * @return this builder.
         */
        public Builder name(String name) {
            this.name = name;
            return this;
        }

        /**
         * @param type ruby type for the config.  Used for validation, must be a valid Ruby class.
         * @return this builder.
         */
        public Builder type(String type) {
            this.type = type;
            return this;
        }

        /**
         * @param documentation documentation for the config option.
         * @return this builder.
         */
        public Builder documentation(String documentation) {
            this.documentation = documentation;
            return this;
        }

        /**
         * @param defaultValue an optional default value
         * @return this builder
         */
        public Builder documentationDefaultValue(String defaultValue) {
            this.documentationDefaultValue = defaultValue;
            return this;
        }

        /**
         * @param type an optional type to use in documentation (defaults to the type).
         *             Useful for collection types such as Array[Callable]
         * @return this builder
         */
        public Builder documentationType(String type) {
            this.documentationType = type;
            return this;
        }

        /**
         * allows config value to be overridden by values passed on an operation call.
         *
         * @return this builder
         */
        public Builder allowOperationOverride() {
            this.allowOperationOverride = true;
            return this;
        }

        /**
         * When the config object is copied, this config will have `dup` called on it individually
         * This may be required for collections that may be modified in an operation.
         *
         * @return this builder
         */
        public Builder requiresDeepCopy() {
            this.requiresDeepCopy = true;
            return this;
        }

        /**
         * @param value a single, static default value to use. This should only be used for primitives like
         *              Integer, Boolean or String.
         * @return this builder
         */
        public Builder defaultPrimitiveValue(String value) {
            this.defaults = new ConfigProviderChain.Builder().staticProvider(value).build();
            return this;
        }

        /**
         * @param value a single non-shared default. Initialized on each creation of Config.
         * @return this builder
         */
        public Builder defaultValue(String value) {
            this.defaults = new ConfigProviderChain.Builder()
                    .dynamicProvider("proc { " + value + "}")
                    .build();
            return this;
        }

        /**
         * @param defaults chain of default providers to use.
         * @return this builder.
         */
        public Builder defaults(ConfigProviderChain defaults) {
            this.defaults = defaults;
            return this;
        }

        @Override
        public ClientConfig build() {
            return new ClientConfig(this);
        }
    }
}
