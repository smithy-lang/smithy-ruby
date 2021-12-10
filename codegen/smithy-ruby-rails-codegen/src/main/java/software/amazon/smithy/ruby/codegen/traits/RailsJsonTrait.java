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

package software.amazon.smithy.ruby.codegen.traits;

import java.util.Optional;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.AbstractTrait;
import software.amazon.smithy.model.traits.AbstractTraitBuilder;
import software.amazon.smithy.model.traits.TraitService;
import software.amazon.smithy.utils.MapUtils;
import software.amazon.smithy.utils.ToSmithyBuilder;

public final class RailsJsonTrait extends AbstractTrait implements ToSmithyBuilder<RailsJsonTrait> {
    public static final ShapeId ID = ShapeId.from("smithy.ruby.protocols#railsJson");

    private final String errorLocation;

    private RailsJsonTrait(Builder builder) {
        super(ID, builder.getSourceLocation());
        this.errorLocation = builder.errorLocation;
    }

    /**
     * Gets the errorLocation value.
     *
     * @return returns the optional errorLocation value.
     */
    public Optional<String> getErrorLocation() {
        return Optional.ofNullable(errorLocation);
    }

    @Override
    protected Node createNode() {
        return new ObjectNode(MapUtils.of(), getSourceLocation())
                .withOptionalMember("errorLocation", getErrorLocation().map(Node::from));
    }

    @Override
    public Builder toBuilder() {
        return builder().errorLocation(errorLocation).sourceLocation(getSourceLocation());
    }

    /**
     * @return Returns a builder used to create a RailJson trait.
     */
    public static Builder builder() {
        return new Builder();
    }

    /**
     * Builder used to create a RailsJsonTrait.
     */
    public static final class Builder extends AbstractTraitBuilder<RailsJsonTrait, Builder> {
        private String errorLocation;

        public Builder errorLocation(String errorLocation) {
            this.errorLocation = errorLocation;
            return this;
        }

        @Override
        public RailsJsonTrait build() {
            return new RailsJsonTrait(this);
        }
    }

    public static final class Provider implements TraitService {
        @Override
        public ShapeId getShapeId() {
            return ID;
        }

        @Override
        public RailsJsonTrait createTrait(ShapeId target, Node value) {
            ObjectNode objectNode = value.expectObjectNode();
            String errorLocationValue = objectNode.getMember("errorLocation")
                    .map(v -> v.expectStringNode().getValue()).orElse(null);
            return builder().sourceLocation(value).errorLocation(errorLocationValue).build();
        }
    }
}
