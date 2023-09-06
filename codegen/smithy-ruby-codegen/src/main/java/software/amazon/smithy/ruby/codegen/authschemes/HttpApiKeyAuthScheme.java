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

package software.amazon.smithy.ruby.codegen.authschemes;

import java.util.ArrayList;
import java.util.List;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.HttpApiKeyAuthTrait;
import software.amazon.smithy.ruby.codegen.Hearth;

public class HttpApiKeyAuthScheme implements AuthScheme {
    public ShapeId getShapeId() {
        return HttpApiKeyAuthTrait.ID;
    }

    public String rubyAuthScheme() {
        return Hearth.AUTH_SCHEMES + "::HTTPApiKey.new";
    }

    public String rubyIdentityClass() {
        return Hearth.IDENTITIES + "::HTTPApiKey";
    }

    public String rubyIdentityResolverConfigName() {
        return "http_api_key_identity_resolver";
    }

    public String rubyStubbedIdentity() {
        return Hearth.IDENTITIES + "::HTTPApiKey.new(key: 'stubbed api key')";
    }

    public List<String> additionalAuthParams() {
        return new ArrayList<>();
    }
}
