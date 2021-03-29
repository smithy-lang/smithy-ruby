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
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.ClientConfig;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.utils.CodeWriter;

public class MiddlewareBuilder {
    private Map<MiddlewareStackStep, List<Middleware>> middlewares;

    public MiddlewareBuilder() {
        this.middlewares = new HashMap<>();
        Arrays.stream(MiddlewareStackStep.values())
                .forEach( (step) -> this.middlewares.put(step, new ArrayList<>()));
    }

    public void register(Middleware middleware) {
        middlewares.get(middleware.getStep()).add(middleware);
    }

    public void register(List<Middleware> middleware) {
        middleware.forEach( (m) -> register(m) );
    }

    public Set<ClientConfig> getClientConfig(GenerationContext context) {
        Model model = context.getModel();
        ServiceShape service = context.getService();
        Set<ClientConfig> config = new HashSet<>();

        for (MiddlewareStackStep step : MiddlewareStackStep.values()) {
            Set<ClientConfig> stepConfig = middlewares.get(step)
                    .stream().filter( (m) -> m.includeFor(model, service))
                    .map((m) -> m.getClientConfig())
                    .flatMap(Collection::stream)
                    .collect(Collectors.toSet());
            config.addAll(stepConfig);
        }
        return config;
    }

    public void render(RubyCodeWriter writer, GenerationContext context, OperationShape operation) {
        Model model = context.getModel();
        ServiceShape service = context.getService();

        for (MiddlewareStackStep step : MiddlewareStackStep.values()) {
            List<Middleware> orderedStepMiddleware = resolveAndFilter(step, model, service, operation);

            for (Middleware middleware : orderedStepMiddleware) {
                middleware.renderAdd(writer, context, operation);
            }
        }
    }

    private  List<Middleware> resolveAndFilter(MiddlewareStackStep step, Model model, ServiceShape service, OperationShape operation) {
        Set<Middleware> resolved = new HashSet<>();
        Map<Middleware, Integer> order = new HashMap<>();
        Map<String, Middleware> idMiddlewareMap = new HashMap<>();


        List<Middleware> filteredMiddleware = middlewares.get(step)
                .stream().filter( (m) -> m.includeFor(model, service, operation))
                .collect(Collectors.toList());

        filteredMiddleware.forEach( (m) -> idMiddlewareMap.put(m.getId(), m));

        try {
            for (Middleware middleware : filteredMiddleware) {
                resolve(middleware, resolved, order, idMiddlewareMap);
            }
        } catch (StackOverflowError e) {
            String msg = "Stackoverflow error when resolving middleware order.  This likely means you have a circular dependency.";
            System.out.println(msg);
            throw new IllegalArgumentException(msg);
        }
        return filteredMiddleware.stream()
                .sorted(Comparator.comparingInt(order::get))
                .collect(Collectors.toList());
    }

    private void resolve(Middleware middleware, Set<Middleware> resolved, Map<Middleware, Integer> order, Map<String, Middleware> idMiddlewareMap) {
        // skip if its already been resolved
        if (!resolved.contains(middleware)) {
            if (Objects.nonNull(middleware.getRelative())) {
                Middleware relativeTo = Objects.requireNonNull(idMiddlewareMap.get(middleware.getRelative().getTo()));
                resolve(relativeTo, resolved, order, idMiddlewareMap); //recursively resolve the relative middleware
                // the order of relativeTo should now be set
                if (middleware.getRelative().getType().equals(Middleware.Relative.Type.BEFORE)) {
                    order.put(middleware, order.get(relativeTo) - 1);
                } else {
                    order.put(middleware, order.get(relativeTo) + 1);
                }
            } else {
                // Base case - middleware is not relative to anything else, give it a default 0 order.
                order.put(middleware, 0);
            }
            resolved.add(middleware);
        }
    }

    public void addDefaultMiddleware(GenerationContext context) {
        ApplicationTransport transport = context.getApplicationTransport();

        ClientConfig validateParams = (new ClientConfig.Builder())
                .name("validate_params")
                .type("Bool")
                .defaultValue("true")
                .documentation("Enable type checking and validation of input parameters")
                .build();

        Middleware validate = (new Middleware.Builder())
                .rubyClass("Seahorse::Middleware::Validate")
                .step(MiddlewareStackStep.INITIALIZE)
                .operationParams( (ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("builder", "Validators::" + operation.getId().getName() + "Input");
                    return params;
                })
                .addParam("params", "params")
                .addConfig(validateParams)
                .build();

        Middleware build = (new Middleware.Builder())
                .rubyClass("Seahorse::Middleware::Build")
                .step(MiddlewareStackStep.SERIALIZE)
                .addParam("params", "params")
                .operationParams( (ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("builder", "Builders::" + operation.getId().getName());
                    return params;
                })
                .build();

        ClientConfig stubResponses = (new ClientConfig.Builder())
                .name("stub_responses")
                .type("Bool")
                .defaultValue("false")
                .documentation("Enable response stubbing. See documentation for {#stub_responses}")
                .build();

        ClientConfig stubs = (new ClientConfig.Builder())
                .name("stubs")
                .type("Seahorse::Stubbing::Stubs")
                .initializationCustomization("@stubs = Seahorse::Stubbing::Stubs.new")
                .build();

        Middleware send = (new Middleware.Builder())
                .rubyClass("Seahorse::Middleware::Send")
                .step(MiddlewareStackStep.SEND)
                .addParam("client", transport.getTransportClient().render(context))
                .operationParams( (ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("stub_class", "Builders::" + operation.getId().getName()); // TODO: Generate stubs....
                    return params;
                })
                .addConfig(stubResponses)
                .addConfig(stubs)
                .build();

        // register(validate); //TODO: Enable once support for validation done.
        register(build);
        register(send);

        // Add two demo relative middlewares
        Middleware a = (new Middleware.Builder())
                .rubyClass("Seahorse::Middleware::Middleware1")
                .step(MiddlewareStackStep.SERIALIZE)
                .relative(new Middleware.Relative(Middleware.Relative.Type.BEFORE, "Seahorse::Middleware::Middleware2"))
                .build();

        Middleware b = (new Middleware.Builder())
                .rubyClass("Seahorse::Middleware::Middleware2")
                .step(MiddlewareStackStep.SERIALIZE)
                .relative(new Middleware.Relative(Middleware.Relative.Type.AFTER, "Seahorse::Middleware::Build"))
                .build();

        register(a);
        register(b);

        register(transport.defaultMiddleware(context));
    }
}
