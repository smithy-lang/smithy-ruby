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
import java.util.Objects;
import java.util.Set;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Describes config values to be added to generated Client classes.
 */
@SmithyUnstableApi
public class ClientConfig {

    private final String name;
    private final String documentation;
    private final String documentationType;
    private final String rbsType;
    private final ConfigDefaults defaults;
    private final List<ConfigConstraint> constraints;

    /**
     * @param builder builder to construct from.
     */
    public ClientConfig(Builder builder) {
        this.name = builder.name;
        this.documentation = builder.documentation;
        this.documentationType = builder.documentationType != null ? builder.documentationType : builder.type;
        this.rbsType = builder.rbsType != null ? builder.rbsType : builder.type;
        if (builder.defaults != null) {
            this.defaults = builder.defaults;
        } else {
            this.defaults = new DefaultLiteral("[]");
        }
        if (builder.documentationDefaultValue != null) {
            this.defaults.setDocumentationDefault(builder.documentationDefaultValue);
        }
        this.constraints = List.copyOf(builder.constraints);
    }

    public static Builder builder() {
        return new Builder();
    }

    /**
     * @return The name of the config - this will be the initialization parameter name as well
     * as the member variable name.
     */
    public String getName() {
        return name;
    }

    /**
     * @return The config value using the config's accessor.
     */
    public String renderGetConfigValue() {
        return "config." + getName();
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
        return defaults.getDocumentationDefault().orElse("");
    }

    /**
     * @return Documented type
     */
    public String getDocumentationType() {
        return documentationType;
    }

    /**
     * @return The Rbs type
     */
    public String getRbsType() {
        return rbsType;
    }

    /**
     * Render the defaults for this config.
     *
     * @param context generation context
     */
    public String renderDefaults(GenerationContext context) {
        return defaults.renderDefault(context);
    }

    /**
     * @return a list of ConfigConstraint objects.
     */
    public List<ConfigConstraint> getConstraints() {
        return constraints;
    }

    /**
     * @param configCollection set of config to add this ClientConfig and all of its dependent config to.
     */
    public void addToConfigCollection(Set<ClientConfig> configCollection) {
        if (!configCollection.contains(this)) {
            configCollection.add(this);
            defaults.addToConfigCollection(configCollection);
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
                && Objects.equals(getDocumentationType(), that.getDocumentationType());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getName(), getDocumentationType());
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
        private String rbsType;
        private ConfigDefaults defaults;
        private final List<ConfigConstraint> constraints;

        protected Builder() {
            constraints = new ArrayList<>();
        }

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
         * @param defaultValue an optional default value to be use in documentation.
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
         * @param type an optional type to use in RBS (defaults to the type).
         * @return this builder
         */
        public Builder rbsType(String type) {
            this.rbsType = type;
            return this;
        }

        /**
         * @param defaults chain of default providers to use.
         * @return this builder.
         */
        public Builder defaults(ConfigDefaults defaults) {
            validateDefaultNotSet();
            this.defaults = defaults;
            return this;
        }

        /**
         * @param value a single non-shared default. Initialized on each creation of Config.
         * @return this builder
         */
        public Builder defaultValue(String value) {
            validateDefaultNotSet();
            this.defaults = ConfigProviderChain.builder().staticProvider(value).build();
            return this;
        }

        /**
         * @param rubyProcBody The body of a ruby proc that provides a default value. The proc body is wrapped
         *                     in a proc with a single argument, cfg, which is the config object.
         *                     As an example, a proc body of "cfg.logger" would be equivalent to
         *                     "proc { |cfg| cfg.logger }"
         * @return this builder
         */
        public Builder defaultDynamicValue(String rubyProcBody) {
            validateDefaultNotSet();
            this.defaults = ConfigProviderChain.builder().dynamicProvider(rubyProcBody).build();
            return this;
        }

        /**
         * @param constraint a ConfigConstraint object.
         * @return this builder.
         */
        public Builder constraint(ConfigConstraint constraint) {
            this.constraints.add(constraint);
            return this;
        }

        @Override
        public ClientConfig build() {
            return new ClientConfig(this);
        }

        private void validateDefaultNotSet() {
            if (defaults != null) {
                throw new IllegalArgumentException("ConfigDefaults have already been set.");
            }
        }
    }
}
