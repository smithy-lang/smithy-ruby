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

package software.amazon.smithy.ruby.codegen.middleware;

import java.util.*;
import java.util.stream.Collectors;

import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.*;
import software.amazon.smithy.utils.CodeWriter;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.StringUtils;

/**
 * Class representing Middleware to be added during codegeneration
 * Middleware may apply selectively to services and operations
 * and knows its position in the middleware stack.  It also
 * must provide the ClientConfig required for its params.
 */
public class Middleware {
    private final String id; // usually the rubyClass, but may be set uniquely if needed
    private final String rubyClass;
    private final MiddlewareStackStep step;
    private final Relative relative;
    private final Set<ClientConfig> clientConfig;
    private final OperationParams operationParams;
    private final Map<String, String> additionalParams;
    private final ServicePredicate servicePredicate;
    private final OperationPredicate operationPredicate;
    private final RenderAdd renderAdd;
    private final WriteAdditionalFiles writeAdditionalFiles;



    // params could include any Ruby code
    public Middleware(Builder builder) {
        this.rubyClass = builder.rubyClass;
        this.id = StringUtils.isNotBlank(builder.id) ? builder.id : rubyClass; // fallback to the RubyClass
        this.step = builder.step;
        this.relative = builder.relative;
        this.clientConfig = builder.clientConfig;
        this.operationParams = builder.operationParams;
        this.additionalParams = builder.additionalParams;
        this.servicePredicate = builder.servicePredicate;
        this.operationPredicate = builder.operationPredicate;
        this.renderAdd = builder.renderAdd;
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
    }

    public String getId() { return id; }

    public String getRubyClass() {
        return rubyClass;
    }

    public MiddlewareStackStep getStep() {
        return step;
    }

    public Relative getRelative() {
        return relative;
    }

    public Set<ClientConfig> getClientConfig() {
        return clientConfig;
    }

    public Map<String, String> getAdditionalParams() { return additionalParams; }

    public boolean includeFor(Model model, ServiceShape service) {
        return servicePredicate.test(model, service);
    }

    public boolean includeFor(Model model, ServiceShape service, OperationShape operation) {
        return operationPredicate.test(model, service, operation);
    }

    public void renderAdd(CodeWriter writer, GenerationContext context, OperationShape operation) {
        renderAdd.renderAdd(writer, this, context, operation);
    }

    @FunctionalInterface
    public interface RenderAdd {
        /**
         * Called to Render the addition of this middleware to the stack
         */
        void renderAdd(CodeWriter writer, Middleware middleware, GenerationContext context, OperationShape operation);
    }

    @FunctionalInterface
    public interface WriteAdditionalFiles {
        /**
         * Called to write out additional files needed by this Middleware
         *
         * @param context   GenerationContext - allows access to file manifest and symbol providers
         * @return List of the relative paths of files written, which will be required in client.rb.
         */
        List<String> writeAdditionalFiles(GenerationContext context);
    }

    @FunctionalInterface
    public interface OperationParams {
        /**
         * Called to get additional, operation specific parameters
         *
         * @param context   GenerationContext - allows access to file manifest and symbol providers
         * @param operation The operation
         * @return List of the relative paths of files written, which will be required in client.rb.
         */
        Map<String, String> params(GenerationContext context, OperationShape operation);
    }

    public static class Builder implements SmithyBuilder<Middleware> {

        private static final RenderAdd DEFAULT_RENDER_ADD = (writer, middleware, context, operation) -> {
            Set<ClientConfig> config = middleware.getClientConfig();

            Map<String, String> params = middleware.getAdditionalParams();
            params.putAll(middleware.operationParams.params(context, operation));

            config.stream()
                    .forEach((c) -> {
                        params.put(c.getName(), "options.fetch(:" + c.getName() + ", @" + c.getName() + ")");
                    });

            if (params.isEmpty()) {
                writer.write("stack.use($L)", middleware.getRubyClass());
            }
            else {
                writer.write("stack.use($L,", middleware.getRubyClass());
                writer.indent();
                String methodArgsBlock = params
                        .entrySet()
                        .stream()
                        .map(entry -> entry.getKey() + ": " + entry.getValue())
                        .collect(Collectors.joining(",\n"));
                writer.writeInline(methodArgsBlock);
                writer.dedent();
                writer.write("\n)");
            }
        };

        private String id;
        private String rubyClass;
        private MiddlewareStackStep step;
        private Relative relative;
        private Set<ClientConfig> clientConfig = new HashSet<>();
        private OperationParams operationParams = (context, operation) -> new HashMap<>();
        private Map<String, String> additionalParams = new HashMap<>();
        private ServicePredicate servicePredicate = (model, service) -> true;
        private OperationPredicate operationPredicate = (model, service, operation) -> true;
        private RenderAdd renderAdd = DEFAULT_RENDER_ADD;
        private WriteAdditionalFiles writeAdditionalFiles = (context) -> Collections.emptyList();

        public Builder id(String id) {
            this.id = id;
            return this;
        }

        public Builder rubyClass(String klass) {
            this.rubyClass = klass;
            return this;
        }

        public Builder step(MiddlewareStackStep step) {
            this.step = step;
            return this;
        }

        public Builder relative(Relative relative) {
            this.relative = relative;
            return this;
        }

        public Builder addConfig(ClientConfig config) {
            this.clientConfig.add(Objects.requireNonNull(config));
            return this;
        }

        public Builder config(Collection<ClientConfig> config) {
            this.clientConfig = new HashSet<>(config);
            return this;
        }

        public Builder addParam(String name, String value) {
            this.additionalParams.put(name, value);
            return this;
        }

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
         * @return Returns the builder.
         */
        public Builder appliesOnlyToOperations(String... operationNames) {
            return appliesOnlyToOperations(new HashSet(Arrays.asList(operationNames)));
        }

        public Builder appliesOnlyToOperations(Set<String> operationNames) {
            return operationPredicate((model, service, operation) -> operationNames.contains(operation.getId().getName()));
        }

        public Builder operationPredicate(OperationPredicate p) {
            this.operationPredicate = Objects.requireNonNull(p);
            return this;
        }

        public Builder appliesOnlyToServices(Set<String> serviceNames) {
            return servicePredicate( (model, service) -> serviceNames.contains(service.getId().getName()));
        }

        public Builder servicePredicate(ServicePredicate p) {
            this.servicePredicate = Objects.requireNonNull(p);
            return this;
        }

        public Builder operationParams(OperationParams p) {
            this.operationParams = p;
            return this;
        }

        public Builder renderAdd(RenderAdd r) {
            this.renderAdd = Objects.requireNonNull(r);
            return this;
        }

        public Builder writeAdditionalFiles(WriteAdditionalFiles w) {
            this.writeAdditionalFiles = Objects.requireNonNull(w);
            return this;
        }

        @Override
        public Middleware build() {
            return new Middleware(this);
        }
    }



    public static class Relative {
        private final Type type;
        private final String to;

        public Relative(Type type, String to) {
            this.type = type;
            this.to = to;
        }

        public Type getType() {
            return type;
        }

        public String getTo() {
            return to;
        }

        public String toString() {
            return type + " " + to;
        }

        public enum Type {
            BEFORE,
            AFTER
        }
    }
}
