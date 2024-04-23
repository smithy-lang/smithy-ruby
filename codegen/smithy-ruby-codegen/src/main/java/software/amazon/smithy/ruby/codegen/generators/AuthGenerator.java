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
import software.amazon.smithy.ruby.codegen.auth.AuthParam;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.auth.factories.AnonymousAuthSchemeFactory;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class AuthGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(AuthGenerator.class.getName());

    private final Set<OperationShape> operations;
    private final ServiceShape service;

    public AuthGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        operations = directive.operations();
        service = directive.service();
    }

    @Override
    String getModule() {
        return "Auth";
    }

    public void render() {
        List<String> additionalFiles = context.getServiceAuthSchemes().stream()
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
        writer.write("Params = Struct.new($L, keyword_init: true)",
                context.getAuthParams().stream()
                        .sorted(Comparator.comparing(AuthParam::getName))
                        .map(p -> RubyFormatter.asSymbol(p.getName()))
                        .collect(Collectors.joining(", ")));
    }

    private void renderRbsAuthParamsClass(RubyCodeWriter writer) {
        writer
                .openBlock("class Params < ::Struct[untyped]")
                .call(() -> {
                    context.getAuthParams().stream()
                            .sorted(Comparator.comparing(AuthParam::getName))
                            .forEach(p -> {
                        writer.write("attr_accessor $L (): $L", p.getName(), p.getRbsType());
                    });
                })
                .closeBlock("end");
    }

    private void renderAuthSchemesConstant(RubyCodeWriter writer) {
        writer
                .openBlock("SCHEMES = [")
                .call(() -> {
                    context.getServiceAuthSchemes().stream()
                            .sorted(Comparator.comparing(AuthScheme::getShapeId))
                            .forEach(authScheme -> {
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
        // special case for only Anonymous (noAuth)
        if (context.getServiceAuthSchemes().size() == 1
                && context.getServiceAuthSchemes().contains(
                AnonymousAuthSchemeFactory.build())) {
            writer.write("Resolver = $T", Hearth.ANONYMOUS_AUTH_RESOLVER);
            return;
        }
        writer
                .openBlock("class Resolver")
                .write("")
                .openBlock("def resolve(params)")
                .write("options = []")
                .call(() -> {
                    if (!operations.isEmpty()) {
                        writer.write("case params.operation_name");
                        for (OperationShape operation : operations) {
                            renderOperationAuthOptionsCase(writer, operation);
                        }
                        writer
                                .write("else nil")
                                .write("end")
                                .write("options");
                    }
                })
                .closeBlock("end")
                .write("")
                .closeBlock("end");
    }

    private void renderRbsAuthResolver(RubyCodeWriter writer) {
        writer
                .openBlock("class Resolver")
                .write("def resolve: (Params) -> ::Array[Hearth::AuthOption]")
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
                        AuthScheme authScheme = context.getServiceAuthSchemes().stream()
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
                    .sorted(Map.Entry.comparingByKey())
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
                    .sorted(Map.Entry.comparingByKey())
                    .map(e -> "%s: %s".formatted(e.getKey(), e.getValue()))
                    .reduce((a, b) -> a + ", " + b)
                    .map(s -> " " + s + " ")
                    .orElse("");
            args += ", identity_properties: {%s}".formatted(identityProperties);
        }

        writer.write("options << $L.new($L)", Hearth.AUTH_OPTION, args);
    }
}
