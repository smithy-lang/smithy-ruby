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

package software.amazon.smithy.ruby.codegen.traits;

import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.AbstractTrait;
import software.amazon.smithy.model.traits.AbstractTraitBuilder;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.utils.ToSmithyBuilder;

public final class HttpCustomAuthTrait extends AbstractTrait implements ToSmithyBuilder<HttpCustomAuthTrait> {

    public static final ShapeId ID = ShapeId.from("smithy.ruby.tests#httpCustomAuth");

    private final String signerProperty;
    private final String identityProperty;

    private HttpCustomAuthTrait(HttpCustomAuthTrait.Builder builder) {
        super(ID, builder.getSourceLocation());
        signerProperty = builder.signerProperty;
        identityProperty = builder.identityProperty;
    }

    public String getSignerProperty() {
        return signerProperty;
    }

    public String getIdentityProperty() {
        return identityProperty;
    }

    @Override
    public HttpCustomAuthTrait.Builder toBuilder() {
        return builder()
                .sourceLocation(getSourceLocation())
                .signerProperty(signerProperty)
                .identityProperty(identityProperty);
    }

    @Override
    protected Node createNode() {
        ObjectNode.Builder builder = Node.objectNodeBuilder()
                .sourceLocation(getSourceLocation())
                .withMember("signerProperty", getSignerProperty())
                .withMember("identityProperty", getIdentityProperty());
        return builder.build();
    }

    public static HttpCustomAuthTrait.Builder builder() {
        return new HttpCustomAuthTrait.Builder();
    }

    public static final class Provider extends AbstractTrait.Provider {
        public Provider() {
            super(ID);
        }

        @Override
        public Trait createTrait(ShapeId target, Node value) {
            HttpCustomAuthTrait.Builder builder = builder().sourceLocation(value.getSourceLocation());
            value.expectObjectNode().getStringMember("signerProperty", builder::signerProperty);
            value.expectObjectNode().getStringMember("identityProperty", builder::identityProperty);
            HttpCustomAuthTrait result = builder.build();
            result.setNodeCache(value);
            return result;
        }
    }

    public static final class Builder extends AbstractTraitBuilder<HttpCustomAuthTrait, HttpCustomAuthTrait.Builder> {
        private String signerProperty;
        private String identityProperty;

        private Builder() {
        }

        @Override
        public HttpCustomAuthTrait build() {
            return new HttpCustomAuthTrait(this);
        }

        public HttpCustomAuthTrait.Builder signerProperty(String signerProperty) {
            this.signerProperty = signerProperty;
            return this;
        }

        public HttpCustomAuthTrait.Builder identityProperty(String identityProperty) {
            this.identityProperty = identityProperty;
            return this;
        }
    }
}
