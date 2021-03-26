package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.generators.ClientGenerator;
import software.amazon.smithy.ruby.codegen.generators.ValidatorsGenerator;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.generators.GemspecGenerator;
import software.amazon.smithy.ruby.codegen.generators.ModuleGenerator;
import software.amazon.smithy.ruby.codegen.generators.TypesGenerator;

import java.util.*;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

public class CodegenOrchestrator {

    private static final Logger LOGGER = Logger.getLogger(CodegenOrchestrator.class.getName());

    private final GenerationContext context;

    public CodegenOrchestrator(PluginContext pluginContext) {

        RubySettings rubySettings = RubySettings.from(pluginContext.getSettings());
        ServiceLoader<RubyIntegration> integrationServiceLoader = ServiceLoader
                .load(RubyIntegration.class,
                        this.getClass().getClassLoader() // TODO: For some reason, the pluginClassLoader only works during debug.
                        //pluginContext.getPluginClassLoader().orElse(this.getClass().getClassLoader())
                );

        System.out.println("\n\n----------------------------------\n\n");
        System.out.println("Loading integrations....");
        List<RubyIntegration> integrations =
                StreamSupport.stream(integrationServiceLoader.spliterator(), false)
                        .peek((i) -> System.out.println("Loaded RubyIntegration: " + i.getClass().getName()))
                    .sorted(Comparator.comparing(RubyIntegration::getOrder))
                .collect(Collectors.toList());
        System.out.println("Loaded integrations: " + integrations.size());

        Model resolvedModel = pluginContext.getModel();

        for (RubyIntegration integration : integrations) {
            resolvedModel = integration.preprocessModel(pluginContext, resolvedModel, rubySettings);
        }

        ServiceShape service = resolvedModel.expectShape(rubySettings.getService()).asServiceShape().orElseThrow(() -> new CodegenException("Shape is not a service"));

        // Add unique operation input/output shapes
        resolvedModel = AddOperationShapes.execute(resolvedModel, service.getId());

        // Now that service and model are resolved, filter integrations for the service
        Model finalResolvedModel = resolvedModel;
        integrations = integrations.stream()
                .filter((integration) -> integration.includeFor(service, finalResolvedModel))
                .collect(Collectors.toList());

        Set<ShapeId> supportedProtocols = new HashSet<>();
        for (RubyIntegration integration : integrations) {
            supportedProtocols.addAll(
                    integration.getProtocolGenerators()
                            .stream()
                            .map((g) -> g.getProtocol())
                            .peek((s) -> System.out.println(integration.getClass().getSimpleName() + " registered protocolGenerator for: " + s.getName()))
                            .collect(Collectors.toSet())
            );
        }

        ShapeId protocol = rubySettings.resolveServiceProtocol(service, resolvedModel, supportedProtocols);
        Optional<ProtocolGenerator> protocolGenerator = resolveProtocolGenerator(protocol, integrations);

        ApplicationTransport applicationTransport; // Java9+ replace with ifPresentOrElse
        if (protocolGenerator.isPresent()) {
            applicationTransport = protocolGenerator.get().getApplicationTransport();
        } else {
            applicationTransport = ApplicationTransport.createDefaultHttpApplicationTransport();
        }

        System.out.println("Resolved ApplicationTransport: " + applicationTransport);

        context = new GenerationContext(
                rubySettings,
                pluginContext.getFileManifest(),
                integrations,
                resolvedModel,
                service,
                protocol,
                protocolGenerator,
                applicationTransport);
    }

    /*
    * Return the first matching ProtocolGenerator (if any)
     */
    private Optional<ProtocolGenerator> resolveProtocolGenerator(ShapeId protocol, List<RubyIntegration> integrations) {
        for(RubyIntegration integration : integrations) {
            Optional<ProtocolGenerator> pg = integration.getProtocolGenerators()
                    .stream().filter((p) -> p.getProtocol().equals(protocol)).findFirst();
            if (pg.isPresent()) {
                return pg;
            }
        }
        return Optional.empty();
    }

    public void execute() {

        System.out.println("\n\n----------------------------------\n\n");
        System.out.println("Starting CodeGen execute");

        // Integration hook - processFinalizedModel
        context.getIntegrations().forEach( (integration) -> integration.processFinalizedModel(context));

        generateTypes();
        generateValidators();

        if (context.getProtocolGenerator().isPresent()) {
            ProtocolGenerator protocolGenerator = context.getProtocolGenerator().get();

            protocolGenerator.generateBuilders(context);
            protocolGenerator.generateParsers(context);
            protocolGenerator.generateErrors(context);
            protocolGenerator.generateStubbers(context);
            protocolGenerator.generateProtocolUnitTests(context);
        }

        generateClient();

        generateModule();

        generateGemSpec();
    }

    private void generateTypes() {
        TypesGenerator typesGenerator = new TypesGenerator(context);
        typesGenerator.render();
        LOGGER.info("created types");
    }

    private void generateValidators() {
        ValidatorsGenerator validatorsGenerator = new ValidatorsGenerator(context);
        validatorsGenerator.render();
        LOGGER.info("created types");
    }

    private void generateClient() {
        ClientGenerator clientGenerator = new ClientGenerator(context);
        clientGenerator.render();
    }

    private void generateModule() {
        List<String> additionalFiles = context.getIntegrations().stream()
                .map((integration) -> integration.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .collect(Collectors.toList());
        ModuleGenerator moduleGenerator = new ModuleGenerator(context);
        moduleGenerator.render(additionalFiles);
        LOGGER.info("created module");
    }

    private void generateGemSpec() {
        List<RubyDependency> additionalDependencies = context.getIntegrations().stream()
                .map((integration) -> integration.additionalGemDependencies(context))
                .flatMap(Collection::stream)
                .collect(Collectors.toList());
        GemspecGenerator gemspecGenerator = new GemspecGenerator(context);
        gemspecGenerator.render(additionalDependencies);
        LOGGER.info("wrote .gemspec");
    }
}
