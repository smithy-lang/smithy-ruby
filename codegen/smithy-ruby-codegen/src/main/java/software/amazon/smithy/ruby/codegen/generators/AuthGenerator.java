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

import java.util.Comparator;
import java.util.HashSet;
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
import software.amazon.smithy.model.traits.HttpBasicAuthTrait;
import software.amazon.smithy.model.traits.HttpBearerAuthTrait;
import software.amazon.smithy.model.traits.HttpDigestAuthTrait;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.model.traits.synthetic.NoAuthTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
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
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
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
    }

    private void renderAuthParamsClass(RubyCodeWriter writer) {
        // TODO: this should have more params when hooked up with endpoint/auth rules?
        writer.write("Params = Struct.new(:operation_name, keyword_init: true)");
    }

    private void renderRbsAuthParamsClass(RubyCodeWriter writer) {
        // TODO: this should have more params when hooked up with endpoint/auth rules?
        writer
                .openBlock("class Params < ::Struct[untyped]")
                .write("attr_accessor operation_name (): ::Symbol")
                .closeBlock("end");
    }

    private void renderAuthSchemesConstant(RubyCodeWriter writer) {
        Set<Trait> authTraitsSet = new HashSet<>();
        operations.stream().forEach(operation -> {
            ServiceIndex.of(model).getEffectiveAuthSchemes(
                    service, operation, ServiceIndex.AuthSchemeMode.NO_AUTH_AWARE).forEach((shapeId, trait) -> {
                authTraitsSet.add(trait);
            });
        });

        writer
                .openBlock("SCHEMES = [")
                .call(() -> {
                    authTraitsSet.stream()
                            .sorted(Comparator.comparing(Trait::toShapeId))
                            .forEach(trait -> renderAuthScheme(writer, trait));
                })
                .unwrite(",\n")
                .write("")
                .closeBlock("].freeze");
    }

    private void renderRbsAuthSchemesConstant(RubyCodeWriter writer) {
        writer.write("SCHEMES: ::Array[Hearth::AuthSchemes::Base]");
    }

    private void renderAuthScheme(RubyCodeWriter writer, Trait trait) {
        if (trait instanceof HttpApiKeyAuthTrait) {
            writer.write("$L::HTTPApiKey.new,", Hearth.AUTH_SCHEMES);
        } else if (trait instanceof HttpBasicAuthTrait) {
            writer.write("$L::HTTPBasic.new,", Hearth.AUTH_SCHEMES);
        } else if (trait instanceof HttpBearerAuthTrait) {
            writer.write("$L::HTTPBearer.new,", Hearth.AUTH_SCHEMES);
        } else if (trait instanceof HttpDigestAuthTrait) {
            writer.write("$L::HTTPDigest.new,", Hearth.AUTH_SCHEMES);
        } else if (trait instanceof NoAuthTrait) {
            writer.write("$L::Anonymous.new,", Hearth.AUTH_SCHEMES);
        } else {
            // Custom auth schemes not supported right now
        }
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

        Map<ShapeId, Trait> authSchemes =
                ServiceIndex.of(model).getEffectiveAuthSchemes(
                        service, operation, ServiceIndex.AuthSchemeMode.NO_AUTH_AWARE);

        writer
                .write("when $L", operationName)
                .indent()
                .call(() -> {
                    authSchemes.forEach((shapeId, trait) -> {
                        if (trait instanceof HttpApiKeyAuthTrait) {
                            renderHttpApiKeyAuthOption(writer, shapeId, (HttpApiKeyAuthTrait) trait);
                        } else {
                            renderAuthOption(writer, shapeId.toString(), Optional.empty(), Optional.empty());
                        }
                    });
                })
                .dedent();
    }

    private void renderHttpApiKeyAuthOption(RubyCodeWriter writer, ShapeId shapeId,
                                           HttpApiKeyAuthTrait httpApiKeyAuthTrait) {
        String signerProperties;
        String name = httpApiKeyAuthTrait.getName();
        String in = httpApiKeyAuthTrait.getIn().toString();
        if (httpApiKeyAuthTrait.getScheme().isPresent()) {
            String scheme = httpApiKeyAuthTrait.getScheme().get();
            signerProperties = String.format("{ name: '%s', in: '%s', scheme: '%s' }", name, in, scheme);
        } else {
            signerProperties = String.format("{ name: '%s', in: '%s' }", name, in);
        }

        renderAuthOption(writer, shapeId.toString(), Optional.empty(), Optional.of(signerProperties));
    }

    private void renderAuthOption(RubyCodeWriter writer, String schemeId, Optional<String> identityProperties,
                                  Optional<String> signerProperties) {
        String args = "scheme_id: '" + schemeId + "'";
        if (identityProperties.isPresent()) {
            args += ", identity_properties: " + identityProperties.get();
        }
        if (signerProperties.isPresent()) {
            args += ", signer_properties: " + signerProperties.get();
        }
        writer.write("options << $L.new($L)", Hearth.AUTH_OPTION, args);
    }
}
