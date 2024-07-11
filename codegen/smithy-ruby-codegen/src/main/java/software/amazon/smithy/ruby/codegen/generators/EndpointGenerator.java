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
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.SmithyBuildException;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.jmespath.JmespathExpression;
import software.amazon.smithy.jmespath.ast.AndExpression;
import software.amazon.smithy.jmespath.ast.ComparatorExpression;
import software.amazon.smithy.jmespath.ast.CurrentExpression;
import software.amazon.smithy.jmespath.ast.ExpressionTypeExpression;
import software.amazon.smithy.jmespath.ast.FieldExpression;
import software.amazon.smithy.jmespath.ast.FilterProjectionExpression;
import software.amazon.smithy.jmespath.ast.FlattenExpression;
import software.amazon.smithy.jmespath.ast.FunctionExpression;
import software.amazon.smithy.jmespath.ast.IndexExpression;
import software.amazon.smithy.jmespath.ast.LiteralExpression;
import software.amazon.smithy.jmespath.ast.MultiSelectHashExpression;
import software.amazon.smithy.jmespath.ast.MultiSelectListExpression;
import software.amazon.smithy.jmespath.ast.NotExpression;
import software.amazon.smithy.jmespath.ast.ObjectProjectionExpression;
import software.amazon.smithy.jmespath.ast.OrExpression;
import software.amazon.smithy.jmespath.ast.ProjectionExpression;
import software.amazon.smithy.jmespath.ast.SliceExpression;
import software.amazon.smithy.jmespath.ast.Subexpression;
import software.amazon.smithy.model.node.ArrayNode;
import software.amazon.smithy.model.node.BooleanNode;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.NodeVisitor;
import software.amazon.smithy.model.node.NullNode;
import software.amazon.smithy.model.node.NumberNode;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.node.StringNode;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.rulesengine.AuthSchemeBinding;
import software.amazon.smithy.ruby.codegen.rulesengine.FunctionBinding;
import software.amazon.smithy.ruby.codegen.util.ParamsToHash;
import software.amazon.smithy.rulesengine.language.Endpoint;
import software.amazon.smithy.rulesengine.language.EndpointRuleSet;
import software.amazon.smithy.rulesengine.language.syntax.Identifier;
import software.amazon.smithy.rulesengine.language.syntax.expressions.Expression;
import software.amazon.smithy.rulesengine.language.syntax.expressions.ExpressionVisitor;
import software.amazon.smithy.rulesengine.language.syntax.expressions.Reference;
import software.amazon.smithy.rulesengine.language.syntax.expressions.Template;
import software.amazon.smithy.rulesengine.language.syntax.expressions.TemplateVisitor;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.BooleanEquals;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.FunctionDefinition;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.GetAttr;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.IsSet;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.StringEquals;
import software.amazon.smithy.rulesengine.language.syntax.expressions.literal.Literal;
import software.amazon.smithy.rulesengine.language.syntax.expressions.literal.LiteralVisitor;
import software.amazon.smithy.rulesengine.language.syntax.parameters.Parameter;
import software.amazon.smithy.rulesengine.language.syntax.parameters.ParameterType;
import software.amazon.smithy.rulesengine.language.syntax.rule.Condition;
import software.amazon.smithy.rulesengine.language.syntax.rule.Rule;
import software.amazon.smithy.rulesengine.language.syntax.rule.RuleValueVisitor;
import software.amazon.smithy.rulesengine.traits.ClientContextParamsTrait;
import software.amazon.smithy.rulesengine.traits.ContextParamTrait;
import software.amazon.smithy.rulesengine.traits.EndpointTestCase;
import software.amazon.smithy.rulesengine.traits.EndpointTestOperationInput;
import software.amazon.smithy.rulesengine.traits.EndpointTestsTrait;
import software.amazon.smithy.rulesengine.traits.ExpectedEndpoint;
import software.amazon.smithy.rulesengine.traits.OperationContextParamDefinition;
import software.amazon.smithy.rulesengine.traits.OperationContextParamsTrait;
import software.amazon.smithy.rulesengine.traits.StaticContextParamDefinition;
import software.amazon.smithy.rulesengine.traits.StaticContextParamsTrait;
import software.amazon.smithy.utils.Pair;
import software.amazon.smithy.utils.SmithyInternalApi;
import software.amazon.smithy.utils.StringUtils;

@SmithyInternalApi
public class EndpointGenerator extends RubyGeneratorBase {
    public static final Identifier NAME = Identifier.of("name");
    public static final String AUTH_SCHEMES = "authSchemes";
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

    private void renderTestCaseExpected(RubyCodeWriter writer, EndpointTestCase testCase) {
        if (testCase.getExpect().getError().isPresent()) {
            writer.write("{error: $L}",
                    StringUtils.escapeJavaString(testCase.getExpect().getError().get(), ""));
        } else {
            ExpectedEndpoint expected = testCase.getExpect().getEndpoint().get();
            String expectedHeaders = "{" + expected.getHeaders().entrySet().stream().map(e -> {
                return "'" + e.getKey() + "' => [" + e.getValue().stream().map(h -> "'" + h + "'")
                        .collect(Collectors.joining(",")) + "]";
            }).collect(Collectors.joining(", ")) + "}";
            String expectedAuthSchemes = "[]";
            Node authSchemes = expected.getProperties().get(AUTH_SCHEMES);
            if (authSchemes != null) {
                expectedAuthSchemes = "[" + authSchemes.expectArrayNode()
                        .getElementsAs(ObjectNode.class).stream().map(authScheme -> {
                            String name = authScheme.getStringMember("name")
                                    .get().getValue();
                            if (!context.getAuthSchemeBinding(name).isPresent()) {
                                return null;
                            }
                            AuthSchemeBinding authSchemeBinding = context.getAuthSchemeBinding(name).get();

                            ObjectNode.Builder filteredProperties = ObjectNode.builder();
                            authScheme.getStringMap().forEach((k, v) -> {
                                if (authSchemeBinding.getAuthSchemeProperty(k).isPresent()) {
                                    filteredProperties.withMember(
                                            authSchemeBinding.getAuthSchemeProperty(k).get(), v);
                                }
                            });
                            String propertiesHash = filteredProperties.build().accept(new RubyNodeVisitor());
                            return "Hearth::EndpointRules::AuthScheme.new(scheme_id: '"
                                    + authSchemeBinding.getSchemeId() + "', " + "properties: " + propertiesHash + ")";
                        }).filter(Objects::nonNull).collect(Collectors.joining(", ")) + "]";
            }
            writer
                    .openBlock("{")
                    .write("url: '$L',", expected.getUrl())
                    .write("headers: $L,", expectedHeaders)
                    .write("auth_schemes: $L", expectedAuthSchemes)
                    .closeBlock("}");
        }
    }

    @Override
    protected String getModule() {
        return "Endpoint";
    }

    public void render() {

        // Possible future optimization: only write/require files for functions that are used in this ruleset
        List<String> additionalFiles =
                Stream.concat(
                                context.getBuiltInBindingsFromEndpointRules().stream()
                                        .map(b -> b.writeAdditionalFiles(context))
                                        .flatMap(Collection::stream),
                                context.getFunctionBindings().values().stream()
                                        .map(b -> b.writeAdditionalFiles(context))
                                        .flatMap(Collection::stream)
                        )
                        .distinct()
                        .sorted()
                        .collect(Collectors.toList());

        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .writeRequireRelativeAdditionalFiles(additionalFiles)
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
                    .closeAllModules();
        });
        LOGGER.fine("Wrote endpoint to " + rbFile());

        if (endpointTests.isPresent()) {
            renderEndpointSpec();
        }
    }

    public void renderRbs() {
        writeRbs(writer -> {
            writer
                    .preamble()
                    .addModule(settings.getModule())
                    .addModule("Endpoint")
                    .call(() -> renderRbsEndpointParamsClass(writer))
                    .write("")
                    .call(() -> renderRbsEndpointResolver(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote endpoint rbs to " + rbsFile());
    }

    private void renderEndpointParamsClass(RubyCodeWriter writer) {
        List<String> params = new ArrayList<>();
        Map<String, String> defaultParams = new LinkedHashMap<>();
        endpointRuleSet.getParameters().forEach((parameter -> {
            String rubyParamName = RubyFormatter.toSnakeCase(parameter.getName().getName().getValue());
            params.add(RubyFormatter.asSymbol(rubyParamName));
            if (parameter.getDefault().isPresent()) {
                if (parameter.getType() == ParameterType.STRING) {
                    defaultParams.put(rubyParamName,
                            "'" + parameter.getDefault().get().expectStringValue().getValue() + "'");
                } else if (parameter.getType() == ParameterType.BOOLEAN) {
                    defaultParams.put(rubyParamName,
                            parameter.getDefault().get().expectBooleanValue().getValue() ? "true" : "false");
                } else if (parameter.getType() == ParameterType.STRING_ARRAY) {
                    defaultParams.put(rubyParamName,
                            "[" + parameter.getDefault().get().expectArrayValue().getValues().stream()
                                    .map(v -> "'" + v.expectStringValue().getValue() + "'")
                                    .collect(Collectors.joining(", ")) + "]");
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
                                .write("")
                                .openBlock("def initialize(*)")
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
            } else if (parameter.getType() == ParameterType.STRING_ARRAY) {
                paramsToTypes.put(rubyParamName, "::Array[::String]");
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
            Map<String, OperationContextParamDefinition> operationContextParams = new HashMap<>();
            operation.getTrait(StaticContextParamsTrait.class).ifPresent((staticContext) -> {
                staticContext.getParameters().forEach((name, p) -> {
                    staticContextParams.put(name, p);
                });
            });
            operation.getTrait(OperationContextParamsTrait.class).ifPresent((operationContext) -> {
                operationContext.getParameters().forEach((name, p) -> {
                    operationContextParams.put(name, p);
                });
            });

            Map<String, String> contextParams = new HashMap<>();
            context.model().expectShape(operation.getInputShape(), StructureShape.class)
                    .getAllMembers().forEach((n, member) -> {
                        member.getMemberTrait(context.model(), ContextParamTrait.class).ifPresent(contextParam -> {
                            contextParams.put(contextParam.getName(), symbolProvider.toMemberName(member));
                        });
                    });

            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(operation).getName())
                    .openBlock("def self.build(config, input, context)")
                    .write("params = Params.new")
                    .call(() -> {
                        for (Parameter p : endpointRuleSet.getParameters()) {
                            String paramName = p.getName().toString();
                            if (p.isBuiltIn()) {
                                context.getBuiltInBinding(p.getBuiltIn().get())
                                        .get().renderBuild(writer, context, operation);
                            } else if (staticContextParams.containsKey(paramName)) {
                                StaticContextParamDefinition def = staticContextParams.get(paramName);
                                String value;
                                if (def.getValue().isStringNode()) {
                                    value = "'" + def.getValue().expectStringNode() + "'";
                                } else if (def.getValue().isBooleanNode()) {
                                    value = def.getValue().expectBooleanNode().getValue() ? "true" : "false";
                                } else if (def.getValue().isArrayNode()) {
                                    value = "[" + def.getValue().expectArrayNode().getElements().stream()
                                            .map(v -> "'" + v.expectStringNode().getValue() + "'")
                                            .collect(Collectors.joining(", ")) + "]";
                                } else {
                                    throw new SmithyBuildException("Unexpected StaticContextParam type: "
                                            + def.getValue().getType() + " for parameter: " + paramName);
                                }
                                writer.write("params.$L = $L",
                                        RubyFormatter.toSnakeCase(paramName), value);
                            } else if (operationContextParams.containsKey(paramName)) {
                                OperationContextParamDefinition def = operationContextParams.get(paramName);
                                String value = JmespathExpression.parse(def.getPath())
                                        .accept(new RubyEndpointsJmesPathVisitor(
                                                context, model.expectShape(operation.getInputShape()))).left;
                                writer.write("params.$L = input$L",
                                        RubyFormatter.toSnakeCase(paramName), value);
                            } else if (clientContextParams.containsKey(paramName)) {
                                writer.write("params.$1L = config[:$1L] unless config[:$1L].nil?",
                                        clientContextParams.get(paramName));
                            } else if (contextParams.containsKey(paramName)) {
                                writer.write("params.$1L = input.$2L unless input.$2L.nil?",
                                        RubyFormatter.toSnakeCase(paramName),
                                        contextParams.get(paramName));
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
                .openBlock("def resolve(params)")
                .call(() -> mapParametersToLocals(writer))
                .write("")
                .call(() -> renderRules(writer, endpointRuleSet.getRules()))
                .write("")
                .call(() -> {
                    List<Rule> rules = endpointRuleSet.getRules();
                    // if the last rule has no conditions, then we do not need a fallback error
                    if (rules.isEmpty() || !rules.get(rules.size() - 1).getConditions().isEmpty()) {
                        writer.write("raise ArgumentError, 'No endpoint could be resolved'");
                    }
                })
                .closeBlock("end")
                .closeBlock("end");

    }

    private void renderRbsEndpointResolver(RubyCodeWriter writer) {
        writer
                .openBlock("class Resolver")
                .write("def resolve: (Params params) -> Hearth::EndpointRules::Endpoint")
                .closeBlock("end");

    }

    private void renderEndpointSpec() {
        RubyCodeWriter specWriter = new RubyCodeWriter(context.settings().getModule());

        specWriter
                .preamble()
                .write("require_relative 'spec_helper'")
                .write("")
                .addModule(settings.getModule())
                .addModule("Endpoint")
                .openBlock("describe Resolver do")
                .write("subject { Resolver.new }")
                .call(() -> renderEndpointTestCases(specWriter, endpointTests.get().getTestCases()))
                .closeBlock("end")
                .closeAllModules();

        String endpointSpecFile =
                settings.getGemName() + "/spec/endpoint_spec.rb";
        context.fileManifest().writeFile(endpointSpecFile, specWriter.toString());
        LOGGER.fine("Wrote endpoint tests to " + endpointSpecFile);
    }

    private void renderRules(RubyCodeWriter writer, List<Rule> rules) {
        for (Rule rule : rules) {
            if (rule.getDocumentation().isPresent()) {
                writer.write("# $L", rule.getDocumentation().get());
            }
            if (!rule.getConditions().isEmpty()) {
                writer
                        .call(() -> renderConditions(writer, rule.getConditions())).indent() // open if block
                        .call(() -> renderRule(writer, rule))
                        .closeBlock("end");
            } else {
                renderRule(writer, rule);
            }
        }
    }

    private void renderRule(RubyCodeWriter writer, Rule rule) {
        rule.accept(new RubyRuleVisitor(writer));
    }

    private void renderConditions(RubyCodeWriter writer, List<Condition> conditions) {

        String condition = conditions.stream().map((c) -> {
            if (c.getResult().isPresent()) {
                return "(" + RubyFormatter.toSnakeCase(c.getResult().get().getName().getValue())
                        + " = " + c.getFunction().accept(new RubyExpressionVisitor(context)) + ")";
            } else {
                return c.getFunction().accept(new RubyExpressionVisitor(context));
            }
        }).collect(Collectors.joining(" && "));
        writer.write("if $L", condition);
    }

    private void mapParametersToLocals(RubyCodeWriter writer) {
        for (Parameter parameter : endpointRuleSet.getParameters()) {
            writer.write("$1L = params.$1L", RubyFormatter.toSnakeCase(parameter.getName().toString()));
        }
    }

    private String templateExpression(Expression expression) {
        return expression.accept(new RubyExpressionVisitor(context));
    }

    private void renderEndpointTestCases(RubyCodeWriter writer, List<EndpointTestCase> testCases) {
        for (EndpointTestCase testCase : testCases) {
            String paramArgs = testCase.getParams().getMembers().entrySet().stream().map(e -> {
                String value;
                if (e.getValue().isStringNode()) {
                    value = StringUtils.escapeJavaString(e.getValue().expectStringNode().getValue(), "");
                } else if (e.getValue().isBooleanNode()) {
                    value = e.getValue().expectBooleanNode().getValue() ? "true" : "false";
                } else if (e.getValue().isArrayNode()) {
                    value = "[" + e.getValue().expectArrayNode().getElements().stream()
                            .map(v -> "'" + v.expectStringNode().getValue() + "'")
                            .collect(Collectors.joining(", ")) + "]";
                } else {
                    throw new SmithyBuildException("Unexpected endpoint test parameter type: "
                            + e.getValue().getType() + " for parameter: " + e.getKey().getValue());
                }
                return RubyFormatter.toSnakeCase(e.getKey().getValue()) + ": " + value;
            }).collect(Collectors.joining(", "));

            writer
                    .write("")
                    .openBlock("context $S do",
                            testCase.getDocumentation().orElse("Test case " + testCase.hashCode()))
                    .openBlock("let(:expected) do")
                    .call(() -> {
                        renderTestCaseExpected(writer, testCase);
                    })
                    .closeBlock("end") // end of let block
                    .write("")
                    .openBlock("it 'produces the expected output from the EndpointResolver' do")
                    .write("params = Params.new($L)", paramArgs)
                    .call(() -> {
                        if (testCase.getExpect().getError().isPresent()) {
                            writer
                                    .openBlock("expect do")
                                    .write("subject.resolve(params)")
                                    .closeBlock("end.to raise_error(ArgumentError, expected[:error])");

                        } else {
                            writer
                                    .write("endpoint = subject.resolve(params)")
                                    .write("expect(endpoint.uri).to eq(expected[:url])")
                                    .write("expect(endpoint.headers).to eq(expected[:headers])")
                                    .write("expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])");
                        }
                    })
                    .closeBlock("end") // end main test case it block
                    .call(() -> {
                        for (EndpointTestOperationInput operationInput : testCase.getOperationInputs()) {
                            renderOperationInputTest(writer, testCase, operationInput);
                        }
                    })
                    .closeBlock("end"); // end context block
        }
    }

    private void renderOperationInputTest(RubyCodeWriter writer, EndpointTestCase testCase,
                                          EndpointTestOperationInput operationInput) {
        ShapeId operationId = service.getOperations().stream()
                .filter(id -> id.getName().equals(operationInput.getOperationName()))
                .findFirst().get();
        OperationShape operation = model.expectShape(operationId, OperationShape.class);
        String operationName = RubyFormatter.toSnakeCase(
                symbolProvider.toSymbol(operation).getName());
        String configParams =
                operationInput.getClientParams().getMembers().entrySet().stream().map(e -> {
                    return RubyFormatter.toSnakeCase(e.getKey().getValue()) + ": "
                            + e.getValue().accept(new RubyNodeVisitor());
                }).collect(Collectors.joining(", "));

        writer
                .write("")
                .openBlock("it 'produces the correct output from the client "
                        + "when calling $L' do", operationName)
                .write("config = {$L}", configParams)
                .write("config[:stub_responses] = true")
                .write("config[:endpoint] = nil") // stub_responses sets this otherwise
                .call(() -> {
                    operationInput.getBuiltInParams().getMembers().forEach((builtIn, value) -> {
                        context.getBuiltInBinding(builtIn.getValue()).get()
                                .renderTestSet(writer, context, value, operation);
                    });
                })
                .write("")
                .write("client = Client.new(config)");

        String operationInputs = model.expectShape(operation.getInputShape())
                .accept(new ParamsToHash(model, operationInput.getOperationParams(), symbolProvider));

        if (testCase.getExpect().getError().isPresent()) {
            writer
                    .openBlock("expect do")
                    .write("client.$L($L)", operationName, operationInputs)
                    .closeBlock("end.to raise_error(ArgumentError, '$L')",
                            testCase.getExpect().getError().get());
        } else {
            writer.openBlock("proc = proc do |context|")
                    .write("expected_uri = URI.parse(expected[:url])")
                    .write("request_uri = context.request.uri")
                    .write("expect(request_uri.hostname).to "
                            + "end_with(expected_uri.hostname)")
                    .write("expect(request_uri.scheme).to eq(expected_uri.scheme)")
                    .write("expect(request_uri.path).to start_with(expected_uri.path)")
                    .openBlock("expected[:headers].each do |k,v|")
                    .write("expect(context.request.headers[k]).to "
                            + "eq(Hearth::HTTP::Field.new(k, v).value)")
                    .closeBlock("end")
                    .closeBlock("end")
                    .write("interceptor = Hearth::Interceptor.new(read_before_transmit: proc)")
                    .write("client.$L($L, interceptors: [interceptor])",
                            operationName, operationInputs);

            // TODO: Verify Auth
        }

        writer.closeBlock("end");
    }

    private static class RubyExpressionVisitor implements ExpressionVisitor<String> {

        final GenerationContext context;

        RubyExpressionVisitor(GenerationContext context) {
            this.context = context;
        }

        @Override
        public String visitLiteral(Literal literal) {
            return literal.accept(new TemplateLiteralVisitor(context));
        }

        @Override
        public String visitRef(Reference reference) {
            return RubyFormatter.toSnakeCase(reference.getName().getName().getValue());
        }

        @Override
        public String visitGetAttr(GetAttr getAttr) {
            return getAttr.getTarget().accept(this) + getAttr.getPath().stream().map(p -> {
                if (p instanceof GetAttr.Part.Index) {
                    return "[" + ((GetAttr.Part.Index) p).index() + "]";
                } else if (p instanceof GetAttr.Part.Key) {
                    return "['" + ((GetAttr.Part.Key) p).key() + "']";
                } else {
                    throw new SmithyBuildException("Unknown getAttr Part type: " + p.getClass().getName());
                }
            }).collect(Collectors.joining());
        }

        @Override
        public String visitIsSet(Expression expression) {
            return expression.accept(this) + " != nil";
        }

        @Override
        public String visitNot(Expression expression) {
            if (expression.getClass().equals(StringEquals.class)) {
                StringEquals eq = (StringEquals) expression;
                return eq.getArguments().get(0).accept(this) + " != "
                        + eq.getArguments().get(1).accept(this);
            } else if (expression.getClass().equals(BooleanEquals.class)) {
                BooleanEquals eq = (BooleanEquals) expression;
                return eq.getArguments().get(0).accept(this) + " != "
                        + eq.getArguments().get(1).accept(this);
            } else if (expression.getClass().equals(IsSet.class)) {
                IsSet isSet = (IsSet) expression;
                return isSet.getArguments().get(0).accept(this) + ".nil?";
            }

            return "!" + expression.accept(this);
        }

        @Override
        public String visitBoolEquals(Expression expression1, Expression expression2) {
            return expression1.accept(this) + " == "
                    + expression2.accept(this);
        }

        @Override
        public String visitStringEquals(Expression expression1, Expression expression2) {
            return expression1.accept(this) + " == "
                    + expression2.accept(this);
        }

        @Override
        public String visitLibraryFunction(FunctionDefinition functionDefinition, List<Expression> args) {
            FunctionBinding functionBinding = context.getFunctionBinding(functionDefinition.getId())
                    .orElseThrow(() -> new SmithyBuildException(
                            "Unable to find rules engine function binding for: " + functionDefinition.getId()));
            String rubyArgs = args.stream().map((e) -> e.accept(new RubyExpressionVisitor(context))).collect(
                    Collectors.joining(", "));
            return functionBinding.getRubyMethodName() + "(" + rubyArgs + ")";
        }
    }

    private static class TemplateLiteralVisitor implements LiteralVisitor<String> {
        final GenerationContext context;

        TemplateLiteralVisitor(GenerationContext context) {
            this.context = context;
        }

        @Override
        public String visitBoolean(boolean b) {
            return b ? "true" : "false";
        }

        @Override
        public String visitString(Template template) {
            return template.accept(new RubyTemplateVisitor(context)).collect(Collectors.joining());
        }

        @Override
        public String visitRecord(Map<Identifier, Literal> map) {
            StringBuilder ret = new StringBuilder();
            ret.append("{");
            ret.append(map.entrySet().stream()
                    .map((e) -> {
                        return e.getKey().getName().getValue() + "=>" + e.getValue().accept(this);
                    })
                    .collect(Collectors.joining(", "))
            );
            ret.append("}");
            return ret.toString();
        }

        @Override
        public String visitTuple(List<Literal> list) {
            String ret = "["
                    + list.stream()
                    .map((l) -> l.accept(this))
                    .collect(Collectors.joining(", "))
                    + "]";
            return ret;
        }

        @Override
        public String visitInteger(int i) {
            return Integer.toString(i);
        }
    }

    private static class RubyTemplateVisitor implements TemplateVisitor<String> {
        final GenerationContext context;

        RubyTemplateVisitor(GenerationContext context) {
            this.context = context;
        }

        @Override
        public String visitStaticTemplate(String s) {
            return StringUtils.escapeJavaString(s, "");
        }

        @Override
        public String visitSingleDynamicTemplate(Expression expression) {
            return expression.accept(new RubyExpressionVisitor(context));
        }

        @Override
        public String visitStaticElement(String s) {
            String escaped = StringUtils.escapeJavaString(s, "");
            return escaped.substring(1, escaped.length() - 1); // remove leading and trailing quotes
        }

        @Override
        public String visitDynamicElement(Expression expression) {
            return "#{" + expression.accept(new RubyExpressionVisitor(context)) + "}";
        }

        @Override
        public String startMultipartTemplate() {
            return "\"";
        }

        @Override
        public String finishMultipartTemplate() {
            return "\"";
        }
    }

    private static class RubyNodeVisitor implements NodeVisitor<String> {

        @Override
        public String arrayNode(ArrayNode node) {
            return "[" + node.getElements().stream()
                    .map(n -> n.accept(this))
                    .collect(Collectors.joining(", ")) + "]";
        }

        @Override
        public String booleanNode(BooleanNode node) {
            return node.getValue() ? "true" : "false";
        }

        @Override
        public String nullNode(NullNode node) {
            return "nil";
        }

        @Override
        public String numberNode(NumberNode node) {
            return node.getValue().toString();
        }

        @Override
        public String objectNode(ObjectNode node) {
            return "{" + node.getMembers().entrySet().stream().map(e -> {
                return e.getKey().accept(this) + " => " + e.getValue().accept(this);
            }).collect(Collectors.joining(", ")) + "}";
        }

        @Override
        public String stringNode(StringNode node) {
            return "'" + node.getValue() + "'";
        }
    }

    private static final class RubyEndpointsJmesPathVisitor implements
            software.amazon.smithy.jmespath.ExpressionVisitor<Pair<String, Shape>> {

        final GenerationContext context;
        final Shape input;

        RubyEndpointsJmesPathVisitor(GenerationContext context, Shape input) {
            this.context = context;
            this.input = input;
        }

        @Override
        public Pair<String, Shape> visitFunction(FunctionExpression expression) {
            if (expression.getName().equals("keys")) {
                return Pair.of(
                        expression.getArguments().get(0).accept(this).left + ".to_h.keys",
                        null);
            } else {
                throw new SmithyBuildException("Unsupported JMESPath expression");
            }
        }

        @Override
        public Pair<String, Shape> visitField(FieldExpression expression) {
            MemberShape member = input.getMember(expression.getName()).orElseThrow();
            return Pair.of(
                    "." + context.symbolProvider().toMemberName(member),
                    context.model().expectShape(member.getTarget()));
        }

        @Override
        public Pair<String, Shape> visitObjectProjection(ObjectProjectionExpression expression) {
            Pair<String, Shape> left = expression.getLeft().accept(this);
            if (left.right.isMapShape()) {
                Pair<String, Shape> right =
                        expression.getRight().accept(
                                new RubyEndpointsJmesPathVisitor(
                                        context,
                                        context.model().expectShape(
                                                left.right.asMapShape().get().getValue().getTarget())));
                return Pair.of(
                        left.left + ".values.map { |o| o" + right.left + " }.compact",
                        right.right
                );
            } else {
                throw new SmithyBuildException("ObjectProjection can be applied only to Map shapes.");
            }
        }

        @Override
        public Pair<String, Shape> visitSubexpression(Subexpression expression) {
            Pair<String, Shape> left = expression.getLeft().accept(this);
            Pair<String, Shape> right =
                    expression.getRight().accept(new RubyEndpointsJmesPathVisitor(context, left.right));
            return Pair.of(
                    left.left + right.left,
                    right.right
            );
        }


        @Override
        public Pair<String, Shape> visitProjection(ProjectionExpression expression) {
            Pair<String, Shape> left = expression.getLeft().accept(this);
            if (left.right.isListShape()) {
                Pair<String, Shape> right =
                        expression.getRight().accept(
                                new RubyEndpointsJmesPathVisitor(
                                        context,
                                        context.model().expectShape(
                                                left.right.asListShape().get().getMember().getTarget())));
                return Pair.of(
                        left.left + ".map { |o| o" + right.left + " }.compact",
                        right.right
                );
            } else {
                throw new SmithyBuildException("Projection can only be applied to List Shapes.");
            }
        }

        @Override
        public Pair<String, Shape> visitExpressionType(ExpressionTypeExpression expression) {
            return expression.getExpression().accept(this);
        }

        @Override
        public Pair<String, Shape> visitComparator(ComparatorExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitCurrentNode(CurrentExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitFlatten(FlattenExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitIndex(IndexExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitLiteral(LiteralExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitMultiSelectList(MultiSelectListExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitMultiSelectHash(MultiSelectHashExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitAnd(AndExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitOr(OrExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitNot(NotExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitFilterProjection(FilterProjectionExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

        @Override
        public Pair<String, Shape> visitSlice(SliceExpression expression) {
            throw new SmithyBuildException("Unsupported JMESPath expression");
        }

    }

    private class RubyRuleVisitor implements RuleValueVisitor<Void> {

        final RubyCodeWriter writer;

        RubyRuleVisitor(RubyCodeWriter writer) {
            this.writer = writer;
        }

        @Override
        public Void visitTreeRule(List<Rule> list) {
            renderRules(writer, list);
            return null;
        }

        @Override
        public Void visitErrorRule(Expression expression) {
            writer.write("raise ArgumentError, $L", expression.accept(new RubyExpressionVisitor(context)));
            return null;
        }

        @Override
        public Void visitEndpointRule(Endpoint endpoint) {
            String uriString = templateExpression(endpoint.getUrl());

            ExpressionVisitor<String> expressionVisitor = new RubyExpressionVisitor(context);
            if (endpoint.getHeaders().isEmpty() && endpoint.getProperties().isEmpty()) {
                writer.write("return $T.new(uri: $L)", Hearth.RULES_ENGINE_ENDPOINT, uriString);
            } else {
                String headersString = "{" + endpoint.getHeaders().entrySet().stream().map(e -> {
                    return "'" + e.getKey() + "' => [" + e.getValue().stream().map(expression -> {
                        return expression.accept(expressionVisitor);
                    }).collect(Collectors.joining(", ")) + "]";
                }).collect(Collectors.joining(", ")) + "}";

                String authSchemesString;
                Literal authSchemes = endpoint.getProperties().get(Identifier.of(AUTH_SCHEMES));
                if (authSchemes != null) {
                    List<Literal> authSchemesList = authSchemes.asTupleLiteral().get();
                    authSchemesString = "[" + authSchemesList.stream().map(l -> {
                        Map<Identifier, Literal> authSchemeMap = l.asRecordLiteral().get();
                        String name = authSchemeMap.get(NAME).accept(expressionVisitor);
                        Optional<AuthSchemeBinding> maybeAuthScheme = context.getAuthSchemeBinding(
                                name.replace("\"", ""));
                        if (!maybeAuthScheme.isPresent()) {
                            return null;
                        }
                        AuthSchemeBinding authSchemeBinding = maybeAuthScheme.get();

                        String propertiesHash = "{" + authSchemeMap.entrySet().stream()
                                .filter(e -> {
                                    String key = e.getKey().getName().getValue();
                                    return !e.getKey().equals(NAME)
                                            && authSchemeBinding.getAuthSchemeProperty(key).isPresent();
                                })
                                .map(e -> {
                                    String key = e.getKey().getName().getValue();
                                    return "'" + authSchemeBinding.getAuthSchemeProperty(key).get() + "' => "
                                            + e.getValue().accept(expressionVisitor);
                                }).collect(Collectors.joining(", ")) + "}";
                        return "Hearth::EndpointRules::AuthScheme.new(scheme_id: "
                                + StringUtils.escapeJavaString(authSchemeBinding.getSchemeId(), "")
                                + ", " + "properties: " + propertiesHash + ")";
                    }).filter(Objects::nonNull).collect(Collectors.joining(", ")) + "]";
                } else {
                    authSchemesString = "[]";
                }

                writer
                        .openBlock("return $T.new(", Hearth.RULES_ENGINE_ENDPOINT)
                        .write("uri: $L,", uriString)
                        .write("headers: $L,", headersString)
                        .write("auth_schemes: $L", authSchemesString)
                        .closeBlock(")");

            }
            return null;
        }
    }
}
