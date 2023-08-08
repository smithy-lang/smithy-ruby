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
 * Type Constraint for config value.
 */
public class TypeConstraint implements ConfigConstraint {

    private final String type;

    /**
     * @param type ruby type for the config. Used for validation, must be a valid Ruby class.
     */
    public TypeConstraint(String type) {
        if (type.equals("Boolean")) {
            this.type = "TrueClass, FalseClass";
        } else {
            this.type = type;
        }
    }

    @Override
    public String render(String configName) {
        return String.format(
                "Hearth::Validator.validate_type!(%s, %s, context: 'config[:%s]')",
                configName, type, configName);
    }
}
