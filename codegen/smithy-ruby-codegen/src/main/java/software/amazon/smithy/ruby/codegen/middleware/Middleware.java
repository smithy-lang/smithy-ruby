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

package software.amazon.smithy.ruby.codegen.middleware;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.OperationPredicate;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.ServicePredicate;
import software.amazon.smithy.ruby.codegen.WriteAdditionalFiles;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.util.RubySource;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Class representing Middleware to be added during codegeneration
 * Middleware may apply selectively to services and operations
 * and knows its position in the middleware stack.  It also
 * must provide the ClientConfig required for its params.
 */
@SmithyUnstableApi
public final class Middleware {

    private final String klass;
    private final MiddlewareStackStep step;
    private final byte order;

    private final Optional<Relative> relative;
    private final Set<ClientConfig> clientConfig;
    private final OperationParams operationParams;
    private final Map<String, String> additionalParams;
    private final ServicePredicate servicePredicate;
    private final OperationPredicate operationPredicate;
    private final RenderAdd renderAdd;
    private final WriteAdditionalFiles writeAdditionalFiles;

    // params could include any Ruby code
    private Middleware(Builder builder) {
        this.klass = builder.klass;
        this.step = builder.step;
        this.order = builder.order;
        this.relative = builder.relative;
        this.clientConfig = builder.clientConfig;
        this.operationParams = builder.operationParams;
        this.additionalParams = builder.additionalParams;
        this.servicePredicate = builder.servicePredicate;
        this.operationPredicate = builder.operationPredicate;
        this.renderAdd = builder.renderAdd;
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
    }

    public static Builder builder() {
        return new Builder();
    }

    /**
     * @return the Ruby class to use for the middleware.
     */
    public String getKlass() {
        return klass;
    }

    /**
     * @return the step for this middleware
     */
    public MiddlewareStackStep getStep() {
        return step;
    }

    /**
     * @return order within stack step
     */
    public byte getOrder() {
        return order;
    }

    /**
     * @return relative order within stack step
     */
    public Optional<Relative> getRelative() {
        return relative;
    }

    /**
     * @return clientConfig to be added to the client to support this middleware.
     */
    public Set<ClientConfig> getClientConfig() {
        return clientConfig;
    }

    /**
     * @return additional parameters that should be passed to the middleware's initialize.
     */
    public Map<String, String> getAdditionalParams() {
        return additionalParams;
    }

    /**
     * @param model   model
     * @param service service to test for
     * @return true if this middleware should be included for the service
     */
    public boolean includeFor(Model model, ServiceShape service) {
        return servicePredicate.test(model, service);
    }

    /**
     * @param model     model
     * @param service   service to test for
     * @param operation operation in the service to test for
     * @return true if this middleware should be included for this operation/service
     */
    public boolean includeFor(Model model, ServiceShape service,
                              OperationShape operation) {
        return operationPredicate.test(model, service, operation);
    }

    /**
     * Generate code to add this middleware to an operation method.
     *
     * @param writer    writer
     * @param context   generation context
     * @param operation operation to add to
     */
    public void renderAdd(RubyCodeWriter writer, GenerationContext context,
                          OperationShape operation) {
        renderAdd.renderAdd(writer, this, context, operation);
    }

    /**
     * Write additional files required by this middleware.
     *
     * @param context generation context
     * @return List of additional files written out
     */
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return writeAdditionalFiles.writeAdditionalFiles(context);
    }

    @FunctionalInterface
    /**
     * Called to Render the addition of this middleware to the stack.
     */
    public interface RenderAdd {
        /**
         * Called to Render the addition of this middleware to the stack.
         *
         * @param writer     - codewriter to render with
         * @param middleware - middleware to render
         * @param context    - additional context
         * @param operation  - operation being rendered
         */
        void renderAdd(RubyCodeWriter writer, Middleware middleware,
                       GenerationContext context, OperationShape operation);
    }

    @FunctionalInterface
    /**
     * Called to get additional, operation specific parameters.
     */
    public interface OperationParams {
        /**
         * Called to get additional, operation specific parameters.
         *
         * @param context   GenerationContext - allows access to file manifest and symbol providers
         * @param operation The operation
         * @return Map of params/values for the middleware
         */
        Map<String, String> params(GenerationContext context, OperationShape operation);
    }

    /**
     * Builder for {@link Middleware}.
     */
    public static class Builder implements SmithyBuilder<Middleware> {

        private static final RenderAdd DEFAULT_RENDER_ADD =
                (writer, middleware, context, operation) -> {
                    Set<ClientConfig> config = middleware.getClientConfig();

                    Map<String, String> params =
                            new HashMap<>(middleware.getAdditionalParams());
                    params.putAll(middleware.operationParams
                            .params(context, operation));

                    config.stream()
                            .forEach((c) -> {
                                params.put(c.getName(), c.renderGetConfigValue());
                            });

                    if (params.isEmpty()) {
                        writer.write("stack.use($L)", middleware.getKlass());
                    } else {
                        writer.write("stack.use($L,", middleware.getKlass());
                        writer.indent();
                        String methodArgsBlock = params
                                .entrySet()
                                .stream()
                                .sorted(Map.Entry.comparingByKey())
                                .map(entry -> entry.getKey() + ": "
                                        + entry.getValue())
                                .collect(Collectors.joining(",\n"));
                        writer.writeInline(methodArgsBlock);
                        writer.dedent();
                        writer.write("\n)");
                    }
                };
        private byte order = 0;
        private Optional<Relative> relative = Optional.empty();
        private String klass;
        private MiddlewareStackStep step;
        private Set<ClientConfig> clientConfig = new HashSet<>();
        private OperationParams operationParams =
                (context, operation) -> new HashMap<>();
        private Map<String, String> additionalParams = new HashMap<>();
        private ServicePredicate servicePredicate = (model, service) -> true;
        private OperationPredicate operationPredicate =
                (model, service, operation) -> true;
        private RenderAdd renderAdd = DEFAULT_RENDER_ADD;
        private WriteAdditionalFiles writeAdditionalFiles =
                (context) -> Collections.emptyList();

        protected Builder() {
        }

        /**
         * @param klass the Ruby class of the Middleware
         * @return Returns the builder
         */
        public Builder klass(String klass) {
            this.klass = klass;
            return this;
        }

        /**
         * @param klass the Ruby class of the Middleware
         * @return Returns the builder
         */
        public Builder klass(Symbol klass) {
            this.klass = klass.toString();
            return this;
        }

        /**
         * @param order the order within the step. Smaller values are used earlier in the stack.
         * @return Returns the builder
         */
        public Builder order(byte order) {
            if (relative.isPresent()) {
                throw new IllegalArgumentException("Cannot combine relative ordering with explicit order value.");
            }
            this.order = order;
            return this;
        }

        public Builder relative(Relative relative) {
            if (order != 0) {
                throw new IllegalArgumentException("Cannot combine relative ordering with explicit order value.");
            }
            this.relative = Optional.of(relative);
            return this;
        }

        /**
         * @param step The step to apply the middleware to.
         * @return Returns the builder
         */
        public Builder step(MiddlewareStackStep step) {
            this.step = step;
            return this;
        }

        /**
         * @param config ClientConfig to be added to the Client and passed to this middleware.
         * @return Returns the builder
         */
        public Builder addConfig(ClientConfig config) {
            this.clientConfig.add(Objects.requireNonNull(config));
            return this;
        }

        /**
         * @param config All of the client config options.
         * @return Returns the builder
         */
        public Builder config(Collection<ClientConfig> config) {
            this.clientConfig = new HashSet<>(config);
            return this;
        }

        /**
         * Used to pass additional parameters (not defined by ClientConfig) to the middleware.
         *
         * @param name  the name of the parameter.
         * @param value the value (can be ruby code that uses values defined in the client or operation).
         * @return Returns the builder
         */
        public Builder addParam(String name, String value) {
            this.additionalParams.put(name, value);
            return this;
        }

        /**
         * Used to pass additional parameters (not defined by ClientConfig) to the middleware.
         *
         * @param newParams Map of params/values
         * @return Returns the builder
         */
        public Builder params(Map<String, String> newParams) {
            this.additionalParams = new HashMap<>(newParams);
            return this;
        }

        /**
         * Configures a predicate that makes a plugin only apply to a set of
         * operations that match one or more of the set of given shape names,
         * and ensures that the plugin is not applied globally to services.
         *
         * <p>By default, a plugin applies globally to a service, which thereby
         * applies to every operation when the middleware stack is copied.
         *
         * @param operationNames - operations this should apply to
         * @return Returns the builder.
         */
        public Builder appliesOnlyToOperations(String... operationNames) {
            return appliesOnlyToOperations(
                    new HashSet<>(Arrays.asList(operationNames)));
        }

        /**
         * Configures a predicate that makes a plugin only apply to a set of
         * operations that match one or more of the set of given shape names,
         * and ensures that the plugin is not applied globally to services.
         *
         * <p>By default, a middleware applies globally to a service, which thereby
         * applies to every operation when the middleware stack is copied.
         *
         * @param operationNames apply this middleware only to the given operations.
         * @return Returns the builder
         */
        public Builder appliesOnlyToOperations(Set<String> operationNames) {
            return operationPredicate(
                    (model, service, operation) -> operationNames
                            .contains(operation.getId().getName()));
        }

        /**
         * Configures a predicate that makes a plugin only apply to a set of
         * operations that match one or more of the set of given shape names,
         * and ensures that the plugin is not applied globally to services.
         *
         * <p>By default, a middleware applies globally to a service, which thereby
         * applies to every operation when the middleware stack is copied.
         *
         * @param p predicate to be used to test operations.
         * @return Return the Builder
         */
        public Builder operationPredicate(OperationPredicate p) {
            this.operationPredicate = Objects.requireNonNull(p);
            return this;
        }

        /**
         * Configure a predicate that makes this plugin only apply to
         * a set of services.
         *
         * @param serviceNames services to apply this middleware to.
         * @return Return the Builder
         */
        public Builder appliesOnlyToServices(Set<String> serviceNames) {
            return servicePredicate((model, service) -> serviceNames
                    .contains(service.getId().getName()));
        }

        /**
         * Configure a predicate that makes this plugin only apply to
         * a set of services.
         *
         * @param p predicate to test a service for inclusion.
         * @return Returns the Builder
         */
        public Builder servicePredicate(ServicePredicate p) {
            this.servicePredicate = Objects.requireNonNull(p);
            return this;
        }

        /**
         * Used to add additional parameters to the middleware
         * that require information about the operation (eg, the input/output shapes).
         *
         * @param p Called with the operation to return a map of params/values.
         * @return Returns the Builder
         */
        public Builder operationParams(OperationParams p) {
            this.operationParams = p;
            return this;
        }

        /**
         * Used to completely override and fully customize the rendering of
         * adding this middleware to the stack.
         *
         * @param r Called to render code to add this middleware to the stack in the client operation.
         * @return Returns the Builder.
         */
        public Builder renderAdd(RenderAdd r) {
            this.renderAdd = Objects.requireNonNull(r);
            return this;
        }

        /**
         * Used to write additional files required by this middleware.
         *
         * @param w called to write additional files.
         * @return Returns the Builder.
         */
        public Builder writeAdditionalFiles(WriteAdditionalFiles w) {
            this.writeAdditionalFiles = Objects.requireNonNull(w);
            return this;
        }

        /**
         * Used to copy a Ruby source file that defines a middleware into the generated SDK.
         * The copied file must be a Middleware class (implements a call method that takes input and context)
         * under the Middleware namespace. This method will apply the generated service's namespace to the source file.
         *
         * @param rubyFileName the file name (with path) of the ruby file to copy.
         * @return Return the Builder
         */
        public Builder rubySource(String rubyFileName) {
            this.writeAdditionalFiles = RubySource.rubySource(rubyFileName, "middleware/");
            return this;
        }

        @Override
        public Middleware build() {
            return new Middleware(this);
        }
    }

    /**
     * Class representing a relative middleware.
     * A Middleware may specify a relative middleware
     * to happen either BEFORE or AFTER the middleware.
     * Middleware may only specify ONE relative
     * ordering constraint.
     */
    public static class Relative {
        private final Type type;
        private final String to;
        private final boolean relativeRequired;

        public Relative(Builder builder) {
            this.type = builder.type;
            this.to = builder.to;
            this.relativeRequired = builder.relativeRequired;
        }

        public static Builder builder() {
            return new Builder();
        }

        /**
         * @return the Type, can be either BEFORE or AFTER.
         */
        public Type getType() {
            return type;
        }

        /**
         * @return the To, the referenced relative middleware.
         */
        public String getTo() {
            return to;
        }

        /**
         * @return true if the relative middleware is required.
         * Set true as default.
         */
        public boolean getRelativeRequired() {
            return relativeRequired;
        }

        /**
         * Builder for Relative.
         */
        public static class Builder implements SmithyBuilder<Relative> {
            private Type type;
            private String to;
            private boolean relativeRequired = true;

            /**
             * Middleware to be set BEFORE the relative
             * middleware in the middleware stack order.
             *
             * @param to the Ruby class of the middleware
             * @return this builder
             */
            public Builder before(String to) {
                this.to = to;
                this.type = Type.BEFORE;
                return this;
            }

            /**
             * Middleware to be set BEFORE the relative
             * middleware in the middleware stack order.
             *
             * @param to the Ruby class of the middleware
             * @return this builder
             */
            public Builder before(Symbol to) {
                this.to = to.toString();
                this.type = Type.BEFORE;
                return this;
            }

            /**
             * Middleware to be set AFTER the relative
             * middleware in the middleware stack order.
             *
             * @param to the Ruby class of the middleware
             * @return this builder
             */
            public Builder after(String to) {
                this.to = to;
                this.type = Type.AFTER;
                return this;
            }

            /**
             * Middleware to be set AFTER the relative
             * middleware in the middleware stack order.
             *
             * @param to the Ruby class of the middleware
             * @return this builder
             */
            public Builder after(Symbol to) {
                this.to = to.toString();
                this.type = Type.AFTER;
                return this;
            }

            /**
             * Sets the relative middleware to be optional.
             * Should the relative middleware not be found in the
             * stack, the ordering will proceed as normal.
             *
             * @return this builder
             */
            public Builder optional() {
                this.relativeRequired = false;
                return this;
            }

            public Relative build() {
                return new Relative(this);
            }
        }

        /**
         * Converts symbol into a string.
         */
        public String toString() {
            return type + " " + to;
        }

        /**
         * Represents the corresponding order between the
         * middleware and its relative middleware.
         */
        public enum Type {
            BEFORE,
            AFTER
        }
    }
}
