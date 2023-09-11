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

import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
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
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class AuthGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(AuthGenerator.class.getName());

    private final Set<OperationShape> operations;
    private final ServiceShape service;
    private final List<AuthScheme> authSchemes;

    public AuthGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        operations = directive.operations();
        service = directive.service();
        authSchemes = directive.context().getAuthSchemes();
    }

    @Override
    String getModule() {
        return "Auth";
    }

    public void render() {
        List<String> additionalFiles = authSchemes.stream()
                .map((a) -> a.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .distinct()
                .sorted()
                .collect(Collectors.toList());

        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .writeRequireRelativeAdditionalFiles(additionalFiles)
                    .addModule(settings.getModule())
                    .addModule("Auth")
                    .call(() -> renderAuthParamsClass(writer))
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
                    .addModule("Auth")
                    .call(() -> renderRbsAuthParamsClass(writer))
                    .write("")
                    .call(() -> renderRbsAuthSchemesConstant(writer))
                    .write("")
                    .call(() -> renderRbsAuthResolver(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth rbs module to " + rbsFile());
    }

    private void renderAuthParamsClass(RubyCodeWriter writer) {
        Set<String> authParamsSet = new HashSet<>();
        authParamsSet.add(":operation_name");
        authSchemes.forEach((s) -> {
            Map<String, String> additionalAuthParams = s.getAdditionalAuthParams();
            additionalAuthParams.entrySet().stream().forEach((e) -> {
                authParamsSet.add(RubyFormatter.asSymbol(e.getKey()));
            });
        });
        String authParams = authParamsSet.stream().collect(Collectors.joining(", "));

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

                        renderAuthOption(writer, shapeId.toString(), authScheme);
                    });
                })
                .dedent();
    }

    private void renderAuthOption(RubyCodeWriter writer, String schemeId, AuthScheme authScheme) {
        String args = "scheme_id: '%s'".formatted(schemeId);

        if (!authScheme.getSignerProperties().isEmpty()) {
            String signerProperties = authScheme.getSignerProperties()
                    .entrySet().stream()
                    .map(e -> "%s: %s".formatted(e.getKey(), e.getValue()))
                    .reduce((a, b) -> a + ", " + b)
                    .map(s -> " " + s + " ")
                    .orElse("");
            args += ", signer_properties: {%s}".formatted(signerProperties);
        }

        if (!authScheme.getIdentityProperties().isEmpty()) {
            String identityProperties = authScheme.getIdentityProperties()
                    .entrySet().stream()
                    .map(e -> "%s: %s".formatted(e.getKey(), e.getValue()))
                    .reduce((a, b) -> a + ", " + b)
                    .map(s -> " " + s + " ")
                    .orElse("");
            args += ", identity_properties: {%s}".formatted(identityProperties);
        }

        writer.write("options << $L.new($L)", Hearth.AUTH_OPTION, args);
    }
}
