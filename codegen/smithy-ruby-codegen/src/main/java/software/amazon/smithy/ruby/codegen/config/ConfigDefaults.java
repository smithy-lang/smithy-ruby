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

package software.amazon.smithy.ruby.codegen.config;

import java.util.Optional;
import java.util.Set;
import software.amazon.smithy.ruby.codegen.GenerationContext;

/**
 * Represents the default values for a ClientConfig.
 */
public interface ConfigDefaults {
    /**
     * Render the defaults for this config value.
     *
     * @param context generation context
     * @return rendered default.  Must be an array of defaults (callable/literals)
     */
    String renderDefault(GenerationContext context);

    /**
     * @return a string if there should be documentation for the default.
     */
    Optional<String> getDocumentationDefault();

    /**
     * @param documentationDefault default value to add to documentation.
     */
    void setDocumentationDefault(String documentationDefault);

    /**
     * Add any dependent ClientConfig to the collection.ConfigDefaults may depend on other ClientConfig.
     *
     * @param configCollection collection to add dependent config to.
     */
    void addToConfigCollection(Set<ClientConfig> configCollection);
}
