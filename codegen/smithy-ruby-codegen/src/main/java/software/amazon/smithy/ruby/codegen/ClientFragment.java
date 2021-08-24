package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.utils.CodeWriter;
import software.amazon.smithy.utils.SmithyBuilder;

import java.util.Collection;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 * Represents a fragment to be rendered in the generated client
 * Exposes ClientConfig that is required for rendering the client
 */
public class ClientFragment {
    private final Set<ClientConfig> clientConfig;
    private final RenderOperation render;

    public ClientFragment(Builder builder) {
        this.clientConfig = builder.clientConfig;
        this.render = builder.render;
    }

    public Set<ClientConfig> getClientConfig() {
        return clientConfig;
    }

    public String render(GenerationContext context) {
        return render.render(this, context);
    }

    @FunctionalInterface
    public interface RenderOperation {
        /**
         * Called to Render the addition of this middleware to the stack
         */
        String render(ClientFragment fragment, GenerationContext context);
    }

    public static class Builder implements SmithyBuilder<ClientFragment> {
        private Set<ClientConfig> clientConfig = new HashSet<>();
        private RenderOperation render = (f, c) -> { return ""; };

        public Builder addConfig(ClientConfig config) {
            this.clientConfig.add(Objects.requireNonNull(config));
            return this;
        }

        public Builder config(Collection<ClientConfig> config) {
            this.clientConfig = new HashSet<>(config);
            return this;
        }

        public Builder render(RenderOperation r) {
            this.render = r;
            return this;
        }

        @Override
        public ClientFragment build() {
            return new ClientFragment(this);
        }
    }
}
