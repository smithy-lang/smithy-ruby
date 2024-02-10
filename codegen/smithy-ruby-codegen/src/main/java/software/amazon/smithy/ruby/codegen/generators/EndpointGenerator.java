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
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.rulesengine.language.Endpoint;
import software.amazon.smithy.rulesengine.language.EndpointRuleSet;
import software.amazon.smithy.rulesengine.language.syntax.parameters.BuiltIns;
import software.amazon.smithy.rulesengine.language.syntax.parameters.ParameterType;
import software.amazon.smithy.rulesengine.language.syntax.parameters.Parameters;
import software.amazon.smithy.rulesengine.language.syntax.rule.EndpointRule;
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
                        .orElseGet(EndpointGenerator::defaultRuleset);

        endpointTests = service.getTrait(EndpointTestsTrait.class);
    }

    private static EndpointRuleSet defaultRuleset() {
        return EndpointRuleSet.builder()
                .parameters(Parameters.builder()
                        .addParameter(BuiltIns.SDK_ENDPOINT)
                        .build())
                .addRule(EndpointRule.builder()
                        .validateOrElse(
                                "Endpoint is not set - you must configure an endpoint.",
                                BuiltIns.SDK_ENDPOINT.isSet()
                        )
                        .endpoint(Endpoint.builder().url(BuiltIns.SDK_ENDPOINT.toExpression()).build()))
                .build();
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
                    .addModule("Parameters")
                    .call(() -> renderParamBuilders(writer))
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

    }
}
