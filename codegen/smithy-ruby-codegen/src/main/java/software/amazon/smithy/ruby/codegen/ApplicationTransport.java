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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.HttpChecksumRequiredTrait;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.model.traits.RequestCompressionTrait;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.RangeConstraint;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyUnstableApi;


/**
 * Represents an application Transport (aka Application Protocol) (e.g., "http", "mqtt", etc).
 * Describes the low level transport client, request and responses classes as well as the
 * default middleware.
 */
@SmithyUnstableApi
public final class ApplicationTransport {

    private final String name;
    private final ClientFragment request;
    private final ClientFragment response;
    private final ClientFragment transportClient;
    private final MiddlewareList defaultMiddleware;

    /**
     * Creates a resolved application transport.
     *
     * @param name              - name of the transport (eg HTTP)
     * @param request           - code to use to create the ruby Request
     * @param response          - code to use to create the Ruby Response
     * @param transportClient   - code to use to create the Transport's client
     * @param defaultMiddleware - default middleware to add to client operations
     */
    public ApplicationTransport(
            String name,
            ClientFragment request,
            ClientFragment response,
            ClientFragment transportClient,
            MiddlewareList defaultMiddleware

    ) {
        this.name = name;
        this.request = request;
        this.response = response;
        this.transportClient = transportClient;
        this.defaultMiddleware = defaultMiddleware;
    }

    /**
     * Creates a default HTTP application transport.
     *
     * @return Returns the created application Transport.
     */
    public static ApplicationTransport createDefaultHttpApplicationTransport() {

        ClientConfig endpoint = ClientConfig.builder()
                .name("endpoint")
                .type("String")
                .documentation("Endpoint of the service")
                .allowOperationOverride()
                .defaultDynamicValue("proc { |cfg| cfg[:stub_responses] ? 'http://localhost' : nil }")
                .build();

        ClientFragment request = ClientFragment.builder()
                .addConfig(endpoint)
                // TODO: Replace URI with Endpoint middleware - should be a blank request
                .render((self, ctx) -> "Hearth::HTTP::Request.new(uri: URI(" + endpoint.renderGetConfigValue() + "))")
                .build();

        ClientFragment response = ClientFragment.builder()
                .render((self, ctx) -> "Hearth::HTTP::Response.new(body: response_body)")
                .build();

        ClientConfig httpClient = ClientConfig.builder()
                .name("http_client")
                .type("Hearth::HTTP::Client")
                .documentation("The HTTP Client to use for request transport.")
                .documentationDefaultValue("Hearth::HTTP::Client.new")
                .allowOperationOverride()
                .defaultDynamicValue("proc { |cfg| Hearth::HTTP::Client.new(logger: cfg[:logger]) }")
                .build();

        ClientFragment client = ClientFragment.builder()
                .addConfig(httpClient)
                .render((self, ctx) -> httpClient.renderGetConfigValue())
                .build();

        MiddlewareList defaultMiddleware = (transport, context) -> {
            List<Middleware> middleware = new ArrayList<>();

            middleware.add(Middleware.builder()
                    .klass(Hearth.BUILD_MIDDLEWARE)
                    .step(MiddlewareStackStep.BUILD)
                    .operationParams((ctx, operation) -> {
                        Map<String, String> params = new HashMap<>();
                        params.put("builder",
                                "Builders::" + ctx.symbolProvider().toSymbol(operation).getName());
                        return params;
                    })
                    .build()
            );

            middleware.add(Middleware.builder()
                    .klass("Hearth::HTTP::Middleware::ContentLength")
                    .operationPredicate(
                            (model, service, operation) ->
                                    !Streaming.isNonFiniteStreaming(
                                            model, model.expectShape(operation.getInputShape(), StructureShape.class))
                    )
                    .step(MiddlewareStackStep.AFTER_BUILD)
                    .build()
            );

            middleware.add(Middleware.builder()
                    .klass("Hearth::HTTP::Middleware::ContentMD5")
                    .step(MiddlewareStackStep.AFTER_BUILD)
                    .operationPredicate(
                            (model, service, operation) -> operation.hasTrait(HttpChecksumRequiredTrait.class))
                    .build()
            );

            String disableRequestCompressionDocumentation = """
                When set to 'true' the request body will not be compressed for supported operations.
                """;

            ClientConfig disableRequestCompression = ClientConfig.builder()
                    .name("disable_request_compression")
                    .type("Boolean")
                    .defaultPrimitiveValue("false")
                    .documentation(disableRequestCompressionDocumentation)
                    .allowOperationOverride()
                    .build();

            String minCompressionDocumentation = """
                The minimum size bytes that triggers compression for request bodies.
                The value must be non-negative integer value between 0 and 10485780 bytes inclusive.
                """;

            ClientConfig requestMinCompressionSizeBytes = ClientConfig.builder()
                    .name("request_min_compression_size_bytes")
                    .type("Integer")
                    .documentation(minCompressionDocumentation)
                    .allowOperationOverride()
                    .defaultPrimitiveValue("10240")
                    .constraint(new RangeConstraint(0, 10485760))
                    .build();

            Middleware.Builder compressionBuilder = Middleware.builder()
                    .operationPredicate(
                            ((model, service, operation) -> operation.hasTrait(RequestCompressionTrait.class)))
                    .operationParams((ctx, operation) -> {
                        Map<String, String> params = new HashMap<>();
                        RequestCompressionTrait requestCompression =
                                operation.expectTrait(RequestCompressionTrait.class);
                        Shape inputShape = ctx.model().expectShape(operation.getInputShape());

                        params.put("encodings", "[" + requestCompression
                                .getEncodings()
                                .stream()
                                .map((s) -> "'" + s + "'")
                                .collect(Collectors.joining(", ")) + "]");

                        params.put("streaming",
                                Streaming.isStreaming(ctx.model(), inputShape) ? "true" : "false");

                        return params;
                    })
                    .klass("Hearth::HTTP::Middleware::RequestCompression")
                    .step(MiddlewareStackStep.AFTER_BUILD);
// commented out since Middleware Relative needs an update to handle this case
//                .relative(new Middleware.Relative(Middleware.Relative.Type.BEFORE,
//                        "Hearth::HTTP::Middleware::ContentMD5"))


            TopDownIndex topDownIndex = TopDownIndex.of(context.model());
            Set<OperationShape> containedOperations = topDownIndex.getContainedOperations(context.service());
            boolean hasCompression =
                    containedOperations.stream().anyMatch((o) -> o.hasTrait(RequestCompressionTrait.class));

            if (hasCompression) {
                compressionBuilder.addConfig(disableRequestCompression);
                compressionBuilder.addConfig(requestMinCompressionSizeBytes);
            }

            middleware.add(compressionBuilder.build());

            middleware.add(Middleware.builder()
                    .klass(Hearth.PARSE_MIDDLEWARE)
                    .step(MiddlewareStackStep.PARSE)
                    .operationParams((ctx, operation) -> {
                        Map<String, String> params = new HashMap<>();
                        params.put("data_parser",
                                "Parsers::" + ctx.symbolProvider().toSymbol(operation).getName());
                        String successCode = "200";
                        Optional<HttpTrait> httpTrait = operation.getTrait(HttpTrait.class);
                        if (httpTrait.isPresent()) {
                            successCode = "" + httpTrait.get().getCode();
                        }
                        String errors = operation.getErrors()
                                .stream()
                                .map((error) -> "Errors::"
                                        + ctx.symbolProvider().toSymbol(ctx.model().expectShape(error)).getName())
                                .collect(Collectors.joining(", "));
                        params.put("error_parser",
                                "Hearth::HTTP::ErrorParser.new("
                                        + "error_module: Errors, success_status: " + successCode
                                        + ", errors: [" + errors + "]" + ")"
                        );
                        return params;
                    })
                    .build()
            );

            return middleware;
        };

        return new ApplicationTransport(
                "http",
                request,
                response,
                client,
                defaultMiddleware);
    }

    /**
     * Gets the Transport name.
     *
     * <p>All HTTP Transports should start with "http".
     * All MQTT Transports should start with "mqtt".
     *
     * @return Returns the Transport name.
     */
    public String getName() {
        return name;
    }

    /**
     * Checks if the Transport is an HTTP based Transport.
     *
     * @return Returns true if it is HTTP based.
     */
    public boolean isHttpTransport() {
        return getName().startsWith("http");
    }

    /**
     * @return a client fragment that will construct the transport's ruby Request object
     */
    public ClientFragment getRequest() {
        return request;
    }

    /**
     * @return a client fragment that will construct the transport's ruby Response object
     */
    public ClientFragment getResponse() {
        return response;
    }

    /**
     * @return a client fragment that will construct the transport's ruby Client object
     */
    public ClientFragment getTransportClient() {
        return transportClient;
    }

    /**
     * @return the error inspector used for HTTP errors.
     */
    public String getErrorInspector() {
        return Hearth.HTTP_ERROR_INSPECTOR.toString();
    }

    /**
     * @param context generation context
     * @return list of default middleware to support this transport.
     */
    public List<Middleware> defaultMiddleware(GenerationContext context) {
        return this.defaultMiddleware.list(this, context);
    }

    /**
     * @return All client config required to support this transport.
     */
    public Set<ClientConfig> getClientConfig() {
        Set<ClientConfig> config = new HashSet<>();
        config.addAll(request.getClientConfig());
        config.addAll(response.getClientConfig());
        config.addAll(transportClient.getClientConfig());
        return config;
    }

    @Override
    public String toString() {
        return "ApplicationTransport<" + getName() + ">";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof ApplicationTransport)) {
            return false;
        }

        ApplicationTransport that = (ApplicationTransport) o;
        return name.equals(that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @FunctionalInterface
    public interface MiddlewareList {
        /**
         * Called to Render the addition of this middleware to the stack.
         *
         * @param transport - ApplicationTransport to generate list for
         * @param context   - additional context
         * @return List of middleware that should be applied to all client operations
         */
        List<Middleware> list(ApplicationTransport transport,
                              GenerationContext context);
    }
}
