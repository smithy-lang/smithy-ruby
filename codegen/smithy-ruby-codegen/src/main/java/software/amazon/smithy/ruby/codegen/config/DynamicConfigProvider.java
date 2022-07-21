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
 * Config provider for dynamically getting config values from arbitrary ruby code blocks.
 */
public class DynamicConfigProvider implements ConfigProvider {

    private final ClientFragment providerFragment;

    /**
     * @param rubyDefaultBlock ruby code block to provide the config value
     */
    public DynamicConfigProvider(String rubyDefaultBlock) {
        providerFragment = new ClientFragment.Builder().render(rubyDefaultBlock).build();
    }

    /**
     * @param providerFragment fragment to provide the config value
     */
    public DynamicConfigProvider(ClientFragment providerFragment) {
        this.providerFragment = providerFragment;
    }

    @Override
    public ClientFragment providerFragment() {
        return providerFragment;
    }
}
