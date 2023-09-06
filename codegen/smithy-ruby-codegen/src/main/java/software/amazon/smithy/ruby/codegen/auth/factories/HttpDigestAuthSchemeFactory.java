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

import software.amazon.smithy.model.traits.HttpDigestAuthTrait;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;

public final class HttpDigestAuthSchemeFactory {
    private HttpDigestAuthSchemeFactory() {
    }

    public static AuthScheme build() {
        String defaultIdentity = Hearth.IDENTITIES
                + "::HTTPLogin.new(username: 'stubbed username', password: 'stubbed password')";
        String defaultConfigValue = "proc { |cfg| cfg[:stub_responses] ? %s.new(proc { %s }) : nil }"
                .formatted(Hearth.IDENTITY_RESOLVER, defaultIdentity);

        return AuthScheme.builder()
                .shapeId(HttpDigestAuthTrait.ID)
                .rubyAuthScheme(Hearth.AUTH_SCHEMES + "::HTTPDigest.new")
                .rubyIdentityClass(Hearth.IDENTITIES + "::HTTPLogin")
                .rubyIdentityResolverConfigName("http_login_identity_resolver")
                .rubyIdentityResolverConfigDefaultValue(defaultConfigValue)
                .build();
    }
}
