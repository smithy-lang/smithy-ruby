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

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Describes config values to be added to generated Client classes.
 */
@SmithyUnstableApi
public class ConfigProviderChain {

    private final List<ConfigProvider> providers;

    public ConfigProviderChain(Builder builder) {
        this.providers = builder.providers;
    }

    /**
     * @return an ordered list of all of the providers.
     */
    public List<ConfigProvider> getProviders() {
        return List.copyOf(this.providers);
    }

    public Optional<String> getDocumentationDefault() {
        return providers.stream().map( (p) -> p.getDocumentationDefault() )
                .filter( (d) -> d.isPresent() )
                .map( (d) -> d.get() )
                .findFirst();
    }

    public static class Builder implements SmithyBuilder<ConfigProviderChain> {
        private List<ConfigProvider> providers;

        private Builder() {
            providers = new ArrayList<>();
        }

        public Builder provider(ConfigProvider provider) {
            this.providers.add(provider);
            return this;
        }

        public Builder staticProvider(String value) {
            this.providers.add( new StaticConfigProvider(value) );
            return this;
        }

        public Builder dynamicProvider(String rubyDefaultBlock) {
            this.providers.add( new DynamicConfigProvider(rubyDefaultBlock) );
            return this;
        }

        @Override
        public ConfigProviderChain build() {
            return new ConfigProviderChain(this);
        }
    }
}
