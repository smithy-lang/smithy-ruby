package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.model.shapes.Shape;

import java.util.Optional;

public final class CodegenUtils {
    private static final String SYNTHETIC_NAMESPACE = "smithy.go.synthetic";

    private CodegenUtils() {

    }

    /**
     * Get the namespace where synthetic types are generated at runtime.
     *
     * @return synthetic type namespace
     */
    public static String getSyntheticTypeNamespace() {
        return CodegenUtils.SYNTHETIC_NAMESPACE;
    }

    /**
     * Get if the passed in shape is decorated as a synthetic clone, but there is no other shape the clone is
     * created from.
     *
     * @param shape the shape to check if its a stubbed synthetic clone without an archetype.
     * @return if the shape is synthetic clone, but not based on a specific shape.
     */
    public static boolean isStubSyntheticClone(Shape shape) {
        Optional<SyntheticClone> optional = shape.getTrait(SyntheticClone.class);
        if (!optional.isPresent()) {
            return false;
        }

        SyntheticClone synthClone = optional.get();
        return !synthClone.getArchetype().isPresent();
    }
}
