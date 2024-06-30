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

import software.amazon.smithy.codegen.core.Symbol;

/**
 * Symbol definitions of Hearth components.
 */
public final class Hearth {

    public static final Symbol HEARTH = Symbol.builder()
            .name("Hearth")
            .build();

    public static final Symbol CLIENT = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Client")
            .build();

    public static final Symbol CONTEXT = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Context")
            .build();

    public static final Symbol OUTPUT = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Output")
            .build();

    public static final Symbol CONFIGURATION = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Configuration")
            .build();

    public static final Symbol VALIDATOR = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Validator")
            .build();

    public static final Symbol BLOCK_IO = Symbol.builder()
            .namespace("Hearth", "::")
            .name("BlockIO")
            .build();

    public static final Symbol STUBS = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Stubs")
            .build();

    public static final Symbol HTTP_API_ERROR = Symbol.builder()
            .namespace("Hearth::HTTP", "::")
            .name("ApiError")
            .build();

    public static final Symbol HTTP_ERROR_INSPECTOR = Symbol.builder()
            .namespace("Hearth::HTTP", "::")
            .name("ErrorInspector")
            .build();

    public static final Symbol XML = Symbol.builder()
            .namespace("Hearth", "::")
            .name("XML")
            .build();

    public static final Symbol XML_NODE = Symbol.builder()
            .namespace("Hearth::XML", "::")
            .name("Node")
            .build();

    public static final Symbol JSON = Symbol.builder()
            .namespace("Hearth", "::")
            .name("JSON")
            .build();

    public static final Symbol CBOR = Symbol.builder()
            .namespace("Hearth", "::")
            .name("CBOR")
            .build();

    public static final Symbol NUMBER_HELPER = Symbol.builder()
            .namespace("Hearth", "::")
            .name("NumberHelper")
            .build();

    public static final Symbol STRUCTURE = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Structure")
            .build();

    public static final Symbol UNION = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Union")
            .build();

    public static final Symbol QUERY_PARAM_LIST = Symbol.builder()
            .namespace("Hearth::Query", "::")
            .name("ParamList")
            .build();

    public static final Symbol WAITER = Symbol.builder()
            .namespace("Hearth::Waiters", "::")
            .name("Waiter")
            .build();

    public static final Symbol POLLER = Symbol.builder()
            .namespace("Hearth::Waiters", "::")
            .name("Poller")
            .build();

    public static final Symbol PLUGIN_LIST = Symbol.builder()
            .namespace("Hearth", "::")
            .name("PluginList")
            .build();

    public static final Symbol INTERCEPTOR = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Interceptor")
            .build();

    public static final Symbol INTERCEPTOR_LIST = Symbol.builder()
            .namespace("Hearth", "::")
            .name("InterceptorList")
            .build();

    public static final Symbol AUTH_OPTION = Symbol.builder()
            .namespace("Hearth", "::")
            .name("AuthOption")
            .build();

    public static final Symbol AUTH_SCHEMES = Symbol.builder()
            .namespace("Hearth", "::")
            .name("AuthSchemes")
            .build();

    public static final Symbol IDENTITIES = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Identities")
            .build();

    public static final Symbol IDENTITY_PROVIDER = Symbol.builder()
            .namespace("Hearth", "::")
            .name("IdentityProvider")
            .build();

    public static final Symbol ANONYMOUS_AUTH_RESOLVER = Symbol.builder()
            .namespace("Hearth", "::")
            .name("AnonymousAuthResolver")
            .build();

    // Middleware
    public static final Symbol MIDDLEWARE_STACK = Symbol.builder()
            .namespace("Hearth", "::")
            .name("MiddlewareStack")
            .build();

    public static final Symbol INITIALIZE_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Initialize")
            .build();

    public static final Symbol VALIDATE_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Validate")
            .build();
    public static final Symbol BUILD_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Build")
            .build();

    public static final Symbol RETRY_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Retry")
            .build();

    public static final Symbol AUTH_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Auth")
            .build();

    public static final Symbol ENDPOINT_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Endpoint")
            .build();

    public static final Symbol HOST_PREFIX_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("HostPrefix")
            .build();

    public static final Symbol SIGN_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Sign")
            .build();

    public static final Symbol PARSE_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Parse")
            .build();

    public static final Symbol SEND_MIDDLEWARE = Symbol.builder()
            .namespace("Hearth::Middleware", "::")
            .name("Send")
            .build();

    // Rules engine / Endpoints
    public static final Symbol RULES_ENGINE_ENDPOINT = Symbol.builder()
            .namespace("Hearth::EndpointRules", "::")
            .name("Endpoint")
            .build();

    private Hearth() {

    }
}
