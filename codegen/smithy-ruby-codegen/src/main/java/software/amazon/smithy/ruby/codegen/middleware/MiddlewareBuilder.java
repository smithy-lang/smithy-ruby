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
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.pattern.SmithyPattern;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.EndpointTrait;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
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

    public boolean remove(MiddlewareStackStep step, String klass) {
        return middlewares.get(step).removeIf((m) -> m.getKlass().equals(klass));
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
        Model model = context.model();
        ServiceShape service = context.service();

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
        ApplicationTransport transport = context.applicationTransport();
        RubySymbolProvider symbolProvider =
                new RubySymbolProvider(context.model(), context.settings(), "Client", false);

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
                    Shape inputShape = ctx.model().expectShape(inputShapeId);
                    Map<String, String> params = new HashMap<>();
                    params.put("validator",
                            "Validators::" + symbolProvider.toSymbol(inputShape).getName());
                    return params;
                })
                .addConfig(validateInput)
                .build();

        ClientConfig disableHostPrefix = (new ClientConfig.Builder())
                .name("disable_host_prefix")
                .type("Boolean")
                .defaultValue("false")
                .documentation(
                        "When `true`, does not perform host prefix injection using @endpoint's hostPrefix property.")
                .build();

        Middleware hostPrefix = (new Middleware.Builder())
                .klass("Hearth::Middleware::HostPrefix")
                .step(MiddlewareStackStep.INITIALIZE)
                .addConfig(disableHostPrefix)
                .operationPredicate((model, service, operation) -> operation.hasTrait(EndpointTrait.class))
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    SmithyPattern pattern = operation.getTrait(EndpointTrait.class).get().getHostPrefix();
                    StringBuffer prefix = new StringBuffer();
                    for (SmithyPattern.Segment segment : pattern.getSegments()) {
                        if (segment.isLabel()) {
                            // Here, we rebuild the smithy pattern with reserved word support.
                            // Otherwise we could use pattern.toString()
                            String label = symbolProvider.toMemberName(segment.getContent());
                            prefix.append("{" + label + "}");
                        } else {
                            prefix.append(segment);
                        }
                    }
                    params.put("host_prefix", "\"" + prefix + "\"");
                    return params;
                })
                .build();

        ClientConfig stubResponses = (new ClientConfig.Builder())
                .name("stub_responses")
                .type("Boolean")
                .defaultValue("false")
                .documentation(
                        "Enable response stubbing. See documentation for {#stub_responses}")
                .build();

        ClientConfig maxAttempts = (new ClientConfig.Builder())
                .name("max_attempts")
                .type("Integer")
                .defaultValue("3")
                .documentation(
                        "An integer representing the maximum number of attempts that will be made for a "
                                + "single request, including the initial attempt."
                )
                .build();

        ClientConfig retryMode = (new ClientConfig.Builder())
                .name("retry_mode")
                .type("String")
                .defaultValue("'standard'")
                .documentation(
                        "Specifies which retry algorithm to use. Values are: \n"
                                +
                                " * `standard` - A standardized set of retry rules across the AWS SDKs. "
                                +
                                "This includes support"
                                +
                                " for retry quotas, which limit the number of unsuccessful retries a client can make.\n"
                                + " * `adaptive` - An experimental retry mode that includes all the"
                                + " functionality of `standard` mode along with automatic client side"
                                + " throttling.  This is a provisional mode that may change behavior"
                                + " in the future."
                )
                .build();

        ClientConfig adaptiveRetryWaitToFill = (new ClientConfig.Builder())
                .name("adaptive_retry_wait_to_fill")
                .type("Boolean")
                .defaultValue("true")
                .documentation(
                        "Used only in `adaptive` retry mode. When true, the request will sleep until there is"
                                + " sufficient client side capacity to retry the request. When false, the request will"
                                + " raise a `CapacityNotAvailableError` and will not retry instead of sleeping."
                )
                .build();

        Middleware retry = (new Middleware.Builder())
                .klass("Hearth::Middleware::Retry")
                .step(MiddlewareStackStep.RETRY)
                .addConfig(maxAttempts)
                .addConfig(retryMode)
                .addConfig(adaptiveRetryWaitToFill)
                .addParam("error_inspector_class", "Hearth::Retry::ErrorInspector")
                .addParam("retry_quota", "@retry_quota")
                .addParam("client_rate_limiter", "@client_rate_limiter")
                .build();

        Middleware send = (new Middleware.Builder())
                .klass("Hearth::Middleware::Send")
                .step(MiddlewareStackStep.SEND)
                .addParam("client",
                        transport.getTransportClient().render(context))
                .addParam("stubs", "@stubs")
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    Shape outputShape = ctx.model().expectShape(operation.getOutputShape());
                    params.put("stub_class", "Stubs::" + symbolProvider.toSymbol(operation).getName());
                    params.put("params_class", "Params::" + symbolProvider.toSymbol(outputShape).getName());
                    return params;
                })
                .addConfig(stubResponses)
                .build();

        register(validate);
        register(hostPrefix);
        register(retry);
        register(send);

        register(transport.defaultMiddleware(context));
    }
}
