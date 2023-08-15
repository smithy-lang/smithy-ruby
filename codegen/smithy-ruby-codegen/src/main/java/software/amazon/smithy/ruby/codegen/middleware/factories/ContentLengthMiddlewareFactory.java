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

import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public final class ContentLengthMiddlewareFactory {
    private ContentLengthMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        return Middleware.builder()
                .klass("Hearth::HTTP::Middleware::ContentLength")
                .operationPredicate(
                        (model, service, operation) ->
                                !Streaming.isNonFiniteStreaming(
                                        model, model.expectShape(operation.getInputShape(), StructureShape.class))
                )
                .step(MiddlewareStackStep.AFTER_BUILD)
                .build();
    }
}
