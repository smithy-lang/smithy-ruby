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

package software.amazon.smithy.ruby.codegen.trait;

import java.util.List;
import java.util.Optional;
import software.amazon.smithy.model.SourceLocation;
import software.amazon.smithy.model.node.ArrayNode;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.AbstractTrait;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.model.traits.TraitService;
import software.amazon.smithy.utils.ListUtils;

/**
 * Trait to mark protocol tests that should be skipped/ignored.
 */
public final class SkipTestsTrait extends AbstractTrait {
    /**
     * ShapeId for the SkipTestsTrait.
     */
    public static final ShapeId ID = ShapeId.from("smithy.ruby#skipTests");

    private final List<SkipTest> skipTests;

    /**
     * @param skipTests List of tests to skip
     */
    public SkipTestsTrait(List<SkipTest> skipTests) {
        this(SourceLocation.NONE, skipTests);
    }

    /**
     * @param sourceLocation location where this trait was applied
     * @param skipTests tests to skip.
     */
    public SkipTestsTrait(SourceLocation sourceLocation, List<SkipTest> skipTests) {
        super(ID, sourceLocation);
        this.skipTests = ListUtils.copyOf(skipTests);
    }

    /**
     * @return list of tests to skip.
     */
    public List<SkipTest> getSkipTests() {
        return skipTests;
    }

    /**
     * @param testId testId to skip
     * @param testType testType to skip
     * @return optional SkipTest trait
     */
    public Optional<SkipTest> skipTest(String testId, String testType) {
        return skipTests.stream()
                .filter((skipTest) -> skipTest.getId().equals(testId)
                        && skipTest.getType()
                        .map((t) -> t.equals(testType))
                        .orElse(true)
                )
                .findFirst();
    }

    @Override
    protected Node createNode() {
        return getSkipTests().stream().collect(ArrayNode.collect());
    }

    /**
     * Provider for the SkipTestsTrait.
     */
    public static final class Provider implements TraitService {
        @Override
        public ShapeId getShapeId() {
            return ID;
        }

        @Override
        public Trait createTrait(ShapeId target, Node value) {
            ArrayNode values = value.expectArrayNode();
            List<SkipTest> skipTests = values.getElementsAs(SkipTest::fromNode);
            SkipTestsTrait result = new SkipTestsTrait(value.getSourceLocation(), skipTests);
            result.setNodeCache(value);
            return result;
        }
    }
}
