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

package software.amazon.smithy.ruby.codegen.config;

import java.util.Objects;
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
    private final ConfigProviderChain defaults;
    private final String postInitializeCustomization;
    private final boolean allowOperationOverride;

    public ClientConfig(Builder builder) {
        this.name = builder.name;
        this.type = builder.type;
        this.documentation = builder.documentation;
        this.documentationDefaultValue = builder.documentationDefaultValue;
        this.defaults = builder.defaults;
        this.postInitializeCustomization = builder.postInitializeCustomization;
        this.allowOperationOverride = builder.allowOperationOverride;
    }

    /**
     * @return The name of the config - this will be the initialization parameter name as well
     * as the member variable name.
     */
    public String getName() {
        return name;
    }

    /**
     * @return The Ruby type of the config (eg String, Number, ect).
     */
    public String getType() {
        return type;
    }

    /**
     * @return Documentation string to be added to the initialize method.
     */
    public String getDocumentation() {
        return documentation;
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
     * Allows post initialization customization.
     * Added after all config is initialized.
     * @return post initialize customization
     */
    public String getPostInitializeCustomization() {

        return postInitializeCustomization;
    }

    /**
     * If true, this config can be overridden
     * per operation.
     * @return allowOperationOverride
     */
    public boolean allowOperationOverride() {
        return allowOperationOverride;
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

    public static class Builder implements SmithyBuilder<ClientConfig> {
        private String name;
        private String type;
        private String documentation;
        private String documentationDefaultValue;
        private ConfigProviderChain defaults;
        private String postInitializeCustomization;
        private boolean allowOperationOverride = false;

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder type(String type) {
            this.type = type;
            return this;
        }

        public Builder documentation(String documentation) {
            this.documentation = documentation;
            return this;
        }

        public Builder documentationDefaultValue(String defaultValue) {
            this.documentationDefaultValue = defaultValue;
            return this;
        }

        public Builder postInitializeCustomization(
                String postInitializeCustomization) {
            this.postInitializeCustomization = postInitializeCustomization;
            return this;
        }

        public Builder allowOperationOverride() {
            this.allowOperationOverride = true;
            return this;
        }

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
