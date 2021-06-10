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

package software.amazon.smithy.ruby.codegen;

import java.util.Optional;
import software.amazon.smithy.model.shapes.Shape;

public final class CodegenUtils {
    private static final String SYNTHETIC_NAMESPACE = "smithy.ruby.synthetic";

    private CodegenUtils() {

    }

    /**
     * Get the namespace where synthetic types are generated at runtime.
     *
     * @return synthetic type namespace
     */
    public static String getSyntheticTypeNamespace() {
        return CodegenUtils.SYNTHETIC_NAMESPACE;
    }

    /**
     * Get if the passed in shape is decorated as a synthetic clone, but there is no other shape the clone is
     * created from.
     *
     * @param shape the shape to check if its a stubbed synthetic clone without an archetype.
     * @return if the shape is synthetic clone, but not based on a specific shape.
     */
    public static boolean isStubSyntheticClone(Shape shape) {
        Optional<SyntheticClone> optional =
                shape.getTrait(SyntheticClone.class);
        if (!optional.isPresent()) {
            return false;
        }

        SyntheticClone synthClone = optional.get();
        return !synthClone.getArchetype().isPresent();
    }
}
