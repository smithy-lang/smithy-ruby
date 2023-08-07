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

public class RangeConstraint implements ConfigConstraint {

    private final long minValue;
    private final long maxValue;

    public RangeConstraint(long minValue, long maxValue) {
        this.maxValue = maxValue;
        this.minValue = minValue;
    }

    @Override
    public String render(String configName) {
        return String.format(
                "Hearth::Validator.validate_range!(%s, min: %d, max: %d, context: 'config[:%s]')",
                configName, minValue, maxValue, configName);
    }

}
