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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.rulesengine.language.EndpointRuleSet;
import software.amazon.smithy.rulesengine.language.syntax.parameters.Builtins;
import software.amazon.smithy.rulesengine.language.syntax.parameters.Parameters;
import software.amazon.smithy.rulesengine.traits.EndpointRuleSetTrait;
import software.amazon.smithy.rulesengine.traits.EndpointTestsTrait;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class EndpointGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(EndpointGenerator.class.getName());

    private final Set<OperationShape> operations;
    private final ServiceShape service;
    private final EndpointRuleSet endpointRuleSet;
    private final Optional<EndpointTestsTrait> endpointTests;
    public EndpointGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        operations = directive.operations();
        service = directive.service();
        endpointRuleSet =
                service.getTrait(EndpointRuleSetTrait.class)
                        .map(t -> EndpointRuleSet.fromNode(t.getRuleSet()))
                        .orElseGet();
    }

    @Override
    String getModule() {
        return "Endpoint";
    }

    public void render() {
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .addModule("Endpoint")
                    .call(() -> renderEndpointParamsClass(writer))
                    .write("")
                    .call(() -> renderAuthSchemesConstant(writer))
                    .write("")
                    .call(() -> renderAuthResolver(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth module to " + rbFile());
    }

    public void renderRbs() {
        writeRbs(writer -> {
            writer
                    .preamble()
                    .addModule(settings.getModule())
                    .addModule("Endpoint")
                    .call(() -> renderRbsAuthParamsClass(writer))
                    .write("")
                    .call(() -> renderRbsAuthSchemesConstant(writer))
                    .write("")
                    .call(() -> renderRbsAuthResolver(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth rbs module to " + rbsFile());
    }

    private void renderEndpointParamsClass(RubyCodeWriter writer) {
        List<String> authParamsList = new ArrayList<>();
        authParamsList.add(":operation_name");
        authSchemes.forEach((s) -> {
            Map<String, String> additionalAuthParams = s.getAdditionalAuthParams();
            additionalAuthParams.entrySet().stream().forEach((e) -> {
                authParamsList.add(RubyFormatter.asSymbol(e.getKey()));
            });
        });
        String authParams = authParamsList.stream().collect(Collectors.joining(", "));

        writer.write("Params = Struct.new($L, keyword_init: true)", authParams);
    }

    private void renderRbsAuthParamsClass(RubyCodeWriter writer) {
        Map<String, String> authParamsMap = new HashMap<String, String>();
        authParamsMap.put("operation_name", "::Symbol");
        authSchemes.forEach((s) -> {
            Map<String, String> additionalAuthParams = s.getAdditionalAuthParams();
            additionalAuthParams.entrySet().stream().forEach((e) -> {
                authParamsMap.put(RubyFormatter.toSnakeCase(e.getKey()), "untyped");
            });
        });

        writer
                .openBlock("class Params < ::Struct[untyped]")
                .call(() -> {
                    authParamsMap.entrySet().stream().forEach((e) -> {
                        writer.write("attr_accessor $L (): $L", e.getKey(), e.getValue());
                    });
                })
                .closeBlock("end");
    }

    private void renderAuthSchemesConstant(RubyCodeWriter writer) {
        Set<Trait> authTraits = new HashSet<>();
        operations.stream().forEach(operation -> {
            ServiceIndex.of(model).getEffectiveAuthSchemes(
                    service, operation, ServiceIndex.AuthSchemeMode.NO_AUTH_AWARE).forEach((shapeId, trait) -> {
                authTraits.add(trait);
            });
        });

        writer
                .openBlock("SCHEMES = [")
                .call(() -> {
                    authTraits.stream()
                            .sorted(Comparator.comparing(Trait::toShapeId))
                            .forEach(authTrait -> {
                                ShapeId shapeId = authTrait.toShapeId();
                                AuthScheme authScheme = authSchemes.stream()
                                        .filter(s -> s.getShapeId().equals(shapeId))
                                        .findFirst()
                                        .orElseThrow(
                                                () -> new IllegalStateException("No auth scheme found for " + shapeId));
                                writer.write("$L,", authScheme.getRubyAuthScheme());
                            });
                })
                .unwrite(",\n")
                .write("")
                .closeBlock("].freeze");
    }

    private void renderRbsAuthSchemesConstant(RubyCodeWriter writer) {
        writer.write("SCHEMES: ::Array[Hearth::AuthSchemes::Base]");
    }

    private void renderAuthResolver(RubyCodeWriter writer) {
        writer
                .openBlock("class Resolver")
                .write("")
                .openBlock("def resolve(auth_params)")
                .write("options = []")
                .write("case auth_params.operation_name")
                .call(() -> {
                    for (OperationShape operation : operations) {
                        renderOperationAuthOptionsCase(writer, operation);
                    }
                })
                .write("end")
                .closeBlock("end")
                .write("")
                .closeBlock("end");
    }

    private void renderRbsAuthResolver(RubyCodeWriter writer) {
        writer
                .openBlock("class Resolver")
                .write("def resolve: (auth_params: Params) -> ::Array[Hearth::AuthOption]")
                .closeBlock("end");
    }

    private void renderOperationAuthOptionsCase(RubyCodeWriter writer, OperationShape operation) {
        String operationName =
                RubyFormatter.asSymbol(symbolProvider.toSymbol(operation).getName());

        Map<ShapeId, Trait> operationAuthSchemes =
                ServiceIndex.of(model).getEffectiveAuthSchemes(
                        service, operation, ServiceIndex.AuthSchemeMode.NO_AUTH_AWARE);

        writer
                .write("when $L", operationName)
                .indent()
                .call(() -> {
                    operationAuthSchemes.forEach((shapeId, trait) -> {
                        AuthScheme authScheme = authSchemes.stream()
                                .filter(s -> s.getShapeId().equals(shapeId))
                                .findFirst()
                                .orElseThrow(() -> new IllegalStateException("No auth scheme found for " + shapeId));

                        renderAuthOption(writer, shapeId.toString(), trait, authScheme);
                    });
                })
                .dedent();
    }

    private void renderAuthOption(RubyCodeWriter writer, String schemeId, Trait trait, AuthScheme authScheme) {
        String args = "scheme_id: '%s'".formatted(schemeId);

        Map<String, String> signerPropertiesMap = authScheme.getSignerProperties(trait);
        if (!signerPropertiesMap.isEmpty()) {
            String signerProperties = signerPropertiesMap
                    .entrySet().stream()
                    .map(e -> "%s: %s".formatted(e.getKey(), e.getValue()))
                    .reduce((a, b) -> a + ", " + b)
                    .map(s -> " " + s + " ")
                    .orElse("");
            args += ", signer_properties: {%s}".formatted(signerProperties);
        }

        Map<String, String> identityPropertiesMap = authScheme.getIdentityProperties(trait);
        if (!identityPropertiesMap.isEmpty()) {
            String identityProperties = identityPropertiesMap
                    .entrySet().stream()
                    .map(e -> "%s: %s".formatted(e.getKey(), e.getValue()))
                    .reduce((a, b) -> a + ", " + b)
                    .map(s -> " " + s + " ")
                    .orElse("");
            args += ", identity_properties: {%s}".formatted(identityProperties);
        }

        writer.write("options << $L.new($L)", Hearth.AUTH_OPTION, args);
    }

    private static EndpointRuleSet defaultRuleset() {
        return EndpointRuleSet.builder()
                .parameters(Parameters.builder()
                        .addParameter(Builtins.SDK_ENDPOINT)
                        .build())
                .build();
    }
}
