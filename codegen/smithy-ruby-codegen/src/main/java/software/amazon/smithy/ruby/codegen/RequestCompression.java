package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.traits.RequestCompressionTrait;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;

public class RequestCompression implements RubyIntegration {
    @Override
    public boolean includeFor(ServiceShape service, Model model) {
        return model.isTraitApplied(RequestCompressionTrait.class);
    }

    @Override
    public void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context){
    }
}
