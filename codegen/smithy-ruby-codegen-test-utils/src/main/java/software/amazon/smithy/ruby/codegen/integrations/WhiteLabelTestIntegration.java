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

import java.util.List;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyIntegration;
import software.amazon.smithy.ruby.codegen.RubyRuntimePlugin;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public class WhiteLabelTestIntegration implements RubyIntegration {

    @Override
    public boolean includeFor(ServiceShape service, Model model) {
        return service.toShapeId().getName().equals("WhiteLabel");
    }

    @Override
    public List<RubyRuntimePlugin> getRuntimePlugins(GenerationContext context) {
        return List.of(RubyRuntimePlugin.builder()
                .rubySource("smithy-ruby-codegen-test-utils/plugins/test_plugin.rb")
                .pluginClass("Plugins::TestPlugin")
                .build());
    }

    @Override
    public void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context) {
        Middleware testMiddleware = Middleware.builder()
                .klass("Middleware::TestMiddleware")
                .addConfig(ClientConfig.builder()
                        .name("test_config")
                        .type("String")
                        .documentation("A Test Config")
                        .defaultPrimitiveValue("'default'")
                        .build())
                .step(MiddlewareStackStep.INITIALIZE)
                .rubySource("smithy-ruby-codegen-test-utils/middleware/test_middleware.rb")
                .build();
        Middleware beforeMiddleware = Middleware.builder()
                .klass("Middleware::BeforeMiddleware")
                .step(MiddlewareStackStep.BUILD)
                .relative(Middleware.Relative.builder()
                        .before("Middleware::MidMiddleware")
                        .build())
                .rubySource("smithy-ruby-codegen-test-utils/middleware/test_middleware.rb")
                .build();
        Middleware midMiddleware = Middleware.builder()
                .addConfig(ClientConfig.builder()
                        .name("verify_in_mid")
                        .type("Proc")
                        .build())
                .klass("Middleware::MidMiddleware")
                .step(MiddlewareStackStep.BUILD)
                .relative(Middleware.Relative.builder()
                        .before("Middleware:OptionalMiddleware")
                        .optional()
                        .build())
                .rubySource("smithy-ruby-codegen-test-utils/middleware/test_middleware.rb")
                .build();
        Middleware afterMiddleware = Middleware.builder()
                .addConfig(ClientConfig.builder()
                        .name("verify_in_after")
                        .type("Proc")
                        .build())
                .klass("Middleware::AfterMiddleware")
                .step(MiddlewareStackStep.BUILD)
                .relative(Middleware.Relative.builder()
                        .after("Middleware::MidMiddleware")
                        .build())
                .rubySource("smithy-ruby-codegen-test-utils/middleware/test_middleware.rb")
                .build();

        middlewareBuilder.register(testMiddleware);
        middlewareBuilder.register(afterMiddleware);
        middlewareBuilder.register(beforeMiddleware);
        middlewareBuilder.register(midMiddleware);
    }

}
