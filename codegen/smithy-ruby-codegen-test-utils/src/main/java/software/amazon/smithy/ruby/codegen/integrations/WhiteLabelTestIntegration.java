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

package software.amazon.smithy.ruby.codegen.integrations;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.traits.HttpBasicAuthTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyIntegration;
import software.amazon.smithy.ruby.codegen.RubyRuntimePlugin;
import software.amazon.smithy.ruby.codegen.auth.AuthParam;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.TypeConstraint;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.traits.HttpCustomAuthTrait;

public class WhiteLabelTestIntegration implements RubyIntegration {

    @Override
    public boolean includeFor(ServiceShape service, Model model) {
        return service.toShapeId().getName().equals("WhiteLabel");
    }

    @Override
    public List<RubyRuntimePlugin> getRuntimePlugins(GenerationContext context) {
        return List.of(RubyRuntimePlugin.builder()
                .rubySource("plugins/test_plugin.rb")
                .pluginClass("Plugins::TestPlugin")
                .build());
    }

    @Override
    public void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context) {
        Middleware testMiddleware = Middleware.builder()
                .klass("Middleware::TestMiddleware")
                .addConfig(ClientConfig.builder()
                        .name("test_config")
                        .documentation("A Test Config")
                        .documentationType("String")
                        .defaultValue("'default'")
                        .constraint(new TypeConstraint("String"))
                        .build())
                .step(MiddlewareStackStep.INITIALIZE)
                .rubySource("middleware/test_middleware.rb")
                .build();
        Middleware beforeMiddleware = Middleware.builder()
                .appliesOnlyToOperations("RelativeMiddlewareOperation")
                .klass("Middleware::BeforeMiddleware")
                .step(MiddlewareStackStep.BUILD)
                .relative(Middleware.Relative.builder()
                        .before("Middleware::MidMiddleware")
                        .build())
                .rubySource("middleware/relative_middleware.rb")
                .build();
        Middleware midMiddleware = Middleware.builder()
                .appliesOnlyToOperations("RelativeMiddlewareOperation")
                .klass("Middleware::MidMiddleware")
                .step(MiddlewareStackStep.BUILD)
                .relative(Middleware.Relative.builder()
                        .before("Middleware:OptionalMiddleware")
                        .optional()
                        .build())
                .rubySource("middleware/relative_middleware.rb")
                .build();
        Middleware afterMiddleware = Middleware.builder()
                .appliesOnlyToOperations("RelativeMiddlewareOperation")
                .klass("Middleware::AfterMiddleware")
                .step(MiddlewareStackStep.BUILD)
                .relative(Middleware.Relative.builder()
                        .after("Middleware::MidMiddleware")
                        .build())
                .rubySource("middleware/relative_middleware.rb")
                .build();

        middlewareBuilder.register(testMiddleware);
        middlewareBuilder.register(afterMiddleware);
        middlewareBuilder.register(beforeMiddleware);
        middlewareBuilder.register(midMiddleware);
    }

    @Override
    public List<AuthScheme> getAdditionalAuthSchemes(GenerationContext context) {
        String identityProviderDocumentation = """
                A %s that returns a %s for operations modeled with the %s auth scheme.
                """;

        String defaultIdentity = "Auth::HTTPCustomKey.new(key: 'key')";
        String defaultConfigValue = "cfg[:stub_responses] ? %s.new(proc { %s }) : nil"
                .formatted(Hearth.IDENTITY_PROVIDER, defaultIdentity);
        String identityType = "Auth::HTTPCustomKey";

        ClientConfig identityProviderConfig = ClientConfig.builder()
                .name("http_custom_key_provider")
                .documentation(
                        identityProviderDocumentation.formatted(
                                Hearth.IDENTITY_PROVIDER,
                                identityType,
                                HttpBasicAuthTrait.ID))
                .documentationType(Hearth.IDENTITY_PROVIDER.toString())
                .defaultDynamicValue(defaultConfigValue)
                .constraint(new TypeConstraint(Hearth.IDENTITY_PROVIDER.toString()))
                .build();

        AuthScheme authScheme = AuthScheme.builder()
                .shapeId(HttpCustomAuthTrait.ID)
                .rubyAuthScheme("HTTPCustomAuthScheme.new")
                .rubyIdentityType(identityType)
                .identityProviderConfig(identityProviderConfig)
                .additionalAuthParam(AuthParam.builder()
                        .name("custom_param")
                        .paramValue("'custom_value'")
                        .rbsType("::String")
                        .build())
                .rubySource("auth/http_custom_auth.rb")
                .extractSignerProperties((trait) -> {
                    Map<String, String> properties = new HashMap<>();
                    String modelValue = "'%s'".formatted(((HttpCustomAuthTrait) trait).getSignerProperty());
                    properties.put("model_value", modelValue);
                    return properties;
                })
                .putSignerProperty("static_value", "'static'")
                .extractIdentityProperties((trait) -> {
                    Map<String, String> properties = new HashMap<>();
                    String modelValue = "'%s'".formatted(((HttpCustomAuthTrait) trait).getIdentityProperty());
                    properties.put("model_value", modelValue);
                    return properties;
                })
                .putIdentityProperty("static_value", "'static'")
                .build();

        return List.of(authScheme);
    }
}
