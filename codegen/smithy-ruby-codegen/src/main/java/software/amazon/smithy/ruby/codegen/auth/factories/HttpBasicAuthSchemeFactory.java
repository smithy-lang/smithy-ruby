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

    public static final ClientConfig HTTP_LOGIN_PROVIDER = ClientConfig.builder()
            .name("http_login_provider")
            .documentation("A Hearth::IdentityProvider that returns a "
                    + "Hearth::Identities::HTTPLogin for operations modeled to use it.")
            .documentationRbsAndValidationType(Hearth.IDENTITY_PROVIDER.toString())
            .defaultDynamicValue(
                    "cfg[:stub_responses] ? %s.new(proc { %s }) : nil".formatted(
                            Hearth.IDENTITY_PROVIDER,
                            "Hearth::Identities::HTTPLogin.new(username: 'stubbed username', "
                                    + "password: 'stubbed password')"
                    ))
            .build();

    private HttpBasicAuthSchemeFactory() {
    }

    public static AuthScheme build() {
        return AuthScheme.builder()
                .shapeId(HttpBasicAuthTrait.ID)
                .rubyAuthScheme(Hearth.AUTH_SCHEMES + "::HTTPBasic.new")
                .rubyIdentityType(Hearth.IDENTITIES + "::HTTPLogin")
                .identityProviderConfig(HttpBasicAuthSchemeFactory.HTTP_LOGIN_PROVIDER)
                .build();
    }
}
