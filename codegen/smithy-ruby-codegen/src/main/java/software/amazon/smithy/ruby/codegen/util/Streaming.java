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

package software.amazon.smithy.ruby.codegen.util;

import java.util.Optional;
import java.util.Set;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.MemberShape;
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

    /**
     * @param model model to test
     * @param operations operation to test. can be accessed from directive.operations().
     * @return returns true if any operation uses event streaming.
     */
    public static boolean hasEventStreams(Model model, Set<OperationShape> operations) {
        return operations.stream().anyMatch(o -> isEventStreaming(model, o));
    }

    /**
     * @param model model to test
     * @param operationShape operation to test
     * @return returns true if either the input or output is event streaming.
     */
    public static boolean isEventStreaming(Model model, OperationShape operationShape) {
        StructureShape input = model.expectShape(operationShape.getInputShape(), StructureShape.class);
        StructureShape output = model.expectShape(operationShape.getOutputShape(), StructureShape.class);
        return isEventStreaming(model, input) || isEventStreaming(model, output);
    }

    /**
     * @param model model to test
     * @param inputOrOutput input/output shape to test
     * @return true if the input/output is event streaming.
     */
    public static boolean isEventStreaming(Model model, Shape inputOrOutput) {
        return inputOrOutput.members()
                .stream()
                .anyMatch((m) -> StreamingTrait.isEventStream(model, m));
    }

    /**
     * Returns the event stream member.
     * @param model model to use
     * @param shape shape to return member from
     * @return the event stream's member shape (if any).
     */
    public static Optional<MemberShape> getEventStreamMember(Model model, Shape shape) {
        return shape.members()
                .stream()
                .filter(m -> StreamingTrait.isEventStream(model, m))
                .findFirst();
    }

    /**
     * @param model model to test
     * @param inputOrOutput input/output shape to test
     * @return true if the input/output is streaming.
     */
    public static boolean isStreaming(Model model, Shape inputOrOutput) {
        return inputOrOutput.members()
                .stream()
                .anyMatch((m) ->
                        m.getMemberTrait(model, StreamingTrait.class).isPresent());
    }

    /**
     * @param model model to test
     * @param inputOrOutput input or output shape to test.
     * @return returns true if the input/output is streaming and requires length
     */
    public static boolean isNonFiniteStreaming(Model model, Shape inputOrOutput) {
        return inputOrOutput.members()
                .stream()
                .anyMatch((m) ->
                        m.getMemberTrait(model, StreamingTrait.class).isPresent()
                                && !m.getMemberTrait(model, RequiresLengthTrait.class).isPresent());
    }
}
