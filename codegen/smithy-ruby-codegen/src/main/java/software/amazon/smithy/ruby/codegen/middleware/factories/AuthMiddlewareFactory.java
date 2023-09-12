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

        Set<AuthScheme> authSchemesSet = context.getAuthSchemes();
        Set<ClientConfig> identityResolversConfigSet = new HashSet<>();
        Map<String, String> identityResolversMap = new HashMap<>();

        serviceAuthSchemes.forEach((shapeId, trait) -> {
            AuthScheme authScheme = authSchemesSet.stream()
                    .filter(s -> s.getShapeId().equals(shapeId))
                    .findFirst()
                    .orElseThrow(() -> new IllegalStateException("No auth scheme found for " + shapeId));

            ClientConfig config = authScheme.getIdentityResolverConfig();
            if (config != null) {
                identityResolversConfigSet.add(config);
                String symbolizedName = RubyFormatter.toSnakeCase(config.getName());
                identityResolversMap.put(authScheme.getRubyIdentityType(), symbolizedName);
            }
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

                    HashMap<String, String> authParamsMap = new HashMap<>();
                    authParamsMap.put("operation_name",
                            RubyFormatter.asSymbol(symbolProvider.toSymbol(operation).getName()));

                    authSchemesSet.forEach(s -> {
                        Map<String, String> additionalAuthParams = s.getAdditionalAuthParams();
                        additionalAuthParams.entrySet().forEach(e -> {
                            authParamsMap.put(e.getKey(), e.getValue());
                        });
                    });
                    String authParams = "Auth::Params.new(%s)".formatted(
                            authParamsMap.entrySet().stream()
                                    .map(e -> "%s: %s".formatted(e.getKey(), e.getValue()))
                                    .reduce((a, b) -> a + ", " + b)
                                    .orElse(""));
                    params.put("auth_params", authParams);

                    String identityResolverMapHash = "{%s}".formatted(
                            identityResolversMap.entrySet().stream()
                                    .map(e -> "%s: %s".formatted(e.getValue(), e.getKey()))
                                    .reduce((a, b) -> a + ", " + b)
                                    .map(s -> " " + s + " ")
                                    .orElse(""));
                    params.put("identity_resolver_map", identityResolverMapHash);

                    return params;
                });
        identityResolversConfigSet.forEach(authBuilder::addConfig);

        return authBuilder.build();
    }
}
