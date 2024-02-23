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
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.auth.factories.HttpApiKeyAuthSchemeFactory;
import software.amazon.smithy.ruby.codegen.auth.factories.HttpBasicAuthSchemeFactory;
import software.amazon.smithy.ruby.codegen.auth.factories.HttpBearerAuthSchemeFactory;
import software.amazon.smithy.ruby.codegen.auth.factories.HttpDigestAuthSchemeFactory;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.factories.BuildMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.ContentLengthMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.ContentMD5MiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.ParseMiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.factories.RequestCompressionMiddlewareFactory;
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
    private final List<AuthScheme> defaultAuthSchemes;

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
            MiddlewareList defaultMiddleware,
            List<AuthScheme> defaultAuthSchemes

    ) {
        this.name = name;
        this.request = request;
        this.response = response;
        this.transportClient = transportClient;
        this.defaultMiddleware = defaultMiddleware;
        this.defaultAuthSchemes = defaultAuthSchemes;
    }

    /**
     * Creates a default HTTP application transport.
     *
     * @return Returns the created application Transport.
     */
    public static ApplicationTransport createDefaultHttpApplicationTransport() {

        ClientFragment request = ClientFragment.builder()
                .render((self, ctx) -> "Hearth::HTTP::Request.new(uri: URI(''))")
                .build();

        ClientFragment response = ClientFragment.builder()
                .render((self, ctx) -> "Hearth::HTTP::Response.new(body: response_body)")
                .build();

        ClientConfig httpClient = ClientConfig.builder()
                .name("http_client")
                .type("Hearth::HTTP::Client")
                .documentation("The HTTP Client to use for request transport.")
                .documentationDefaultValue("Hearth::HTTP::Client.new")
                .defaultDynamicValue("Hearth::HTTP::Client.new(logger: cfg[:logger])")
                .build();

        ClientFragment client = ClientFragment.builder()
                .addConfig(httpClient)
                .render((self, ctx) -> httpClient.renderGetConfigValue())
                .build();

        MiddlewareList defaultMiddleware = (transport, context) -> {
            List<Middleware> middleware = new ArrayList<>();

            middleware.add(BuildMiddlewareFactory.build(context));
            middleware.add(ContentLengthMiddlewareFactory.build(context));
            middleware.add(ContentMD5MiddlewareFactory.build(context));
            middleware.add(RequestCompressionMiddlewareFactory.build(context));
            middleware.add(ParseMiddlewareFactory.build(context));

            return middleware;
        };

        List<AuthScheme> defaultAuthSchemes = List.of(
                HttpApiKeyAuthSchemeFactory.build(),
                HttpBasicAuthSchemeFactory.build(),
                HttpBearerAuthSchemeFactory.build(),
                HttpDigestAuthSchemeFactory.build()
        );

        return new ApplicationTransport(
                "http",
                request,
                response,
                client,
                defaultMiddleware,
                defaultAuthSchemes);
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
     * @return list of auth schemes supported by this transport.
     */
    public List<AuthScheme> defaultAuthSchemes() {
        return defaultAuthSchemes;
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
