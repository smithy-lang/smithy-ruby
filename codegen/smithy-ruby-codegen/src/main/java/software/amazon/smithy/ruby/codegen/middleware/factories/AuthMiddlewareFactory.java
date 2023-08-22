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
import software.amazon.smithy.model.traits.HttpApiKeyAuthTrait;
import software.amazon.smithy.model.traits.HttpBasicAuthTrait;
import software.amazon.smithy.model.traits.HttpBearerAuthTrait;
import software.amazon.smithy.model.traits.HttpDigestAuthTrait;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
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

        Set<ClientConfig> clientConfigSet = new HashSet<>();
        String identityResolverDocumentation = """
                A %s that returns a %s for operations modeled with the %s auth scheme.
                """;
        serviceAuthSchemes.forEach((shapeId, trait) -> {
            clientConfigSet.add(ClientConfig.builder()
                    .name(identityResolverConfigNameForAuthTrait(trait))
                    .type(Hearth.IDENTITY_RESOLVER.toString())
                    .documentation(
                            identityResolverDocumentation.formatted(
                                    Hearth.IDENTITY_RESOLVER,
                                    hearthIdentityForAuthTrait(trait),
                                    shapeId.getName()))
                    .defaultDynamicValue(defaultIdentityResolverForAuthTrait(trait))
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
                .defaultValue("Auth::SCHEMES")
                .allowOperationOverride()
                .documentation(authSchemesDocumentation)
                .build();

        Middleware.Builder authBuilder = Middleware.builder()
                .klass(Hearth.AUTH_MIDDLEWARE)
                .step(MiddlewareStackStep.FINALIZE)
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

    private static String identityResolverConfigNameForAuthTrait(Trait trait) {
        if (trait instanceof HttpApiKeyAuthTrait) {
            return "http_api_key_identity_resolver";
        } else if (trait instanceof HttpBearerAuthTrait) {
            return "http_bearer_identity_resolver";
        } else if (trait instanceof HttpBasicAuthTrait || trait instanceof HttpDigestAuthTrait) {
            return "http_login_identity_resolver";
        } else {
            throw new IllegalStateException("Unknown auth trait: " + trait);
        }
    }

    private static String defaultIdentityResolverForAuthTrait(Trait trait) {
        String identity = Hearth.IDENTITIES + "::";
        if (trait instanceof HttpApiKeyAuthTrait) {
            identity += "HTTPApiKey.new(key: 'stubbed api key')";
        } else if (trait instanceof HttpBearerAuthTrait) {
            identity += "HTTPBearer.new(token: 'stubbed bearer')";
        } else if (trait instanceof HttpBasicAuthTrait || trait instanceof HttpDigestAuthTrait) {
            identity += "HTTPLogin.new(username: 'stubbed username', password: 'stubbed password')";
        } else {
            throw new IllegalStateException("Unknown auth trait: " + trait);
        }
        return "proc { |cfg| cfg[:stub_responses] ? %s.new(proc { %s }) : nil }"
                .formatted(Hearth.IDENTITY_RESOLVER, identity);
    }

    private static String hearthIdentityForAuthTrait(Trait trait) {
        if (trait instanceof HttpApiKeyAuthTrait) {
            return Hearth.IDENTITIES + "::HTTPApiKey";
        } else if (trait instanceof HttpBearerAuthTrait) {
            return Hearth.IDENTITIES + "::HTTPBearer";
        } else if (trait instanceof HttpBasicAuthTrait || trait instanceof HttpDigestAuthTrait) {
            return Hearth.IDENTITIES + "::HTTPLogin";
        } else {
            throw new IllegalStateException("Unknown auth trait: " + trait);
        }
    }
}
