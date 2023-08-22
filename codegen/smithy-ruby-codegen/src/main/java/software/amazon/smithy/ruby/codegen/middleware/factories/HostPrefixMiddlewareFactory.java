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

package software.amazon.smithy.ruby.codegen.middleware.factories;

import java.util.HashMap;
import java.util.Map;
import software.amazon.smithy.model.pattern.SmithyPattern;
import software.amazon.smithy.model.traits.EndpointTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class HostPrefixMiddlewareFactory {
    private HostPrefixMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        String hostPrefixDocumentation = """
                When `true`, does not perform host prefix injection using @endpoint trait's hostPrefix property.
                """;
        ClientConfig disableHostPrefix = ClientConfig.builder()
                .name("disable_host_prefix")
                .type("Boolean")
                .defaultPrimitiveValue("false")
                .documentation(hostPrefixDocumentation)
                .build();

        Middleware.Relative buildRelative = Middleware.Relative.builder()
                .type(Middleware.Relative.Type.BEFORE)
                .to(Hearth.BUILD_MIDDLEWARE)
                .build();

        return Middleware.builder()
                .klass("Hearth::Middleware::HostPrefix")
                .step(MiddlewareStackStep.BUILD)
                .relative(buildRelative)
                .addConfig(disableHostPrefix)
                .operationPredicate((model, service, operation) -> operation.hasTrait(EndpointTrait.class))
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    SmithyPattern pattern = operation.getTrait(EndpointTrait.class).get().getHostPrefix();
                    StringBuffer prefix = new StringBuffer();
                    for (SmithyPattern.Segment segment : pattern.getSegments()) {
                        if (segment.isLabel()) {
                            // Here, we rebuild the smithy pattern with reserved word support.
                            // Otherwise we could use pattern.toString()
                            String label = RubySymbolProvider.toMemberName(segment.getContent());
                            prefix.append("{" + label + "}");
                        } else {
                            prefix.append(segment);
                        }
                    }
                    params.put("host_prefix", "\"" + prefix + "\"");
                    return params;
                })
                .build();
    }
}
