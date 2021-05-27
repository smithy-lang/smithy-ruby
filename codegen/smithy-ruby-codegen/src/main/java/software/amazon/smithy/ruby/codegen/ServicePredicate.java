package software.amazon.smithy.ruby.codegen;


import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;

@FunctionalInterface
public interface ServicePredicate {
    /**
     * Tests if this should be applied to an individual operation.
     *
     * @param model     Model the operation belongs to.
     * @param service   Service the operation belongs to.
     * @return Returns true if middleware should be applied to the operation.
     */
    boolean test(Model model, ServiceShape service);
}
