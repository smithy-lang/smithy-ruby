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

package software.amazon.smithy.ruby.codegen.rulesengine;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import software.amazon.smithy.build.SmithyBuildException;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.WriteAdditionalFiles;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.util.RubySource;
import software.amazon.smithy.rulesengine.language.syntax.parameters.BuiltIns;
import software.amazon.smithy.rulesengine.language.syntax.parameters.Parameter;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.StringUtils;

/**
 * Provides a binding between Smithy rules engine built-ins and Ruby code.
 */
public final class BuiltInBinding {
    private final Parameter builtIn;
    private final Set<ClientConfig> clientConfig;
    private final RenderBuild renderBuild;
    private final RenderTestSet renderTestSet;
    private final WriteAdditionalFiles writeAdditionalFiles;

    private BuiltInBinding(Builder builder) {
        this.builtIn = builder.builtIn;
        this.clientConfig = builder.clientConfig;
        this.renderBuild = builder.renderBuild;
        this.renderTestSet = builder.renderTestSet;
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static Set<BuiltInBinding> defaultBuiltInBindings() {

        return Set.of(
                BuiltInBinding.builder()
                        .builtIn(BuiltIns.SDK_ENDPOINT)
                        .fromConfig(ClientConfig.builder()
                                .name("endpoint")
                                .type("String")
                                .documentation("Endpoint of the service")
                                .defaultDynamicValue("cfg[:stub_responses] ? 'http://localhost' : nil")
                                .build())
                        .build()
        );
    }

    /**
     * @return rules engine built-in this binding is for.
     */
    public Parameter getBuiltIn() {
        return builtIn;
    }

    /**
     * @return clientConfig to be added to the client to support this built-in.
     */
    public Set<ClientConfig> getClientConfig() {
        return clientConfig;
    }

    /**
     * Generate code to add build (set) the endpoint parameter.
     *
     * @param writer    writer
     * @param context   generation context
     * @param operation operation to add to
     */
    public void renderBuild(RubyCodeWriter writer, GenerationContext context,
                            OperationShape operation) {
        renderBuild.renderBuild(writer, this, operation, context);
    }

    /**
     * Generate code to add build (set) the endpoint parameter.
     *
     * @param writer    writer
     * @param context   generation context
     * @param value     value to set
     * @param operation operation to add to
     */
    public void renderTestSet(RubyCodeWriter writer, GenerationContext context,
                              Node value, OperationShape operation) {
        renderTestSet.renderTestSet(writer, this, value, operation, context);
    }

    /**
     * Write additional files required by this built-in builder.
     *
     * @param context generation context
     * @return List of additional files written out
     */
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return writeAdditionalFiles.writeAdditionalFiles(context);
    }

    @Override
    public int hashCode() {
        return Objects.hash(builtIn);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof BuiltInBinding)) {
            return false;
        }

        BuiltInBinding other = (BuiltInBinding) o;

        return this.builtIn.equals(other.builtIn);
    }

    @FunctionalInterface
    /**
     * Called to render the build for this parameter.
     */
    public interface RenderBuild {
        /**
         * Called to render the build for this parameter.
         *
         * @param writer         - codewriter to render with
         * @param builtInBinding - builtInBinding to render for
         * @param operation      - operation being rendered
         * @param context        - generation context
         */
        void renderBuild(RubyCodeWriter writer, BuiltInBinding builtInBinding,
                         OperationShape operation, GenerationContext context);
    }

    @FunctionalInterface
    /**
     * Called to render code that sets this BuiltIn during an operationInputTest.
     * This is effectively the opposite of RenderBuild.  It is run in a rspec
     * context with access to a `config` hash and may set values on config, create rspec
     * mocks or create and add interceptors.
     */
    public interface RenderTestSet {
        /**
         * Called to render the build for this parameter.
         *
         * @param writer         - codewriter to render with
         * @param builtInBinding - builtInBinding to render for
         * @param value          - value to set
         * @param operation      - operation being rendered
         * @param context        - generation context
         */
        void renderTestSet(RubyCodeWriter writer, BuiltInBinding builtInBinding,
                           Node value, OperationShape operation, GenerationContext context);
    }

    /**
     * Builder for {@link BuiltInBinding}.
     */
    public static class Builder implements SmithyBuilder<BuiltInBinding> {

        private final Set<ClientConfig> clientConfig = new HashSet<>();
        private Parameter builtIn;
        private RenderBuild renderBuild;
        private RenderTestSet renderTestSet;
        private WriteAdditionalFiles writeAdditionalFiles =
                (context) -> Collections.emptyList();

        public Builder builtIn(Parameter builtIn) {
            if (!builtIn.isBuiltIn()) {
                throw new SmithyBuildException("Parameter provided to BuiltInBinding must be a BuiltIn");
            }
            this.builtIn = builtIn;
            return this;
        }

        /**
         * Binds this built-in to a single config value.
         *
         * @param config client config
         * @return builder
         */
        public Builder fromConfig(ClientConfig config) {
            this.clientConfig.add(config);
            this.renderBuild = (writer, builtInBinding, operation, context) -> {
                writer.write("params.$1L = config[:$2L] unless config[:$2L].nil?",
                        RubyFormatter.toSnakeCase(builtInBinding.builtIn.getName().toString()),
                        config.getName()
                );
            };
            this.renderTestSet = (writer, builtInBinding, value, operation, context) -> {
                String v;
                if (value.isStringNode()) {
                    v = StringUtils.escapeJavaString(value.expectStringNode().getValue(), "");
                } else {
                    v = value.expectBooleanNode().getValue() ? "true" : "false";
                }
                writer.write("config[:$L] = $L",
                        config.getName(),
                        v);
            };
            return this;
        }

        /**
         * Source this endpoint parameter from a static/constant value. This is useful for supporting
         * legacy BuiltIns without adding configuration to the new SDK.
         *
         * @param value value to set this endpoint parameter to in builders
         * @return this builder
         */
        public Builder fromConstantValue(String value) {
            this.renderBuild = (writer, builtInBinding, operation, context) -> {
                writer.write("params.$1L = $2L",
                        RubyFormatter.toSnakeCase(builtInBinding.builtIn.getName().toString()),
                        value
                );
            };
            this.renderTestSet = (writer, builtInBinding, expectValue, operation, context) -> {
                String v;
                if (expectValue.isStringNode()) {
                    v = StringUtils.escapeJavaString(expectValue.expectStringNode().getValue(), "");
                } else {
                    v = expectValue.expectBooleanNode().getValue() ? "true" : "false";
                }
                writer.write("allow_any_instance_of(Params).to receive(:$L).and_return($L)",
                        RubyFormatter.toSnakeCase(builtInBinding.builtIn.getName().toString()),
                        v
                );
            };
            return this;
        }

        public Builder writeAdditionalFiles(WriteAdditionalFiles w) {
            this.writeAdditionalFiles = Objects.requireNonNull(w);
            return this;
        }

        public Builder rubySource(String rubyFileName) {
            this.writeAdditionalFiles = RubySource.rubySource(rubyFileName, "endpoint/");
            return this;
        }

        public Builder addConfig(ClientConfig config) {
            this.clientConfig.add(Objects.requireNonNull(config));
            return this;
        }

        public Builder renderBuild(RenderBuild renderBuild) {
            this.renderBuild = renderBuild;
            return this;
        }

        public Builder renderTestSet(RenderTestSet renderTestSet) {
            this.renderTestSet = renderTestSet;
            return this;
        }

        @Override
        public BuiltInBinding build() {
            return new BuiltInBinding(this);
        }
    }

}
