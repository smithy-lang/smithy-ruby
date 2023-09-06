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

package software.amazon.smithy.ruby.codegen.middleware.factories;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class AuthMiddlewareFactory {
    private AuthMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        SymbolProvider symbolProvider = context.symbolProvider();
        Map<ShapeId, Trait> serviceAuthSchemes =
                ServiceIndex.of(context.model()).getAuthSchemes(context.service());

        // get additional auth schemes
        Set<AuthScheme> authSchemesSet = new HashSet<>();
        context.applicationTransport().defaultAuthSchemes().forEach((s) -> authSchemesSet.add(s));
        context.integrations().forEach((i) -> {
            i.getAdditionalAuthSchemes(context).forEach((s) -> authSchemesSet.add(s));
        });

        Set<ClientConfig> clientConfigSet = new HashSet<>();
        String identityResolverDocumentation = """
                A %s that returns a %s for operations modeled with the %s auth scheme.
                """;
        serviceAuthSchemes.forEach((shapeId, trait) -> {
            AuthScheme authScheme = authSchemesSet.stream()
                    .filter(s -> s.getShapeId().equals(shapeId))
                    .findFirst()
                    .orElseThrow(() -> new IllegalStateException("No auth scheme found for " + shapeId));
            clientConfigSet.add(ClientConfig.builder()
                    .name(authScheme.getRubyIdentityResolverConfigName())
                    .type(Hearth.IDENTITY_RESOLVER.toString())
                    .documentation(
                            identityResolverDocumentation.formatted(
                                    Hearth.IDENTITY_RESOLVER,
                                    authScheme.getRubyIdentityClass(),
                                    shapeId.getName()))
                    .defaultDynamicValue(authScheme.getRubyIdentityResolverConfigDefaultValue())
                    .allowOperationOverride()
                    .build());
        });

        String authResolverDocumentation = """
                A class that responds to a `resolve(auth_params)` method where `auth_params` is
                the {Auth::Params} struct. For a given operation_name, the method must return an
                ordered list of {%s} objects to be considered for authentication.
                """.formatted(Hearth.AUTH_OPTION);
        ClientConfig authResolver = ClientConfig.builder()
                .name("auth_resolver")
                .type("Auth::Resolver")
                .allowOperationOverride()
                .documentation(authResolverDocumentation)
                .defaultValue("Auth::Resolver.new")
                .build();

        String authSchemesDocumentation = """
                An ordered list of {%s} objects that will considered when attempting to authenticate
                the request. The first scheme that returns an Identity from its %s will be used to
                authenticate the request.
                """.formatted(Hearth.AUTH_SCHEMES + "::Base", Hearth.IDENTITY_RESOLVER);
        ClientConfig authSchemes = ClientConfig.builder()
                .name("auth_schemes")
                .type("Array")
                .documentationType("Array<" + Hearth.AUTH_SCHEMES + "::Base>")
                .rbsType("Array[" + Hearth.AUTH_SCHEMES + "::Base]")
                .defaultValue("Auth::SCHEMES")
                .allowOperationOverride()
                .documentation(authSchemesDocumentation)
                .build();

        Middleware.Builder authBuilder = Middleware.builder()
                .klass(Hearth.AUTH_MIDDLEWARE)
                .step(MiddlewareStackStep.SIGN)
                .addConfig(authResolver)
                .addConfig(authSchemes)
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    Symbol symbol = symbolProvider.toSymbol(operation);
                    String operationName = RubyFormatter.toSnakeCase(symbol.getName());
                    // TODO: support more auth params in the future
                    String authParams = "Auth::Params.new(operation_name: :%s)".formatted(operationName);
                    params.put("auth_params", authParams);
                    return params;
                });
        clientConfigSet.forEach(authBuilder::addConfig);

        return authBuilder.build();
    }
}
