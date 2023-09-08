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

import java.util.List;

@FunctionalInterface
/**
 * Called to write out additional files.
 */
public interface WriteAdditionalFiles {
    /**
     * Called to write out additional files needed by a generator.
     *
     * @param context GenerationContext - allows access to file manifest and symbol providers
     * @return List of the relative paths of files written.
     */
    List<String> writeAdditionalFiles(GenerationContext context);
}
