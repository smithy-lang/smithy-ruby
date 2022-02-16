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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.ClientConfig;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class MiddlewareBuilder {
    private final Map<MiddlewareStackStep, List<Middleware>> middlewares;

    public MiddlewareBuilder() {
        this.middlewares = new HashMap<>();
        Arrays.stream(MiddlewareStackStep.values())
                .forEach((step) -> this.middlewares
                        .put(step, new ArrayList<>()));
    }

    public void register(Middleware middleware) {
        middlewares.get(middleware.getStep()).add(middleware);
    }

    public void register(List<Middleware> middleware) {
        middleware.forEach((m) -> register(m));
    }

    public Set<ClientConfig> getClientConfig(GenerationContext context) {
        Model model = context.getModel();
        ServiceShape service = context.getService();
        Set<ClientConfig> config = new HashSet<>();

        for (MiddlewareStackStep step : MiddlewareStackStep.values()) {
            Set<ClientConfig> stepConfig = middlewares.get(step)
                    .stream().filter((m) -> m.includeFor(model, service))
                    .map((m) -> m.getClientConfig())
                    .flatMap(Collection::stream)
                    .collect(Collectors.toSet());
            config.addAll(stepConfig);
        }
        return config;
    }

    // Write out all additional files for every middleware
    // return the list of all files
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return middlewares.values().stream()
                .flatMap(Collection::stream)
                .map((m) -> m.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .collect(Collectors.toList());
    }

    public void render(RubyCodeWriter writer, GenerationContext context,
                       OperationShape operation) {
        Model model = context.getModel();
        ServiceShape service = context.getService();

        for (MiddlewareStackStep step : MiddlewareStackStep.values()) {
            List<Middleware> orderedStepMiddleware = middlewares.get(step)
                    .stream()
                    .filter((m) -> m.includeFor(model, service, operation))
                    .sorted(Comparator.comparing(Middleware::getOrder))
                    .collect(Collectors.toList());

            for (Middleware middleware : orderedStepMiddleware) {
                middleware.renderAdd(writer, context, operation);
            }
        }
    }

    public void addDefaultMiddleware(GenerationContext context) {
        ApplicationTransport transport = context.getApplicationTransport();
        SymbolProvider symbolProvider =
                new RubySymbolProvider(context.getModel(), context.getRubySettings(), "Client", false);

        ClientConfig validateInput = (new ClientConfig.Builder())
                .name("validate_input")
                .type("Boolean")
                .defaultValue("true")
                .documentation(
                        "When `true`, request parameters are validated using the modeled shapes.")
                .build();

        Middleware validate = (new Middleware.Builder())
                .klass("Hearth::Middleware::Validate")
                .step(MiddlewareStackStep.INITIALIZE)
                .operationParams((ctx, operation) -> {
                    ShapeId inputShapeId = operation.getInputShape();
                    Shape inputShape = ctx.getModel().expectShape(inputShapeId);
                    Map<String, String> params = new HashMap<>();
                    params.put("validator",
                            "Validators::" + symbolProvider.toSymbol(inputShape).getName());
                    return params;
                })
                .addConfig(validateInput)
                .build();

        Middleware build = (new Middleware.Builder())
                .klass("Hearth::Middleware::Build")
                .step(MiddlewareStackStep.SERIALIZE)
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("builder",
                            "Builders::" + symbolProvider.toSymbol(operation).getName());
                    return params;
                })
                .build();

        ClientConfig stubResponses = (new ClientConfig.Builder())
                .name("stub_responses")
                .type("Bool")
                .defaultValue("false")
                .documentation(
                        "Enable response stubbing. See documentation for {#stub_responses}")
                .build();

        ClientConfig stubs = (new ClientConfig.Builder())
                .name("stubs")
                .type("Hearth::Stubbing::Stubs")
                .initializationCustomization(
                        "@stubs = Hearth::Stubbing::Stubs.new")
                .build();

        Middleware send = (new Middleware.Builder())
                .klass("Hearth::Middleware::Send")
                .step(MiddlewareStackStep.SEND)
                .addParam("client",
                        transport.getTransportClient().render(context))
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("stub_class", "Stubs::" + symbolProvider.toSymbol(operation).getName());
                    return params;
                })
                .addConfig(stubResponses)
                .addConfig(stubs)
                .build();

        register(validate);
        register(build);
        register(send);

        register(transport.defaultMiddleware(context));
    }
}
