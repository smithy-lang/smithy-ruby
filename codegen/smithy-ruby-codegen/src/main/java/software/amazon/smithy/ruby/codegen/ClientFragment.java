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

import java.util.Collection;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Represents a fragment to be rendered in the generated client.
 * Exposes ClientConfig that is required for rendering the client.
 */
@SmithyInternalApi
public class ClientFragment {
    private final Set<ClientConfig> clientConfig;
    private final RenderOperation render;

    /**
     * @param builder builder to use to construct this fragment.
     */
    public ClientFragment(Builder builder) {
        this.clientConfig = builder.clientConfig;
        this.render = builder.render;
    }

    public static Builder builder() {
        return new Builder();
    }

    /**
     * @return set of client config to apply to support this fragment.
     */
    public Set<ClientConfig> getClientConfig() {
        return clientConfig;
    }

    /**
     * @param context generation context
     * @return rendered fragment
     */
    public String render(GenerationContext context) {
        return render.render(this, context);
    }

    @FunctionalInterface
    /**
     * Called to Render the fragment.
     */
    public interface RenderOperation {
        /**
         * Called to Render the fragment.
         *
         * @param fragment - fragment to render
         * @param context  - additional context
         * @return string to render
         */
        String render(ClientFragment fragment, GenerationContext context);
    }

    /**
     * Builder for ClientFragments.
     */
    public static class Builder implements SmithyBuilder<ClientFragment> {
        private Set<ClientConfig> clientConfig = new HashSet<>();
        private RenderOperation render = (f, c) -> {
            return "";
        };

        /**
         * @param config config to be added to support this fragment.
         * @return this builder.
         */
        public Builder addConfig(ClientConfig config) {
            this.clientConfig.add(Objects.requireNonNull(config));
            return this;
        }

        /**
         * @param config config to be added to support this fragment.
         * @return this builder
         */
        public Builder config(Collection<ClientConfig> config) {
            this.clientConfig = new HashSet<>(config);
            return this;
        }

        /**
         * @param r code to render this fragment
         * @return this builder
         */
        public Builder render(RenderOperation r) {
            this.render = r;
            return this;
        }

        /**
         * @param staticRubyStatement static ruby statement to render
         * @return this builder
         */
        public Builder render(String staticRubyStatement) {
            this.render = (f, c) -> {
                return staticRubyStatement;
            };
            return this;
        }

        @Override
        public ClientFragment build() {
            return new ClientFragment(this);
        }
    }
}
