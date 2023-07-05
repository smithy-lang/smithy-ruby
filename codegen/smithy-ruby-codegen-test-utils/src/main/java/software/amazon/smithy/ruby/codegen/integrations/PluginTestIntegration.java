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
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyRuntimePlugin;
import software.amazon.smithy.ruby.codegen.RubyServiceIntegration;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public class PluginTestIntegration extends RubyServiceIntegration {

    @Override
    public String name() {
        return "plugin-test";
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
        middlewareBuilder.register(Middleware.builder()
                .klass("Middleware::TestMiddleware")
                .addConfig(ClientConfig.builder()
                        .name("test_config")
                        .type("String")
                        .documentation("A Test Config")
                        .defaultPrimitiveValue("'default'")
                        .build())
                .step(MiddlewareStackStep.INITIALIZE)
                .rubySource("smithy-ruby-codegen-test-utils/middleware/test_middleware.rb")
                .build());
    }

}
