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

import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.utils.SmithyUnstableApi;

@FunctionalInterface
@SmithyUnstableApi
public interface OperationPredicate {
    /**
     * Tests this should be applied to an individual operation.
     *
     * @param model     Model the operation belongs to.
     * @param service   Service the operation belongs to.
     * @param operation Operation to test.
     * @return Returns true if middleware should be applied to the operation.
     */
    boolean test(Model model, ServiceShape service, OperationShape operation);
}
