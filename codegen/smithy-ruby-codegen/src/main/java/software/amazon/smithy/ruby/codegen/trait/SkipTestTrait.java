/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

package software.amazon.smithy.ruby.codegen.trait;

import java.util.Optional;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.AbstractTrait;
import software.amazon.smithy.model.traits.AbstractTraitBuilder;
import software.amazon.smithy.model.traits.TraitService;
import software.amazon.smithy.utils.MapUtils;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.ToSmithyBuilder;

public final class SkipTestTrait extends AbstractTrait implements ToSmithyBuilder<SkipTestTrait> {
    public static final ShapeId ID = ShapeId.from("smithy.ruby#skipTest");

    private final String id;
    private final String reason;

    private SkipTestTrait(Builder builder) {
        super(ID, builder.getSourceLocation());
        this.id = builder.id;
        this.reason = builder.reason;
    }

    /**
     * @return Returns a builder used to create a RailJson trait.
     */
    public static Builder builder() {
        return new Builder();
    }

    @Override
    public SmithyBuilder<SkipTestTrait> toBuilder() {
        return builder().id(id).reason(reason);
    }

    /**
     * Gets the id of the test to skip.
     *
     * @return returns the id reason value.
     */
    public String getId() {
        return id;
    }

    /**
     * Gets the reason value.
     *
     * @return returns the optional reason value.
     */
    public Optional<String> getReason() {
        return Optional.ofNullable(reason);
    }

    @Override
    protected Node createNode() {
        return new ObjectNode(MapUtils.of(), getSourceLocation())
                .withMember("id", getId())
                .withOptionalMember("reason", getReason().map(Node::from));
    }

    /**
     * Builder used to create a SkipTestTrait.
     */
    public static final class Builder extends AbstractTraitBuilder<SkipTestTrait, Builder> {
        private String id;
        private String reason;

        public Builder id(String id) {
            this.id = id;
            return this;
        }

        public Builder reason(String reason) {
            this.reason = reason;
            return this;
        }

        @Override
        public SkipTestTrait build() {
            return new SkipTestTrait(this);
        }
    }

    public static final class Provider implements TraitService {
        @Override
        public ShapeId getShapeId() {
            return ID;
        }

        @Override
        public SkipTestTrait createTrait(ShapeId target, Node value) {
            ObjectNode objectNode = value.expectObjectNode();
            String idValue = objectNode.getMember("id")
                    .map(v -> v.expectStringNode().getValue()).orElse(null);
            String reasonValue = objectNode.getMember("reason")
                    .map(v -> v.expectStringNode().getValue()).orElse(null);
            return builder().sourceLocation(value).id(idValue).reason(reasonValue).build();
        }
    }
}
