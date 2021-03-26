package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;

@FunctionalInterface
public interface OperationPredicate {
    /**
     * Tests this should be applied to an individual operation.
     *
     * @param model     Model the operation belongs to.
     * @param service   Service the operation belongs to.
     * @param operation Operation to test.
     * @return Returns true if middleware should be applied to the operation.
     */
    boolean test(Model model, ServiceShape service, OperationShape operation);
}
