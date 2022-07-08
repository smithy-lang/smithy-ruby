package software.amazon.smithy.ruby.codegen.trait;

import java.util.Optional;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.node.ToNode;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestCase;
import software.amazon.smithy.utils.MapUtils;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.ToSmithyBuilder;

/**
 * Describe a protocol test that should be skipped or ignored.
 */
public class SkipTest implements ToSmithyBuilder<SkipTest>, ToNode {
    private final String id;
    private final String reason;
    private final String type;


    /**
     * @param builder builder to build from.
     */
    private SkipTest(Builder builder) {
        this.id = builder.id;
        this.reason = builder.reason;
        this.type = builder.type;
    }

    /**
     * @return id of the test to skip.
     */
    public String getId() {
        return id;
    }

    /**
     * @return reason to skip the test.
     */
    public Optional<String> getReason() {
        return Optional.ofNullable(reason);
    }

    /**
     * @return the type of the test to skip.
     */
    public Optional<String> getType() { return Optional.ofNullable(type); }

    /**
     * @return Returns a builder used to create a RailJson trait.
     */
    public static Builder builder() {
        return new Builder();
    }

    /**
     * @return Node representing the test to skip.
     */
    public Node toNode() {
        ObjectNode.Builder builder = Node.objectNodeBuilder()
                .withMember("id", getId())
                .withOptionalMember("reason", getReason().map(Node::from))
                .withOptionalMember("type", getType().map(Node::from));

        return builder.build();
    }

    public static SkipTest fromNode(Node node) {
        ObjectNode objectNode = node.expectObjectNode();
        String idValue = objectNode.getMember("id")
                .map(v -> v.expectStringNode().getValue()).orElse(null);
        String reasonValue = objectNode.getMember("reason")
                .map(v -> v.expectStringNode().getValue()).orElse(null);
        String typeValue = objectNode.getMember("type")
                .map(v -> v.expectStringNode().getValue()).orElse(null);
        return builder().id(idValue).reason(reasonValue).type(typeValue).build();
    }

    @Override
    public SmithyBuilder<SkipTest> toBuilder() {
        return builder().id(id).reason(reason).type(type);
    }

    /**
     * Builder for SkipTest
     */
    public static final class Builder implements SmithyBuilder<SkipTest> {

        private String id;
        private String reason;
        private String type;;

        /**
         * @param id id of the test to skip
         * @return this builder.
         */
        public Builder id(String id) {
            this.id = id;
            return this;
        }

        /**
         * @param reason reason this test should be skipped.
         * @return this builder
         */
        public Builder reason(String reason) {
            this.reason = reason;
            return this;
        }

        /**
         * @param type type of test to skip
         * @return this builder
         */
        public Builder type(String type) {
            this.type = type;
            return this;
        }

        @Override
        public SkipTest build() {
            return new SkipTest(this);
        }
    }
}
