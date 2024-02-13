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
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.build.SmithyBuildException;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.rulesengine.language.EndpointRuleSet;
import software.amazon.smithy.rulesengine.language.syntax.parameters.Parameter;
import software.amazon.smithy.rulesengine.language.syntax.parameters.ParameterType;
import software.amazon.smithy.rulesengine.traits.ClientContextParamsTrait;
import software.amazon.smithy.rulesengine.traits.ContextParamTrait;
import software.amazon.smithy.rulesengine.traits.EndpointTestsTrait;
import software.amazon.smithy.rulesengine.traits.StaticContextParamDefinition;
import software.amazon.smithy.rulesengine.traits.StaticContextParamsTrait;
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
        endpointRuleSet = context.getEndpointRuleSet();
        endpointTests = service.getTrait(EndpointTestsTrait.class);
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
                    .call(() -> renderEndpointResolver(writer))
                    .write("")
                    .addModule("Parameters")
                    .call(() -> renderParamBuilders(writer))
                    .closeModule()
                    .write("")
//                    .call(() -> renderAuthSchemesConstant(writer))
//                    .write("")
//                    .call(() -> renderAuthResolver(writer))
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
                    .call(() -> renderRbsEndpointParamsClass(writer))
                    .write("")
//                    .call(() -> renderRbsAuthSchemesConstant(writer))
//                    .write("")
//                    .call(() -> renderRbsAuthResolver(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth rbs module to " + rbsFile());
    }

    private void renderEndpointParamsClass(RubyCodeWriter writer) {
        List<String> params = new ArrayList<>();
        Map<String, String> defaultParams = new LinkedHashMap<>();
        endpointRuleSet.getParameters().forEach((parameter -> {
            String rubyParamName = RubyFormatter.asSymbol(parameter.getName().getName().getValue());
            params.add(rubyParamName);
            if (parameter.getDefault().isPresent()) {
                if (parameter.getType() == ParameterType.STRING) {
                    defaultParams.put(rubyParamName,
                            "'" + parameter.getDefault().get().expectStringValue().getValue() + "'");
                } else if (parameter.getType() == ParameterType.BOOLEAN) {
                    defaultParams.put(rubyParamName,
                            parameter.getDefault().get().expectBooleanValue().getValue() ? "true" : "false");
                } else {
                    throw new IllegalArgumentException("Unexpected parameter type: " + parameter.getType());
                }
            }
        }));

        writer
                .openBlock("Params = ::Struct.new(")
                .write(String.join(",\n", params) + ", ")
                .write("keyword_init: true")
                .closeBlock(") do")
                .indent()
                .write("include $T", Hearth.STRUCTURE)
                .call(() -> {
                    if (!defaultParams.isEmpty()) {
                        writer
                                .openBlock("\ndef initialize(*)")
                                .write("super")
                                .call(() -> {
                                    defaultParams.forEach((param, defaultValue) -> {
                                        writer.write("self.$1L = $2L if self.$1L.nil?",
                                                param,
                                                defaultValue);
                                    });
                                })
                                .closeBlock("end");
                    }

                })
                .closeBlock("end");
    }

    private void renderRbsEndpointParamsClass(RubyCodeWriter writer) {
        Map<String, String> paramsToTypes = new HashMap<>();
        endpointRuleSet.getParameters().forEach((parameter -> {
            String rubyParamName = RubyFormatter.toSnakeCase(parameter.getName().getName().getValue());
            if (parameter.getType() == ParameterType.STRING) {
                paramsToTypes.put(rubyParamName, "::String");
            } else if (parameter.getType() == ParameterType.BOOLEAN) {
                paramsToTypes.put(rubyParamName, "bool");
            } else {
                throw new IllegalArgumentException("Unexpected parameter type: " + parameter.getType());
            }
        }));

        writer
                .openBlock("class Params < ::Struct[untyped]")
                .call(() -> {
                    paramsToTypes.forEach((param, rbsType) -> {
                        writer.write("attr_accessor $L: $L", param, rbsType);
                    });
                })
                .closeBlock("end");
    }

    private void renderParamBuilders(RubyCodeWriter writer) {
        Map<String, String> clientContextParams = new HashMap<>();
        service.getTrait(ClientContextParamsTrait.class).ifPresent((clientContext) -> {
            clientContext.getParameters().forEach((name, param) -> {
                clientContextParams.put(name, RubyFormatter.toSnakeCase(name));
            });
        });

        for (OperationShape operation : operations) {
            Map<String, StaticContextParamDefinition> staticContextParams = new HashMap<>();
            operation.getTrait(StaticContextParamsTrait.class).ifPresent((staticContext) -> {
                staticContext.getParameters().forEach((name, p) -> {
                    staticContextParams.put(name, p);
                });
            });

            Map<String, String> contextParams = new HashMap<>();
            context.model().expectShape(operation.getInputShape(), StructureShape.class)
                    .getAllMembers().forEach((n, member) -> {
                member.getMemberTrait(context.model(), ContextParamTrait.class).ifPresent(contextParam -> {
                    contextParams.put(contextParam.getName(), symbolProvider.toMemberName(member));
                });
            });
            // Optional<ContextParamTrait> contextParams = operation.getTrait(ContextParamTrait.class);

            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(operation).getName())
                    .openBlock("def self.build(config, input, context)")
                    .write("params = Params.new")
                    .call(() -> {
                        for (Parameter p : endpointRuleSet.getParameters()) {
                            String paramName = p.getName().toString();
                            if (staticContextParams.containsKey(paramName)) {
                                StaticContextParamDefinition def = staticContextParams.get(paramName);
                                String value;
                                if (def.getValue().isStringNode()) {
                                    value = "'" + def.getValue().expectStringNode() + "'";
                                } else if (def.getValue().isBooleanNode()) {
                                    value = def.getValue().expectBooleanNode().getValue() ? "true" : "false";
                                } else {
                                    throw new SmithyBuildException("Unexpected StaticContextParam type: "
                                            + def.getValue().getType() + " for parameter: " + paramName);
                                }
                                writer.write("params.$L = $L",
                                        RubyFormatter.toSnakeCase(paramName), value);
                            } else if (clientContextParams.containsKey(paramName)) {
                                writer.write("params.$1L = config[:$1L]",
                                        clientContextParams.get(paramName));
                            } else if (contextParams.containsKey(paramName)) {
                                writer.write("params.$L = input.$L",
                                        RubyFormatter.toSnakeCase(paramName),
                                        contextParams.get(paramName));
                            } else if (p.isBuiltIn()) {
                                context.getBuiltInBinding(p.getName()).get().renderBuild(writer, context, operation);
                            }
                            // some parameters may not have bindings for an operation, leave them as nil or default
                        }
                    })
                    .write("params")
                    .closeBlock("end")
                    .closeBlock("end");
        }
    }

    private void renderEndpointResolver(RubyCodeWriter writer) {
        writer
                .openBlock("class Resolver")
                .openBlock("def resolve_endpoint(params)")
                .write("Hearth::RulesEngine::Endpoint.new(uri: 'https://example.com')")
                .closeBlock("end")
                .closeBlock("end");

    }

}
