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
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.factories.AuthMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.BuildMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.EndpointMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.EventStreamHandlersMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.EventStreamSignMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.HostPrefixMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.InitializeMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.ParseMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.RetryMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.SendMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.SignMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.ValidateMiddlewareFactory;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
/**
 * Collection of middleware to apply to a client.
 * Middleware is separated into stack steps which each have an
 * ordered list of Middleware to apply for that step.
 */
public class MiddlewareBuilder {
    private final Map<MiddlewareStackStep, List<Middleware>> middlewares;

    public MiddlewareBuilder() {
        this.middlewares = new HashMap<>();
        Arrays.stream(MiddlewareStackStep.values())
                .forEach((step) -> this.middlewares
                        .put(step, new ArrayList<>()));
    }

    public void remove(MiddlewareStackStep step, String klass) {
        middlewares.get(step).removeIf((m) -> m.getKlass().equals(klass));
    }

    public void register(Middleware middleware) {
        middlewares.get(middleware.getStep()).add(middleware);
    }

    public void register(List<Middleware> middleware) {
        middleware.forEach((m) -> register(m));
    }

    public Set<ClientConfig> getClientConfig(GenerationContext context) {
        Model model = context.model();
        ServiceShape service = context.service();
        Set<ClientConfig> config = new HashSet<>();

        for (MiddlewareStackStep step : MiddlewareStackStep.values()) {
            Set<ClientConfig> stepConfig = middlewares.get(step)
                    .stream().filter((m) -> m.includeFor(model, service))
                    .map((m) -> m.getClientConfig())
                    .flatMap(Collection::stream)
                    .collect(Collectors.toSet());
            config.addAll(stepConfig);
        }

        config.addAll(getDefaultClientConfig());

        return config;
    }

    // Write out all additional files for every middleware
    // return the list of all files
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return middlewares.values().stream()
                .flatMap(Collection::stream)
                .map((m) -> m.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .distinct()
                .collect(Collectors.toList());
    }

    public void render(RubyCodeWriter writer, GenerationContext context,
                       OperationShape operation) {
        Model model = context.model();
        ServiceShape service = context.service();

        for (MiddlewareStackStep step : MiddlewareStackStep.values()) {
            List<Middleware> orderedStepMiddleware = resolveAndFilter(step, model, service, operation);

            for (Middleware middleware : orderedStepMiddleware) {
                middleware.renderAdd(writer, context, operation);
            }
        }
    }

    private List<Middleware> resolveAndFilter(MiddlewareStackStep step, Model model, ServiceShape service,
                                              OperationShape operation) {
        Set<Middleware> resolved = new HashSet<>();
        Set<Middleware> visiting = new HashSet<>();
        Map<Middleware, Integer> order = new HashMap<>();
        Map<String, Middleware> klassToMiddlewareMap = new HashMap<>();


        List<Middleware> filteredMiddleware = middlewares.get(step)
                .stream().filter((m) -> m.includeFor(model, service, operation))
                .collect(Collectors.toList());

        filteredMiddleware.forEach((m) -> klassToMiddlewareMap.put(m.getKlass(), m));

        for (Middleware middleware : filteredMiddleware) {
            resolve(middleware, resolved, visiting, order, klassToMiddlewareMap);
        }

        return filteredMiddleware.stream()
                .sorted(Comparator.comparingInt(order::get))
                .collect(Collectors.toList());
    }

    private void resolve(Middleware middleware, Set<Middleware> resolved, Set<Middleware> visiting,
                         Map<Middleware, Integer> order, Map<String, Middleware> klassToMiddlewareMap) {

        if (visiting.contains(middleware)) {
            throw new IllegalArgumentException("Circular dependency detected when resolving order for middleware: "
                    + middleware.getKlass());
        }
        // skip if its already been resolved
        if (!resolved.contains(middleware)) {
            visiting.add(middleware);
            if (middleware.getRelative().isPresent()) {
                Middleware.Relative relative = middleware.getRelative().get();
                Middleware relativeTo = klassToMiddlewareMap.get(relative.getTo());
                if (relativeTo != null) {
                    // recursively resolve the relative middleware
                    resolve(relativeTo, resolved, visiting, order, klassToMiddlewareMap);
                    // the order of relativeTo should now be set
                    if (relative.getType().equals(Middleware.Relative.Type.BEFORE)) {
                        order.put(middleware, order.get(relativeTo) - 1);
                    } else {
                        order.put(middleware, order.get(relativeTo) + 1);
                    }
                } else {
                    resolveMissingRelativeTo(relative, middleware, order);
                }
            } else {
                // Base case - middleware is not relative to anything else, use its default order.
                order.put(middleware, (int) middleware.getOrder());
            }
            visiting.remove(middleware);
            resolved.add(middleware);
        }
    }

    private void resolveMissingRelativeTo(Middleware.Relative relative, Middleware middleware,
                                          Map<Middleware, Integer> order) {
        if (relative.getRelativeRequired()) {
            throw new IllegalArgumentException(middleware.getKlass()
                    + " relative references a required middleware class ("
                    + relative.getTo() + ") that is not available in stack.");
        } else {
            order.put(middleware, (int) middleware.getOrder());
        }
    }

    public void addDefaultMiddleware(GenerationContext context) {
        ApplicationTransport transport = context.applicationTransport();

        register(InitializeMiddlewareFactory.build(context));
        register(ValidateMiddlewareFactory.build(context));
        register(BuildMiddlewareFactory.build(context));
        register(RetryMiddlewareFactory.build(context));
        register(AuthMiddlewareFactory.build(context));
        register(EndpointMiddlewareFactory.build(context));
        register(HostPrefixMiddlewareFactory.build(context));
        register(SignMiddlewareFactory.build(context));
        register(ParseMiddlewareFactory.build(context));
        register(SendMiddlewareFactory.build(context, transport, false));

        register(transport.defaultMiddleware(context));

        context.eventStreamTransport().ifPresent(eventStreamTransport -> {
            register(EventStreamHandlersMiddlewareFactory.build(context));
            register(EventStreamSignMiddlewareFactory.build(context));
            register(SendMiddlewareFactory.build(context, eventStreamTransport, true));
        });
    }

    private Collection<? extends ClientConfig> getDefaultClientConfig() {
        ClientConfig logger = ClientConfig.builder()
                .name("logger")
                .defaultValue("Logger.new(IO::NULL)")
                .documentation("The Logger instance to use for logging.")
                .documentationRbsAndValidationType("Logger")
                .documentationDefaultValue("Logger.new(IO::NULL)")
                .build();

        String pluginDocumentation = """
                A list of Plugins to apply to the client. Plugins are callables that
                take {Config} as an argument. Plugins may modify the provided config.
                """;
        ClientConfig plugins = ClientConfig.builder()
                .name("plugins")
                .defaultValue(Hearth.PLUGIN_LIST + ".new")
                .documentation(pluginDocumentation)
                .rbsType(Hearth.PLUGIN_LIST + "[Config]")
                .validateType(Hearth.PLUGIN_LIST.toString())
                .documentationType(Hearth.PLUGIN_LIST.toString())
                .documentationDefaultValue(Hearth.PLUGIN_LIST + ".new")
                .build();

        String interceptorDocumentation = """
                A list of Interceptors to apply to the client.  Interceptors are a generic
                extension point that allows injecting logic at specific stages of execution
                within the SDK. Logic injection is done with hooks that the interceptor
                implements.  Hooks are either read-only or read/write. Read-only hooks allow
                an interceptor to read the input, transport request, transport response or
                output messages. Read/write hooks allow an interceptor to modify one of these
                messages.
                """;
        ClientConfig interceptors = ClientConfig.builder()
                .name("interceptors")
                .defaultValue(Hearth.INTERCEPTOR_LIST + ".new")
                .documentation(interceptorDocumentation)
                .rbsType(Hearth.INTERCEPTOR_LIST + "[Config]")
                .validateType(Hearth.INTERCEPTOR_LIST.toString())
                .documentationType(Hearth.INTERCEPTOR_LIST.toString())
                .documentationDefaultValue(Hearth.INTERCEPTOR_LIST + ".new")
                .build();

        return Arrays.asList(logger, plugins, interceptors);
    }
}
