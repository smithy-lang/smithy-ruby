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

import java.util.HashSet;
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
    private final String defaultValue;
    private final String initializationCustomization;
    private final String postInitializeCustomization;

    public ClientConfig(Builder builder) {
        this.name = builder.name;
        this.type = builder.type;
        this.documentation = builder.documentation;
        this.defaultValue = builder.defaultValue;
        this.initializationCustomization = builder.initializationCustomization;
        this.postInitializeCustomization = builder.postInitializeCustomization;
    }

    /**
     * Get a set of default configs. These should be added to every generated client.
     *
     * @return Set of default configs to be applied to generated clients
     */
    public static Set<ClientConfig> defaultConfig() {
        Set<ClientConfig> configs = new HashSet();

        ClientConfig middleware = (new Builder())
                .name("middleware")
                .type("MiddlewareBuilder")
                .documentation(
                        "Additional Middleware to be applied for every operation")
                .initializationCustomization(
                        "@middleware = Hearth::MiddlewareBuilder.new(options[:middleware])")
                .build();

        configs.add(middleware);

        return configs;
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
     * @return Ruby code (as a String) that is used to set the default value.
     */
    public String getDefaultValue() {
        return defaultValue;
    }

    /**
     * Allows customization of initialization.
     * If set, this is used instead of the defaultValue.
     * @return initialization customization
     */
    public String getInitializationCustomization() {
        return initializationCustomization;
    }

    /**
     * Allows post initialization customization.
     * Added after all config is initialized.
     * @return post initialize customization
     */
    public String getPostInitializeCustomization() {
        return postInitializeCustomization;
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
        private String defaultValue;
        private String initializationCustomization;
        private String postInitializeCustomization;

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

        public Builder defaultValue(String defaultValue) {
            this.defaultValue = defaultValue;
            return this;
        }

        public Builder initializationCustomization(
                String initializationCustomization) {
            this.initializationCustomization = initializationCustomization;
            return this;
        }

        public Builder postInitializeCustomization(
                String postInitializeCustomization) {
            this.postInitializeCustomization = postInitializeCustomization;
            return this;
        }


        @Override
        public ClientConfig build() {
            return new ClientConfig(this);
        }
    }
}
