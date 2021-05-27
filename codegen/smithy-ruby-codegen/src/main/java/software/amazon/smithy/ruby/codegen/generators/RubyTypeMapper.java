package software.amazon.smithy.ruby.codegen.generators;

import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.*;

/**
 * Maps Shapes to their RBS type (eg string to String, list to Array[Type])
 */
public class RubyTypeMapper extends ShapeVisitor.Default<String> {
    private final Model model;

    public RubyTypeMapper(Model model) {
        this.model = model;
    }

    @Override
    protected String getDefault(Shape shape) {
        return "untyped";
    }

    @Override
    public String booleanShape(BooleanShape shape) {
        return "bool";
    }

    @Override
    public String listShape(ListShape shape) {
        Shape member = model.expectShape(shape.getMember().getTarget());
        return "Array[" + member.accept(this) + "]";
    }

    @Override
    public String setShape(SetShape shape) {
        return "Set"; //TODO: Is this right?
    }

    @Override
    public String byteShape(ByteShape shape) {
        return "Integer";
    }

    @Override
    public String shortShape(ShortShape shape) {
        return "Integer";
    }

    @Override
    public String integerShape(IntegerShape shape) {
        return "Integer";
    }

    @Override
    public String longShape(LongShape shape) {
        return "Integer";
    }

    @Override
    public String floatShape(FloatShape shape) {
        return "Float";
    }

    @Override
    public String doubleShape(DoubleShape shape) {
        return "Float";
    }

    @Override
    public String bigIntegerShape(BigIntegerShape shape) {
        return "BigNum";
    }

    @Override
    public String mapShape(MapShape shape) {
        return "Hash[Symbol, untyped]"; //TODO: Infer type of value,and is symbol the right type for key or should it be String?
    }

    @Override
    public String stringShape(StringShape shape) {
        return "String";
    }

    @Override
    public String structureShape(StructureShape shape) {
        return shape.getId().getName();
    }

    @Override
    public String unionShape(UnionShape shape) {
        return shape.getId().getName(); //TODO: Right now this will jsut be a struct.  but pending union type
    }

    @Override
    public String timestampShape(TimestampShape shape) {
        return "Time";
    }
}
