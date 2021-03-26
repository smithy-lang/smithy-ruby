package software.amazon.smithy.ruby.codegen.integrations;

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.*;
import software.amazon.smithy.model.traits.DocumentationTrait;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.*;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.trait.NoSerializeTrait;

import java.util.*;

public class GameArn implements RubyIntegration {

    private final Set<String> OPERATIONS = new HashSet<>(Arrays.asList("GetHighScore", "DeleteHighScore"));

    @Override
    public boolean includeFor(ServiceShape service, Model model){
        // return true only for our SampleService (HighScore)
        return service.getId().getName().equals("SampleService");
    }

    @Override
    public Model preprocessModel(PluginContext context, Model model, RubySettings settings) {
        ServiceShape service = model.expectShape(settings.getService(), ServiceShape.class);

        TopDownIndex topDownIndex = TopDownIndex.of(model);
        TreeSet<OperationShape> operations = new TreeSet<>(topDownIndex.getContainedOperations(
                model.expectShape(service.toShapeId())));

        Model.Builder modelBuilder = model.toBuilder();
        Shape customString = StringShape.builder().id("sdk.customizations.gameArn#String").build();
        modelBuilder.addShape(customString);

        for (OperationShape operation : operations) {
            if (OPERATIONS.contains(operation.getId().getName())) {
                OperationShape.Builder builder  = operation.toBuilder();

                System.out.println("Modifying operation to add GameArn Input: " + operation.getId().getName());

                ShapeId inputShapeId = operation.getInput().get();
                StructureShape input = model.expectShape(inputShapeId).asStructureShape().get();

                System.out.println("\tGot the Input shape: " + input.getId());


                StructureShape.Builder inputBuilder = input.toBuilder();

                inputBuilder.addMember("GameArn", customString.getId(), (memberBuilder) -> {
                    memberBuilder
                            .addTrait(new DocumentationTrait(
                                    "A Game ARN parameter"))
                            .addTrait(new NoSerializeTrait());
                    });

                modelBuilder.addShape(inputBuilder.build());
            }
        }
        return modelBuilder.build();
    }


    @Override
    public List<Middleware> getClientMiddleware() {
        ClientConfig disableGameArn = (new ClientConfig.Builder())
                .name("disable_game_arn")
                .type("bool")
                .defaultValue("false")
                .documentation("Disables Game ARN resolution.")
                .build();

        Middleware gameArn = (new Middleware.Builder())
                .klass("Middleware::GameArn")
                .step(MiddlewareStackStep.INITIALIZE)
                .addConfig(disableGameArn)
                .addParam("params", "params")
                .appliesOnlyToOperations(OPERATIONS)
                .build();
        return Collections.singletonList(gameArn);
    }

    @Override
    public List<String> writeAdditionalFiles(GenerationContext context ) {
        FileManifest fileManifest = context.getFileManifest();
        RubySettings settings = context.getRubySettings();
        RubyCodeWriter writer = new RubyCodeWriter();


        //NOTE: This could instead be done by the middleware definition above using the Middleware#writeAddtionalFiles
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Middleware")
                .write("# Resolve GameArns")
                .openBlock("class GameArn")
                .openBlock("def initialize(app, disable_game_arn:, params:)")
                .write("@app = app")
                .write("@disable_game_arn = disable_game_arn")
                .write("@params = params")
                .closeBlock("end")
                .write("")
                .openBlock("def call(request:, response:, context:)")
                .openBlock("unless @disable_game_arn")
                .write("@params[:id] ||= @params[:game_arn]&.split(':')&.last")
                .closeBlock("end")
                .write("@app.call(request: request, response: response, context: context)")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        String relativeName = settings.getGemName() + "/middleware/game_arn";
        String fileName = settings.getGemName() + "/lib/" + relativeName + ".rb";
        fileManifest.writeFile(fileName, writer.toString());

        return Collections.singletonList(relativeName);
    }


}
