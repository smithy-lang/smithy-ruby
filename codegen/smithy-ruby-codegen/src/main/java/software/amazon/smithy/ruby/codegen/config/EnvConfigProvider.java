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

public class EnvConfigProvider implements ConfigProvider {
    private final String environmentKey;
    private final String type;

    public EnvConfigProvider(String environmentKey, String type) {
        this.environmentKey = environmentKey;
        this.type = type;
    }

    @Override
    public String render() {
        return "Hearth::Config::EnvProvider.new(" + environmentKey + ", type: '" + type + "')";
    }
}
