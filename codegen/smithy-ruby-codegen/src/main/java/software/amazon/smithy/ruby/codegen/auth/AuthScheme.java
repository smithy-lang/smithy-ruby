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

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.utils.SmithyBuilder;

public final class AuthScheme {
    private final ShapeId shapeId;
    private final String rubyAuthScheme;
    private final List<String> additionalAuthParams;
    private final ClientConfig identityResolverConfig;
    private final WriteAdditionalFiles writeAdditionalFiles;

    private AuthScheme(Builder builder) {
        this.shapeId = builder.shapeId;
        this.rubyAuthScheme = builder.rubyAuthScheme;
        this.additionalAuthParams = builder.additionalAuthParams;
        this.identityResolverConfig = builder.identityResolverConfig;
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
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
     * @return additional auth params for the auth scheme.
     */
    public List<String> getAdditionalAuthParams() {
        return additionalAuthParams;
    }

    /**
     * @return the ClientConfig for the identity resolver.
     */
    public ClientConfig getIdentityResolverConfig() {
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

    @FunctionalInterface
    /**
     * Called to write out additional files needed by this auth scheme.
     */
    public interface WriteAdditionalFiles {
        /**
         * Called to write out additional files needed by this auth scheme.
         *
         * @param context GenerationContext - allows access to file manifest and symbol providers
         * @return List of the relative paths of files written, which will be required in the module.
         */
        List<String> writeAdditionalFiles(GenerationContext context);
    }

    public static class Builder implements SmithyBuilder<AuthScheme> {
        private ShapeId shapeId;
        private String rubyAuthScheme;
        private List<String> additionalAuthParams = Collections.emptyList();
        private ClientConfig identityResolverConfig;
        private WriteAdditionalFiles writeAdditionalFiles =
                (context) -> Collections.emptyList();

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
         * @param additionalAuthParams additional auth params for the auth scheme.
         * @return Returns the Builder
         */
        public Builder additionalAuthParams(List<String> additionalAuthParams) {
            this.additionalAuthParams = additionalAuthParams;
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
         * Used to copy an auth ruby file into the generated SDK. The copied file
         * must have three classes under the Auth namespace. The three classes should be
         * the AuthScheme, Identity, and Signer, and then these names registered via the
         * builder. This method will apply the generated service's namespace to the auth file.
         *
         * @param rubyFileName the file name (with path) of the ruby file to copy.
         * @return Return the Builder
         */
        public Builder rubySource(String rubyFileName) {
            this.writeAdditionalFiles = (context) -> {
                try {
                    Path path = Paths.get(rubyFileName);
                    String relativeName = "auth/" + path.getFileName();
                    String fileName =
                            context.settings().getGemName() + "/lib/"
                                    + context.settings().getGemName()
                                    + "/" + relativeName;
                    String fileContent =
                            new String(Files.readAllBytes(path), StandardCharsets.UTF_8);

                    RubyCodeWriter writer = new RubyCodeWriter(context.settings().getModule());
                    writer
                            .openBlock("module $L", context.settings().getModule())
                            .write(fileContent)
                            .closeBlock("end");

                    context.fileManifest().writeFile(fileName, writer.toString());
                    return Collections.singletonList(relativeName);
                } catch (IOException e) {
                    throw new CodegenException(
                            "Error reading rubySource file: " + rubyFileName,
                            e);
                }
            };
            return this;
        }

        @Override
        public AuthScheme build() {
            return new AuthScheme(this);
        }
    }
}
