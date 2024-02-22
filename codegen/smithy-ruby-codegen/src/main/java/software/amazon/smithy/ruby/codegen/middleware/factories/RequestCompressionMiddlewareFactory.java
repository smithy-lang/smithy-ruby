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
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.RequestCompressionTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.RangeConstraint;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public final class RequestCompressionMiddlewareFactory {
    private RequestCompressionMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        String disableRequestCompressionDocumentation = """
                When set to 'true' the request body will not be compressed for supported operations.
                """;

        ClientConfig disableRequestCompression = ClientConfig.builder()
                .name("disable_request_compression")
                .type("Boolean")
                .rbsType("bool")
                .defaultValue("false")
                .documentation(disableRequestCompressionDocumentation)
                .build();

        String minCompressionDocumentation = """
                The minimum size bytes that triggers compression for request bodies.
                The value must be non-negative integer value between 0 and 10485780 bytes inclusive.
                """;

        ClientConfig requestMinCompressionSizeBytes = ClientConfig.builder()
                .name("request_min_compression_size_bytes")
                .type("Integer")
                .documentation(minCompressionDocumentation)
                .defaultValue("10240")
                .constraint(new RangeConstraint(0, 10485760))
                .build();

        Middleware.Relative compressionRelative = Middleware.Relative.builder()
                .before("Hearth::HTTP::Middleware::ContentMD5")
                .optional()
                .build();

        Middleware.Builder compressionBuilder = Middleware.builder()
                .klass("Hearth::HTTP::Middleware::RequestCompression")
                .step(MiddlewareStackStep.AFTER_BUILD)
                .relative(compressionRelative)
                .operationPredicate(
                        ((model, service, operation) -> operation.hasTrait(RequestCompressionTrait.class)))
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    RequestCompressionTrait requestCompression =
                            operation.expectTrait(RequestCompressionTrait.class);
                    Shape inputShape = ctx.model().expectShape(operation.getInputShape());
                    params.put("encodings", "[" + requestCompression
                            .getEncodings()
                            .stream()
                            .map((s) -> "'" + s + "'")
                            .collect(Collectors.joining(", ")) + "]");
                    params.put("streaming",
                            Streaming.isStreaming(ctx.model(), inputShape) ? "true" : "false");
                    return params;
                });

        TopDownIndex topDownIndex = TopDownIndex.of(context.model());
        Set<OperationShape> containedOperations = topDownIndex.getContainedOperations(context.service());
        boolean hasCompressionTrait =
                containedOperations.stream().anyMatch((o) -> o.hasTrait(RequestCompressionTrait.class));
        if (hasCompressionTrait) {
            compressionBuilder.addConfig(disableRequestCompression);
            compressionBuilder.addConfig(requestMinCompressionSizeBytes);
        }

        return compressionBuilder.build();
    }
}
