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

    public static final Symbol CLIENT_STUBS = Symbol.builder()
            .namespace("Hearth", "::")
            .name("ClientStubs")
            .build();

    public static final Symbol MIDDLEWARE_BUILDER = Symbol.builder()
            .namespace("Hearth", "::")
            .name("MiddlewareBuilder")
            .build();

    public static final Symbol MIDDLEWARE_STACK = Symbol.builder()
            .namespace("Hearth", "::")
            .name("MiddlewareStack")
            .build();

    public static final Symbol CONTEXT = Symbol.builder()
            .namespace("Hearth", "::")
            .name("Context")
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
            .namespace("Hearth::Stubbing", "::")
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

    public static final Symbol INTERCEPTOR_LIST = Symbol.builder()
            .namespace("Hearth", "::")
            .name("InterceptorList")
            .build();

    private Hearth() {

    }
}
