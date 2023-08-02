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
import software.amazon.smithy.ruby.codegen.ClientFragment;

public interface ConfigProvider {

    /**
     * Config defaults may depend on other config (eg a logger that uses log_level).
     * The ClientFragment can be used to express these dependencies.
     *
     * @return the provider rendered into Ruby code
     */
    ClientFragment providerFragment();

    /**
     * @return an optional default value to use in documentation.
     */
    default Optional<String> getDocumentationDefault() {
        return Optional.empty();
    }
}
