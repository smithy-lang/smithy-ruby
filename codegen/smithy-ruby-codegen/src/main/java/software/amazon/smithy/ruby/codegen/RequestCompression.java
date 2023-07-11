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

package software.amazon.smithy.ruby.codegen;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.RequestCompressionTrait;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.ConfigProviderChain;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public class RequestCompression implements RubyIntegration {
    @Override
    public boolean includeFor(ServiceShape service, Model model) {
        return model.isTraitApplied(RequestCompressionTrait.class);
    }

    @Override
    public void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context) {
        ClientConfig disableRequestCompression = (new ClientConfig.Builder())
                .name("disable_request_compression")
                .type("Boolean")
                .defaultValue("false")
                .documentation("When set to 'true' the request body will not be compressed for supported operations.")
                .allowOperationOverride()
                .defaults(new ConfigProviderChain.Builder()
                        .envProvider("DISABLE_REQUEST_COMPRESSION", "Boolean")
                        .staticProvider("false")
                        .build())
                .build();

        String minCompressionDocumentation = """
                The minimum size bytes that triggers compression for request bodies.
                The value must be non-negative integer value between 0 and 10485780 bytes inclusive.
                """;

        ClientConfig requestMinCompressionSizeBytes = (new ClientConfig.Builder())
                .name("request_min_compression_size_bytes")
                .type("Integer")
                .defaultValue("10240")
                .documentation(minCompressionDocumentation)
                .allowOperationOverride()
                .defaults(new ConfigProviderChain.Builder()
                        .envProvider("REQUEST_MIN_COMPRESSION_SIZE_BYTES", "Integer")
                        .staticProvider("10240")
                        .build())
                .build();

        Middleware compression = (new Middleware.Builder())
                .operationPredicate(((model, service, operation) -> operation.hasTrait(RequestCompressionTrait.class)))
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    RequestCompressionTrait requestCompression = operation.expectTrait(RequestCompressionTrait.class);
                    Shape inputShape = ctx.model().expectShape(operation.getInputShape());

                    // need a better way to check if 'encodings' is present
                    // what is the behavior we want if the list is empty?
                    if (!requestCompression.getEncodings().isEmpty()) {
                        params.put("encodings", "[" + requestCompression
                                .getEncodings()
                                .stream()
                                .map((s) -> "'" + s + "'")
                                .collect(Collectors.joining(", ")) + "]");
                    }
                    if (Streaming.isStreaming(ctx.model(), inputShape)) {
                        params.put("streaming", "true");
                    }
                    return params;
                })
                .addConfig(disableRequestCompression)
                .addConfig(requestMinCompressionSizeBytes)
                .klass("Hearth::Middleware::RequestCompression")
                .step(MiddlewareStackStep.BUILD)
                .relative(new Middleware.Relative(Middleware.Relative.Type.BEFORE,
                        "Hearth::HTTP::Middleware::ContentMD5"))
                .build();
        middlewareBuilder.register(compression);
    }
}
