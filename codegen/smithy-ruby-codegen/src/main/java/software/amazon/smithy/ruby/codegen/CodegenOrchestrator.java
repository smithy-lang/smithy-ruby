/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen;

import java.util.Collection;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.ServiceLoader;
import java.util.Set;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.TitleTrait;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.generators.ClientGenerator;
import software.amazon.smithy.ruby.codegen.generators.GemspecGenerator;
import software.amazon.smithy.ruby.codegen.generators.HttpProtocolTestGenerator;
import software.amazon.smithy.ruby.codegen.generators.ModuleGenerator;
import software.amazon.smithy.ruby.codegen.generators.PaginatorsGenerator;
import software.amazon.smithy.ruby.codegen.generators.ParamsGenerator;
import software.amazon.smithy.ruby.codegen.generators.TypesGenerator;
import software.amazon.smithy.ruby.codegen.generators.ValidatorsGenerator;
import software.amazon.smithy.ruby.codegen.generators.WaitersGenerator;
import software.amazon.smithy.utils.CodeWriter;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class CodegenOrchestrator {

    private static final Logger LOGGER =
            Logger.getLogger(CodegenOrchestrator.class.getName());

    private final GenerationContext context;

    public CodegenOrchestrator(PluginContext pluginContext) {

        RubySettings rubySettings =
                RubySettings.from(pluginContext.getSettings());

        // If this fails to load changes, run: ./gradlew --stop
        ServiceLoader<RubyIntegration> integrationServiceLoader = ServiceLoader
                .load(RubyIntegration.class,
                        pluginContext.getPluginClassLoader()
                                .orElse(this.getClass().getClassLoader())
                );

        LOGGER.info("Loading integrations");
        List<RubyIntegration> integrations =
                StreamSupport
                        .stream(integrationServiceLoader.spliterator(), false)
                        .peek((i) -> LOGGER.info(
                                "Loaded RubyIntegration: "
                                        + i.getClass().getName()))
                        .sorted(Comparator.comparing(RubyIntegration::getOrder))
                        .collect(Collectors.toList());
        LOGGER.info("Loaded integrations: " + integrations.size());

        Model resolvedModel = pluginContext.getModel();

        for (RubyIntegration integration : integrations) {
            resolvedModel = integration
                    .preprocessModel(pluginContext, resolvedModel,
                            rubySettings);
        }

        ServiceShape service =
                resolvedModel.expectShape(rubySettings.getService())
                        .asServiceShape().orElseThrow(
                        () -> new CodegenException("Shape is not a service"));

        // Add unique operation input/output shapes
        resolvedModel = ModelTransformer.create()
                .createDedicatedInputAndOutput(resolvedModel, "Input", "Output");

        // Now that service and model are resolved, filter integrations for the service
        Model finalResolvedModel = resolvedModel;
        integrations = integrations.stream()
                .filter((integration) -> integration
                        .includeFor(service, finalResolvedModel))
                .collect(Collectors.toList());

        Set<ShapeId> supportedProtocols = new HashSet<>();
        for (RubyIntegration integration : integrations) {
            supportedProtocols.addAll(
                    integration.getProtocolGenerators()
                            .stream()
                            .map((g) -> g.getProtocol())
                            .peek((s) -> LOGGER.info(
                                    integration.getClass().getSimpleName()
                                            + " registered protocolGenerator "
                                            + "for: "
                                            + s.getName() + " -> "
                                            + s))
                            .collect(Collectors.toSet())
            );
        }

        ShapeId protocol = rubySettings
                .resolveServiceProtocol(service, resolvedModel,
                        supportedProtocols);
        Optional<ProtocolGenerator> protocolGenerator =
                resolveProtocolGenerator(protocol, integrations);

        ApplicationTransport
                applicationTransport; // Java9+ replace with ifPresentOrElse
        if (protocolGenerator.isPresent()) {
            applicationTransport =
                    protocolGenerator.get().getApplicationTransport();
        } else {
            applicationTransport = ApplicationTransport
                    .createDefaultHttpApplicationTransport();
        }

        LOGGER.info(
                "Resolved ApplicationTransport: " + applicationTransport);

        context = new GenerationContext(
                rubySettings,
                pluginContext.getFileManifest(),
                integrations,
                resolvedModel,
                service,
                protocol,
                protocolGenerator,
                applicationTransport
        );
    }

    /*
     * Return the first matching ProtocolGenerator (if any)
     */
    private Optional<ProtocolGenerator> resolveProtocolGenerator(
            ShapeId protocol, List<RubyIntegration> integrations) {
        for (RubyIntegration integration : integrations) {
            Optional<ProtocolGenerator> pg = integration.getProtocolGenerators()
                    .stream().filter((p) -> p.getProtocol().equals(protocol))
                    .findFirst();
            if (pg.isPresent()) {
                return pg;
            }
        }
        return Optional.empty();
    }

    public void execute() {

        // Integration hook - processFinalizedModel
        context.getIntegrations().forEach(
                (integration) -> integration.processFinalizedModel(context));

        generateTypes();
        generateParams();
        generateValidators();
        generateProtocolTests();

        if (context.getProtocolGenerator().isPresent()) {
            ProtocolGenerator protocolGenerator =
                    context.getProtocolGenerator().get();

            protocolGenerator.generateBuilders(context);
            protocolGenerator.generateParsers(context);
            protocolGenerator.generateErrors(context);
            protocolGenerator.generateStubs(context);
        }

        generateClient();
        generateWaiters();
        generatePaginators();

        generateModule();
        generateGemSpec();
        generateYardOpts();
    }

    private void generateTypes() {
        TypesGenerator typesGenerator = new TypesGenerator(context);
        typesGenerator.render();
        typesGenerator.renderRbs();
        LOGGER.info("generated types");
    }

    private void generateParams() {
        ParamsGenerator paramsGenerator = new ParamsGenerator(context);
        paramsGenerator.render();
        LOGGER.info("generated params");
    }

    private void generateValidators() {
        ValidatorsGenerator validatorsGenerator =
                new ValidatorsGenerator(context);
        validatorsGenerator.render();
        LOGGER.info("generated validators");
    }

    private void generateProtocolTests() {
        if (context.getApplicationTransport().isHttpTransport()) {
            HttpProtocolTestGenerator testGenerator =
                    new HttpProtocolTestGenerator(context);
            testGenerator.render();
            LOGGER.info("generated protocol tests");
        }
    }

    private void generateClient() {
        ClientGenerator clientGenerator = new ClientGenerator(context);
        clientGenerator.render();
        clientGenerator.renderRbs();
        LOGGER.info("generated client");
    }

    private void generateModule() {
        List<String> additionalFiles = context.getIntegrations().stream()
                .map((integration) -> integration.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .collect(Collectors.toList());
        ModuleGenerator moduleGenerator = new ModuleGenerator(context);
        moduleGenerator.render(additionalFiles);
        LOGGER.info("generated module");
    }

    private void generateGemSpec() {
        List<RubyDependency> additionalDependencies =
                context.getIntegrations().stream()
                        .map((integration) -> integration
                                .additionalGemDependencies(context))
                        .flatMap(Collection::stream)
                        .collect(Collectors.toList());
        GemspecGenerator gemspecGenerator = new GemspecGenerator(context);
        gemspecGenerator.render(additionalDependencies);
        LOGGER.info("generated .gemspec");
    }

    private void generateYardOpts() {
        Optional<TitleTrait> title = context.getService().getTrait(TitleTrait.class);
        if (title.isPresent()) {
            FileManifest fileManifest = context.getFileManifest();
            CodeWriter writer = new CodeWriter();
            writer.write("--title \"$L\"", title.get().getValue());
            writer.write("--hide-api private");
            String fileName = context.getRubySettings().getGemName() + "/.yardopts";
            fileManifest.writeFile(fileName, writer.toString());
        }
    }

    private void generateWaiters() {
        WaitersGenerator waitersGenerator = new WaitersGenerator(context);
        waitersGenerator.render();
        waitersGenerator.renderRbs();
        LOGGER.info("generated waiters");
    }

    private void generatePaginators() {
        PaginatorsGenerator paginatorsGenerator = new PaginatorsGenerator(context);
        paginatorsGenerator.render();
        paginatorsGenerator.renderRbs();
        LOGGER.info("generated paginators");
    }
}
