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

import java.util.HashMap;
import java.util.Map;
import software.amazon.smithy.model.traits.HttpApiKeyAuthTrait;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;

public final class HttpApiKeyAuthSchemeFactory {
    private HttpApiKeyAuthSchemeFactory() {
    }

    public static AuthScheme build() {
        String identityProviderDocumentation = """
                A %s that returns a %s for operations modeled with the %s auth scheme.
                """;

        String defaultIdentity = Hearth.IDENTITIES + "::HTTPApiKey.new(key: 'stubbed api key')";
        String defaultConfigValue = "cfg[:stub_responses] ? %s.new(proc { %s }) : nil"
                .formatted(Hearth.IDENTITY_PROVIDER, defaultIdentity);
        String identityType = Hearth.IDENTITIES + "::HTTPApiKey";

        ClientConfig identityProviderConfig = ClientConfig.builder()
                .name("http_api_key_provider")
                .documentation(
                        identityProviderDocumentation.formatted(
                                Hearth.IDENTITY_PROVIDER,
                                identityType,
                                HttpApiKeyAuthTrait.ID))
                .documentationRbsAndValidationType(Hearth.IDENTITY_PROVIDER.toString())
                .defaultDynamicValue(defaultConfigValue)
                .build();

        return AuthScheme.builder()
                .shapeId(HttpApiKeyAuthTrait.ID)
                .rubyAuthScheme(Hearth.AUTH_SCHEMES + "::HTTPApiKey.new")
                .rubyIdentityType(identityType)
                .identityProviderConfig(identityProviderConfig)
                .extractSignerProperties((trait) -> {
                    Map<String, String> properties = new HashMap<>();
                    properties.put("in", "'%s'".formatted(((HttpApiKeyAuthTrait) trait).getIn().toString()));
                    properties.put("name", "'%s'".formatted(((HttpApiKeyAuthTrait) trait).getName()));
                    if (((HttpApiKeyAuthTrait) trait).getScheme().isPresent()) {
                        properties.put("scheme", "'%s'".formatted(((HttpApiKeyAuthTrait) trait).getScheme().get()));
                    }
                    return properties;
                })
                .build();
    }
}
