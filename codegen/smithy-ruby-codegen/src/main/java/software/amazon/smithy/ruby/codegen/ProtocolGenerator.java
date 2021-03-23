package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.model.shapes.ShapeId;

public interface ProtocolGenerator {

    ShapeId getProtocol();

    ApplicationTransport getApplicationTransport();

    void generateBuilders(GenerationContext context);

    void generateParsers(GenerationContext context);

    void generateErrors(GenerationContext context);

    void generateProtocolUnitTests(GenerationContext context);

    void generateProtocolClient(GenerationContext context);

}
