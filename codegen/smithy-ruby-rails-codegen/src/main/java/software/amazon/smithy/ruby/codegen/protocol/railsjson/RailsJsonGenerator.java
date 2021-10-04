package software.amazon.smithy.ruby.codegen.protocol.railsjson;

import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubyCodegenPlugin;
import software.amazon.smithy.ruby.codegen.generators.ClientGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.BuilderGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.ErrorsGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.ParserGenerator;

import java.util.logging.Logger;
import java.util.stream.Stream;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.StubsGenerator;

// Protocol Implementation for Rails-Json
public class RailsJsonGenerator implements ProtocolGenerator {
    private static final Logger LOGGER = Logger.getLogger(RailsJsonGenerator.class.getName());

    @Override
    public ShapeId getProtocol() {
        return ShapeId.from("smithy.rails#RailsJson");
    }

    @Override
    public ApplicationTransport getApplicationTransport() {
        return ApplicationTransport.createDefaultHttpApplicationTransport();
    }

    @Override
    public void generateBuilders(GenerationContext context) {
        BuilderGenerator builderGenerator = new BuilderGenerator(context);
        builderGenerator.render(context.getFileManifest());
        LOGGER.info("created builders");
    }

    @Override
    public void generateParsers(GenerationContext context) {
        ParserGenerator parserGenerator = new ParserGenerator(context);
        parserGenerator.render(context.getFileManifest());
        LOGGER.info("created parsers");
    }

    @Override
    public void generateErrors(GenerationContext context) {
        Stream<Shape> errorShapeStream = context.getModel().shapes().filter((s) -> s.hasTrait(ErrorTrait.class));
        ErrorsGenerator errorsGenerator = new ErrorsGenerator(context.getRubySettings(), errorShapeStream);
        errorsGenerator.render(context.getFileManifest());
        LOGGER.info("created errors");
    }

    @Override
    public void generateStubs(GenerationContext context) {
        StubsGenerator stubsGenerator = new StubsGenerator(context);
        stubsGenerator.render(context.getFileManifest());
        LOGGER.info("created stubs");
    }

    @Override
    public void generateProtocolUnitTests(GenerationContext context) {
        LOGGER.info("Implement me!");
    }
}
