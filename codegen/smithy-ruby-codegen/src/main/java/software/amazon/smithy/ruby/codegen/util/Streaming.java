/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

package software.amazon.smithy.ruby.codegen.util;

import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.RequiresLengthTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Utility methods related to Streaming.
 */
@SmithyInternalApi
public final class Streaming {
    private Streaming() {
    }

    public static boolean isEventStreaming(Model model, OperationShape operationShape) {
        StructureShape input = model.expectShape(operationShape.getInputShape(), StructureShape.class);
        StructureShape output = model.expectShape(operationShape.getOutputShape(), StructureShape.class);
        return isEventStreaming(model, input) || isEventStreaming(model, output);
    }

    public static boolean isEventStreaming(Model model, Shape inputOrOutput) {
        return inputOrOutput.members()
                .stream()
                .anyMatch((m) ->
                        m.getMemberTrait(model, StreamingTrait.class).isPresent()
                                && model.expectShape(m.getTarget()).isUnionShape());
    }

    public static boolean isStreaming(Model model, Shape inputOrOutput) {
        return inputOrOutput.members()
                .stream()
                .anyMatch((m) ->
                        m.getMemberTrait(model, StreamingTrait.class).isPresent());
    }

    public static boolean isNonFiniteStreaming(Model model, Shape inputOrOutput) {
        return inputOrOutput.members()
                .stream()
                .anyMatch((m) ->
                        m.getMemberTrait(model, StreamingTrait.class).isPresent()
                                && !m.getMemberTrait(model, RequiresLengthTrait.class).isPresent());
    }
}
