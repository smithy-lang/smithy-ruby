package software.amazon.smithy.ruby.codegen.transformer;

import software.amazon.smithy.build.ProjectionTransformer;
import software.amazon.smithy.build.TransformContext;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.traits.FakeProtocolTrait;

/**
 * A transformer to ensure we can generate an SDK to test Rules-Engine test cases
 */
public class EndpointTestServiceTransformer implements ProjectionTransformer {
    @Override
    public String getName() {
        return "endpointTestService";
    }

    @Override
    public Model transform(TransformContext context) {
        Model model = context.getModel();
        ModelTransformer transformer = context.getTransformer();

        return transformer.mapShapes(model, (shape) -> {
            if (shape.isServiceShape()) {
                return shape.asServiceShape().get().toBuilder().addTrait(new FakeProtocolTrait()).build();
            } else {
                return shape;
            }
        });
    }
}
