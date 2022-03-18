package software.amazon.smithy.ruby.codegen.trait;

import java.util.Optional;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.node.ToNode;
import software.amazon.smithy.protocoltests.traits.HttpResponseTestCase;
import software.amazon.smithy.utils.MapUtils;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.ToSmithyBuilder;

public class SkipTest implements ToSmithyBuilder<SkipTest>, ToNode {
    private final String id;
    private final String reason;


    private SkipTest(Builder builder) {
        this.id = builder.id;
        this.reason = builder.reason;
    }

    public String getId() {
        return id;
    }

    public Optional<String> getReason() {
        return Optional.ofNullable(reason);
    }

    /**
     * @return Returns a builder used to create a RailJson trait.
     */
    public static Builder builder() {
        return new Builder();
    }

    public Node toNode() {
        ObjectNode.Builder builder = Node.objectNodeBuilder()
                .withMember("id", getId())
                .withOptionalMember("reason", getReason().map(Node::from));

        return builder.build();
    }

    public static SkipTest fromNode(Node node) {
        ObjectNode objectNode = node.expectObjectNode();
        String idValue = objectNode.getMember("id")
                .map(v -> v.expectStringNode().getValue()).orElse(null);
        String reasonValue = objectNode.getMember("reason")
                .map(v -> v.expectStringNode().getValue()).orElse(null);
        return builder().id(idValue).reason(reasonValue).build();
    }

    @Override
    public SmithyBuilder<SkipTest> toBuilder() {
        return builder().id(id).reason(reason);
    }

    public static final class Builder implements SmithyBuilder<SkipTest> {

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
        public SkipTest build() {
            return new SkipTest(this);
        }
    }
}
