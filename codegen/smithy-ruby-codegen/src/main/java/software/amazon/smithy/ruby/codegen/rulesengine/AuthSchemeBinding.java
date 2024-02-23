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

package software.amazon.smithy.ruby.codegen.rulesengine;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.HttpBearerAuthTrait;
import software.amazon.smithy.utils.SmithyBuilder;

/**
 * Provides a binding between Smithy rules engine auth schemes and Ruby.
 */
public final class AuthSchemeBinding {
    private final String schemeId;
    private final String endpointAuthName;
    private final Map<String, String> propertyMap;

    private AuthSchemeBinding(Builder builder) {
        this.schemeId = builder.schemeId;
        this.endpointAuthName = builder.endpointAuthName;
        this.propertyMap = builder.propertyMap;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static List<AuthSchemeBinding> standardAuthSchemes() {
        return List.of(
                AuthSchemeBinding.builder()
                        .schemeId(HttpBearerAuthTrait.ID)
                        .endpointAuthName("bearer")
                        .build()
        );
    }

    public String getSchemeId() {
        return schemeId;
    }

    public String getEndpointAuthName() {
        return endpointAuthName;
    }

    public Optional<String> getAuthSchemeProperty(String endpointProperty) {
        return Optional.ofNullable(propertyMap.get(endpointProperty));
    }

    public Map<String, String> getPropertyMap() {
        return Map.copyOf(propertyMap);
    }

    /**
     * Builder for {@link AuthSchemeBinding}.
     */
    public static class Builder implements SmithyBuilder<AuthSchemeBinding> {

        private String schemeId;
        private String endpointAuthName;
        private final Map<String, String> propertyMap = new LinkedHashMap<>();

        public Builder schemeId(String schemeId) {
            this.schemeId = schemeId;
            return this;
        }

        public Builder schemeId(ShapeId shapeId) {
            this.schemeId = shapeId.toString();
            return this;
        }

        public Builder endpointAuthName(String endpointAuthName) {
            this.endpointAuthName = endpointAuthName;
            return this;
        }

        public Builder properties(Map<String, String> properties) {
            properties.forEach((k, v) -> propertyMap.put(k, v));
            return this;
        }

        public Builder property(String endpointProperty, String authProperty) {
            propertyMap.put(endpointProperty, authProperty);
            return this;
        }

        public AuthSchemeBinding build() {
            return new AuthSchemeBinding(this);
        }
    }

}
