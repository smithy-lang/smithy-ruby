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

package software.amazon.smithy.ruby.codegen.auth.factories;

import software.amazon.smithy.model.traits.HttpBasicAuthTrait;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;

public final class HttpBasicAuthSchemeFactory {
    private HttpBasicAuthSchemeFactory() {
    }

    public static AuthScheme build() {
        String identityProviderDocumentation = """
                A %s that returns a %s for operations modeled to use it.
                """;

        String defaultIdentity = Hearth.IDENTITIES
                + "::HTTPLogin.new(username: 'stubbed username', password: 'stubbed password')";
        String defaultConfigValue = "cfg[:stub_responses] ? %s.new(proc { %s }) : nil"
                .formatted(Hearth.IDENTITY_PROVIDER, defaultIdentity);
        String identityType = Hearth.IDENTITIES + "::HTTPLogin";

        ClientConfig identityProviderConfig = ClientConfig.builder()
                .name("http_login_identity_resolver")
                .documentation(
                        identityProviderDocumentation.formatted(
                                Hearth.IDENTITY_PROVIDER,
                                identityType))
                .documentationRbsAndValidationType(Hearth.IDENTITY_PROVIDER.toString())
                .defaultDynamicValue(defaultConfigValue)
                .build();

        return AuthScheme.builder()
                .shapeId(HttpBasicAuthTrait.ID)
                .rubyAuthScheme(Hearth.AUTH_SCHEMES + "::HTTPBasic.new")
                .rubyIdentityType(identityType)
                .identityProviderConfig(identityProviderConfig)
                .build();
    }
}
