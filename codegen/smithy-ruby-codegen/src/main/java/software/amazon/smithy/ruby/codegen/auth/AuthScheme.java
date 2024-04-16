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

package software.amazon.smithy.ruby.codegen.auth;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.WriteAdditionalFiles;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.util.RubySource;
import software.amazon.smithy.utils.SmithyBuilder;

public final class AuthScheme {
    private final ShapeId shapeId;
    private final String rubyAuthScheme;
    private final String rubyIdentityType;
    private Set<AuthParam> additionalAuthParams;
    private final Optional<ClientConfig> identityResolverConfig;
    private final WriteAdditionalFiles writeAdditionalFiles;
    private final ExtractProperties extractSignerProperties;
    private final Map<String, String> signerProperties;
    private final ExtractProperties extractIdentityProperties;
    private final Map<String, String> identityProperties;

    private final List<ClientConfig> additionalConfig;

    private AuthScheme(Builder builder) {
        this.shapeId = Objects.requireNonNull(builder.shapeId);
        this.rubyAuthScheme = Objects.requireNonNull(builder.rubyAuthScheme);
        this.rubyIdentityType = Objects.requireNonNull(builder.rubyIdentityType);
        this.additionalAuthParams = Collections.unmodifiableSet(builder.additionalAuthParams);
        this.identityResolverConfig = Optional.ofNullable(builder.identityResolverConfig);
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
        this.extractSignerProperties = builder.extractSignerProperties;
        this.signerProperties = builder.signerProperties;
        this.extractIdentityProperties = builder.extractIdentityProperties;
        this.identityProperties = builder.identityProperties;
        this.additionalConfig = List.copyOf(builder.additionalConfig);
    }

    public static Builder builder() {
        return new Builder();
    }

    /**
     * @return the shapeId of the auth scheme.
     */
    public ShapeId getShapeId() {
        return shapeId;
    }

    /**
     * @return the initialized ruby class of the auth scheme.
     */
    public String getRubyAuthScheme() {
        return rubyAuthScheme;
    }

    /**
     * @return the ruby identity type (class).
     */
    public String getRubyIdentityType() {
        return rubyIdentityType;
    }

    /**
     * @return additional auth params for the auth scheme.
     */
    public Set<AuthParam> getAdditionalAuthParams() {
        return additionalAuthParams;
    }

    /**
     * @return the ClientConfig for the identity resolver.
     */
    public Optional<ClientConfig> getIdentityResolverConfig() {
        return identityResolverConfig;
    }

    /**
     * Write additional files required by this auth scheme.
     *
     * @param context generation context
     * @return List of additional files written out
     */
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return writeAdditionalFiles.writeAdditionalFiles(context);
    }

    /**
     * @param trait the trait to extract Signer properties from.
     * @return the Signer properties for the auth scheme.
     */
    public Map<String, String> getSignerProperties(Trait trait) {
        Map<String, String> signerProperties = extractSignerProperties.extractProperties(trait);
        this.signerProperties.forEach((key, value) -> signerProperties.put(key, value));
        return signerProperties;
    }

    /**
     * @param trait the trait to extract Identity properties from.
     * @return the Identity properties for the auth scheme.
     */
    public Map<String, String> getIdentityProperties(Trait trait) {
        Map<String, String> identityProperties = extractIdentityProperties.extractProperties(trait);
        this.identityProperties.forEach((key, value) -> identityProperties.put(key, value));
        return identityProperties;
    }

    public List<ClientConfig> getAdditionalConfig() {
        return additionalConfig;
    }

    @FunctionalInterface
    /**
     * Extract properties from a trait.
     */
    public interface ExtractProperties {
        /**
         * @param trait the trait to extract properties from.
         * @return the extracted properties.
         */
        Map<String, String> extractProperties(Trait trait);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof AuthScheme)) {
            return false;
        }

        AuthScheme other = (AuthScheme) o;

        return this.shapeId.equals(other.shapeId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(shapeId);
    }

    public static class Builder implements SmithyBuilder<AuthScheme> {
        private ShapeId shapeId;
        private String rubyAuthScheme;
        private String rubyIdentityType;
        private Set<AuthParam> additionalAuthParams = new HashSet<>();
        private ClientConfig identityResolverConfig;
        private WriteAdditionalFiles writeAdditionalFiles = (context) -> Collections.emptyList();
        private ExtractProperties extractSignerProperties = (trait) -> Collections.emptyMap();
        private ExtractProperties extractIdentityProperties = (trait) -> Collections.emptyMap();
        private Map<String, String> signerProperties = new HashMap<>();
        private Map<String, String> identityProperties = new HashMap<>();

        private List<ClientConfig> additionalConfig = new ArrayList<>();

        protected Builder() {
        }

        /**
         * @param shapeId the shapeId of the auth scheme.
         * @return Returns the Builder
         */
        public Builder shapeId(ShapeId shapeId) {
            this.shapeId = Objects.requireNonNull(shapeId);
            return this;
        }

        /**
         * @param rubyAuthScheme the initialized ruby class of the auth scheme.
         * @return Returns the Builder
         */
        public Builder rubyAuthScheme(String rubyAuthScheme) {
            this.rubyAuthScheme = Objects.requireNonNull(rubyAuthScheme);
            return this;
        }

        /**
         * @param rubyIdentityType the ruby identity type (class).
         * @return Returns the Builder
         */
        public Builder rubyIdentityType(String rubyIdentityType) {
            this.rubyIdentityType = Objects.requireNonNull(rubyIdentityType);
            return this;
        }

        /**
         * @param authParam additional auth param for the auth scheme.
         * @return Returns the Builder
         */
        public Builder additionalAuthParam(AuthParam authParam) {
            this.additionalAuthParams.add(authParam);
            return this;
        }

        /**
         * @param identityResolverConfig the ClientConfig for the identity resolver.
         * @return Returns the Builder
         */
        public Builder identityResolverConfig(ClientConfig identityResolverConfig) {
            this.identityResolverConfig = identityResolverConfig;
            return this;
        }

        /**
         * Used to copy a Ruby source file that defines an auth scheme into the generated SDK.
         * The copied file must have three classes under the Auth namespace. The three classes should be
         * the AuthScheme, Identity, and Signer, and then these names registered via the
         * builder. This method will apply the generated service's namespace to the source file.
         *
         * @param rubyFileName the file name (with path) of the ruby file to copy.
         * @return Return the Builder
         */
        public Builder rubySource(String rubyFileName) {
            this.writeAdditionalFiles = RubySource.rubySource(rubyFileName, "auth/");
            return this;
        }

        /**
         * Used to extract properties from a trait and add them to the Signer properties.
         * @param extractProperties the function to extract properties from a trait.
         * @return Returns the Builder
         */
        public Builder extractSignerProperties(ExtractProperties extractProperties) {
            this.extractSignerProperties = extractProperties;
            return this;
        }

        /**
         * Used to add a property to the Signer properties.
         * @param key the key of the property.
         * @param value the value of the property.
         * @return Returns the Builder
         */
        public Builder putSignerProperty(String key, String value) {
            this.signerProperties.put(key, value);
            return this;
        }

        /**
         * Used to extract properties from a trait and add them to the Identity properties.
         * @param extractProperties the function to extract properties from a trait.
         * @return Returns the Builder
         */
        public Builder extractIdentityProperties(ExtractProperties extractProperties) {
            this.extractIdentityProperties = extractProperties;
            return this;
        }

        /**
         * Used to add a property to the Identity properties.
         * @param key the key of the property.
         * @param value the value of the property.
         * @return Returns the Builder
         */
        public Builder putIdentityProperty(String key, String value) {
            this.identityProperties.put(key, value);
            return this;
        }

        /**
         * Add ClientConfig that this AuthScheme depends on.
         * @param config client config to include when this auth scheme is used.
         * @return returns the builder.
         */
        public Builder additionalConfig(ClientConfig config) {
            this.additionalConfig.add(config);
            return this;
        }

        @Override
        public AuthScheme build() {
            return new AuthScheme(this);
        }
    }
}
