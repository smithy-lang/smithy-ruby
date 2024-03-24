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

import java.util.List;
import java.util.stream.Collectors;
import software.amazon.smithy.ruby.codegen.RubyFormatter;

/**
 * Responds To Method Constraint for config value.
 */
public class RespondsToConstraint implements ConfigConstraint {

    private final List<String> methods;

    /**
     * @param methods the methods that the config value should respond to
     */
    public RespondsToConstraint(List<String> methods) {
        this.methods = methods;
    }

    @Override
    public String render(String configName) {
        String methodsString = methods.stream()
                .map(method -> RubyFormatter.asSymbol(method)).collect(Collectors.joining(", "));
        return String.format(
                "Hearth::Validator.validate_responds_to!(%s, %s, context: 'config[:%s]')",
                configName, methodsString, configName);
    }
}
