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

import java.util.Collections;
import java.util.List;
import java.util.Objects;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.WriteAdditionalFiles;
import software.amazon.smithy.ruby.codegen.util.RubySource;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.IsValidHostLabel;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.ParseUrl;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.Substring;
import software.amazon.smithy.rulesengine.language.syntax.expressions.functions.UriEncode;
import software.amazon.smithy.utils.SmithyBuilder;

/**
 * Provides a binding between Smithy rules engine functions and Ruby code.
 */
public final class FunctionBinding {
    private final String id;
    private final String rubyMethodName;
    private final WriteAdditionalFiles writeAdditionalFiles;


    private FunctionBinding(Builder builder) {
        this.id = builder.id;
        this.rubyMethodName = builder.rubyMethodName;
        this.writeAdditionalFiles = builder.writeAdditionalFiles;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static List<FunctionBinding> standardLibraryFunctions() {
        return List.of(
                FunctionBinding.builder()
                        .id(IsValidHostLabel.ID)
                        .rubyMethodName("Hearth::Endpoints::valid_host_label?")
                        .build(),
                FunctionBinding.builder()
                        .id(ParseUrl.ID)
                        .rubyMethodName("Hearth::Endpoints::parse_url")
                        .build(),
                FunctionBinding.builder()
                        .id(Substring.ID)
                        .rubyMethodName("Hearth::Endpoints::substring")
                        .build(),
                FunctionBinding.builder()
                        .id(UriEncode.ID)
                        .rubyMethodName("Hearth::Endpoints::uri_encode")
                        .build()
        );
    }

    /**
     * @return the id (name) of the Rules engine Function.
     */
    public String getId() {
        return id;
    }

    /**
     * @return the fully qualified name of the ruby method.
     */
    public String getRubyMethodName() {
        return rubyMethodName;
    }

    /**
     * Write additional files required by this built-in builder.
     *
     * @param context generation context
     * @return List of additional files written out
     */
    public List<String> writeAdditionalFiles(GenerationContext context) {
        return writeAdditionalFiles.writeAdditionalFiles(context);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof FunctionBinding)) {
            return false;
        }

        FunctionBinding other = (FunctionBinding) o;

        return this.id.equals(other.id);
    }

    /**
     * Builder for {@link FunctionBinding}.
     */
    public static class Builder implements SmithyBuilder<FunctionBinding> {

        private String id;
        private String rubyMethodName;
        private WriteAdditionalFiles writeAdditionalFiles =
                (context) -> Collections.emptyList();

        public Builder id(String id) {
            this.id = id;
            return this;
        }

        public Builder rubyMethodName(String rubyMethodName) {
            this.rubyMethodName = rubyMethodName;
            return this;
        }

        public Builder writeAdditionalFiles(WriteAdditionalFiles w) {
            this.writeAdditionalFiles = Objects.requireNonNull(w);
            return this;
        }

        public Builder rubySource(String rubyFileName) {
            this.writeAdditionalFiles = RubySource.rubySource(rubyFileName, "endpoint/");
            return this;
        }

        @Override
        public FunctionBinding build() {
            return new FunctionBinding(this);
        }
    }

}
