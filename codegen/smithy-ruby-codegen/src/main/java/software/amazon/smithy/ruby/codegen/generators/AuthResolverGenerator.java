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

import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.HttpApiKeyAuthTrait;
import software.amazon.smithy.model.traits.OptionalAuthTrait;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class AuthResolverGenerator extends RubyGeneratorBase {
    private static final Logger LOGGER =
            Logger.getLogger(AuthResolverGenerator.class.getName());

    private final Set<OperationShape> operations;
    private final ServiceShape service;

    public AuthResolverGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.operations = directive.operations();
        this.service = directive.service();
    }

    @Override
    String getModule() {
        return "AuthResolver";
    }

    public void render() {
        write(writer -> {
            writer
                    .includePreamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .call(() -> renderAuthParams(writer))
                    .write("")
                    .call(() -> renderAuthResolver(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth resolver to " + rbFile());
    }

    private void renderAuthResolver(RubyCodeWriter writer) {
        writer
                .openBlock("class AuthResolver")
                .write("")
                .openBlock("def resolve(auth_params)")
                .write("options = []")
                .call(() -> renderSwitchCase(writer))
                .closeBlock("end")
                .write("")
                .closeBlock("end");
    }

    private void renderAuthParams(RubyCodeWriter writer) {
        // TODO: this should have more params when hooked up with endpoint/auth rules?
        writer.write("AuthParams = Struct.new(:operation_name)");
    }

    private void renderSwitchCase(RubyCodeWriter writer) {
        writer
                .write("case auth_params.operation_name")
                .call(() -> {
                    for (OperationShape operation : operations) {
                        renderOperationAuthOptions(writer, operation);
                    }
                })
                .write("else")
                .indent()
                .call(() -> renderServiceDefaultAuthOptions(writer))
                .dedent()
                .write("end");
    }

    private void renderOperationAuthOptions(RubyCodeWriter writer, OperationShape operation) {
        String operationName =
                RubyFormatter.asSymbol(symbolProvider.toSymbol(operation).getName());
        writer
                .write("when $L", operationName)
                .indent();

        Map<ShapeId, Trait> authSchemes =
                ServiceIndex.of(model).getEffectiveAuthSchemes(service, operation);
        renderAuthOptions(writer, authSchemes);

        if (operation.hasTrait(OptionalAuthTrait.class)) {
            renderOptionalAuthTrait(writer);
        }

        writer.dedent();
    }

    private void renderServiceDefaultAuthOptions(RubyCodeWriter writer) {
        Map<ShapeId, Trait> authSchemes =
                ServiceIndex.of(model).getEffectiveAuthSchemes(service);
        renderAuthOptions(writer, authSchemes);
    }

    private void renderAuthOptions(RubyCodeWriter writer, Map<ShapeId, Trait> authSchemes) {
        if (authSchemes.isEmpty()) {
            renderOptionalAuthTrait(writer);
        } else {
            authSchemes.forEach((shapeId, trait) -> {
                if (trait instanceof HttpApiKeyAuthTrait) {
                    renderHttpApiKeyAuthTrait(writer, shapeId, (HttpApiKeyAuthTrait) trait);
                } else {
                    renderAuthOption(writer, shapeId.toString(), Optional.empty(), Optional.empty());
                }
            });
        }
    }

    private void renderHttpApiKeyAuthTrait(RubyCodeWriter writer, ShapeId shapeId,
                                           HttpApiKeyAuthTrait httpApiKeyAuthTrait) {
        String signingProperties;
        String name = httpApiKeyAuthTrait.getName();
        String in = httpApiKeyAuthTrait.getIn().toString();
        if (httpApiKeyAuthTrait.getScheme().isPresent()) {
            String scheme = httpApiKeyAuthTrait.getScheme().get();
            signingProperties = String.format("{ name: '%s', in: '%s', scheme: '%s' }", name, in, scheme);
        } else {
            signingProperties = String.format("{ name: '%s', in: '%s' }", name, in);
        }

        renderAuthOption(writer, shapeId.toString(), Optional.empty(), Optional.of(signingProperties));
    }

    private void renderOptionalAuthTrait(RubyCodeWriter writer) {
        renderAuthOption(writer, "smithy.api#noAuth", Optional.empty(), Optional.empty());
    }

    private void renderAuthOption(RubyCodeWriter writer, String schemeId, Optional<String> identityProperties,
                                  Optional<String> signingProperties) {
        String args = "scheme_id: '" + schemeId + "'";
        if (identityProperties.isPresent()) {
            args += ", identity_properties: " + identityProperties.get();
        }
        if (signingProperties.isPresent()) {
            args += ", signing_properties: " + signingProperties.get();
        }
        writer.write("options << $L.new($L)", Hearth.AUTH_OPTION, args);
    }
}
