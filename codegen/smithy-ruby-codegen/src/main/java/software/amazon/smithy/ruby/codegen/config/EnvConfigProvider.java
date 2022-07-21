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

import software.amazon.smithy.ruby.codegen.ClientFragment;

/**
 * ConfigProvider for extracting values from the ENV.
 */
public class EnvConfigProvider implements ConfigProvider {
    private final ClientFragment providerFragment;

    /**
     * @param environmentKey the name of the ENV variable
     * @param type           rubyType to coerce the value to
     */
    public EnvConfigProvider(String environmentKey, String type) {
        providerFragment = new ClientFragment.Builder()
                .render("Hearth::Config::EnvProvider.new('" + environmentKey + "', type: '" + type + "')")
                .build();
    }

    @Override
    public ClientFragment providerFragment() {
        return providerFragment;
    }
}
