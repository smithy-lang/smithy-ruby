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

/**
 * Represents the config value constraints for ClientConfig.
 */

public interface ConfigConstraint {
    /**
     *  Render the constraint validator for the config value.
     *
     * @param configName the name of the config.
     * @return the string to be rendered into Ruby code.
     */
    String render(String configName);
}
