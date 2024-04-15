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
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.RespondsToConstraint;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class AuthMiddlewareFactory {
    private AuthMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        SymbolProvider symbolProvider = context.symbolProvider();
        Map<ShapeId, Trait> serviceAuthSchemes =
                ServiceIndex.of(context.model()).getAuthSchemes(context.service());

        Set<AuthScheme> authSchemesSet = context.getAllAuthSchemes();
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
                identityResolversMap.put(authScheme.getRubyIdentityType(), config.renderGetConfigValue());
            }
        });

        ClientConfig authResolver = buildAuthResolverConfig();
        ClientConfig authSchemes = buildAuthSchemesConfig();

        Middleware.Builder authBuilder = Middleware.builder()
                .klass(Hearth.AUTH_MIDDLEWARE)
                .step(MiddlewareStackStep.AFTER_BUILD)
                .addConfig(authResolver)
                .addConfig(authSchemes)
                .renderAdd((writer, middleware, context1, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    // Static params - auth resolver, schemes, and params
                    params.put("auth_resolver", authResolver.renderGetConfigValue());
                    params.put("auth_schemes", authSchemes.renderGetConfigValue());

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

                    String staticParamsBlock = params
                            .entrySet()
                            .stream()
                            .map(entry -> entry.getKey() + ": " + entry.getValue())
                            .collect(Collectors.joining(",\n"));

                    // Dynamic params - identity resolvers as Class => config entries
                    String identityResolversBlock = identityResolversMap
                            .entrySet()
                            .stream()
                            .map(entry -> "%s => %s".formatted(entry.getKey(), entry.getValue()))
                            .collect(Collectors.joining(",\n"));

                    writer
                            .write("stack.use($L,", middleware.getKlass())
                            .indent()
                            .writeInline(staticParamsBlock)
                            .call(() -> {
                                if (!identityResolversBlock.isEmpty()) {
                                    writer.writeInline(",\n$L", identityResolversBlock);
                                }
                            })
                            .dedent()
                            .write("\n)");
                });

        identityResolversConfigSet.forEach(authBuilder::addConfig);
        context.getServiceAuthSchemes().forEach(authScheme ->  {
            authScheme.getAdditionalConfig().forEach(authBuilder::addConfig);
        });
        return authBuilder.build();
    }

    private static ClientConfig buildAuthResolverConfig() {
        String authResolverDocumentation = """
                A class that responds to a `resolve(auth_params)` method where `auth_params` is
                the {Auth::Params} struct. For a given operation_name, the method must return an
                ordered list of {%s} objects to be considered for authentication.
                """.formatted(Hearth.AUTH_OPTION);
        return ClientConfig.builder()
                .name("auth_resolver")
                .defaultValue("Auth::Resolver.new")
                .documentation(authResolverDocumentation)
                .documentationType("#resolve(params)")
                .rbsType("Hearth::_AuthResolver[Auth::Params]")
                .documentationDefaultValue("Auth::Resolver.new")
                .constraint(new RespondsToConstraint(List.of("resolve")))
                .build();
    }

    private static ClientConfig buildAuthSchemesConfig() {
        String authSchemesDocumentation = """
                An ordered list of {%s} objects that will considered when attempting to authenticate
                the request. The first scheme that returns an Identity from its %s will be used to
                authenticate the request.
                """.formatted(Hearth.AUTH_SCHEMES + "::Base", Hearth.IDENTITY_RESOLVER);
        return ClientConfig.builder()
                .name("auth_schemes")
                .defaultValue("Auth::SCHEMES")
                .rbsType("Array[" + Hearth.AUTH_SCHEMES + "::Base]")
                .documentationType("Array<" + Hearth.AUTH_SCHEMES + "::Base>")
                .validateType("Array")
                .documentation(authSchemesDocumentation)
                .build();
    }
}
