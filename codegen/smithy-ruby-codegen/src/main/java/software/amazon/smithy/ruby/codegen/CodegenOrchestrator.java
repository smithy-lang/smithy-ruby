/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.codegen.core.SmithyIntegration;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.transform.ModelTransformer;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.generators.ClientGenerator;
import software.amazon.smithy.ruby.codegen.generators.ConfigGenerator;
import software.amazon.smithy.ruby.codegen.generators.GemspecGenerator;
import software.amazon.smithy.ruby.codegen.generators.HttpProtocolTestGenerator;
import software.amazon.smithy.ruby.codegen.generators.ModuleGenerator;
import software.amazon.smithy.ruby.codegen.generators.PaginatorsGenerator;
import software.amazon.smithy.ruby.codegen.generators.ParamsGenerator;
import software.amazon.smithy.ruby.codegen.generators.TypesGenerator;
import software.amazon.smithy.ruby.codegen.generators.ValidatorsGenerator;
import software.amazon.smithy.ruby.codegen.generators.WaitersGenerator;
import software.amazon.smithy.ruby.codegen.generators.YardOptsGenerator;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Orchestrates/Directs code generation for Ruby.
 */
@SmithyInternalApi
public class CodegenOrchestrator {

    private static final Logger LOGGER =
            Logger.getLogger(CodegenOrchestrator.class.getName());

    private final GenerationContext context;

    /**
     * @param pluginContext plugin context to generate with.
     */
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
        List<RubyIntegration> integrations = SmithyIntegration.sort(integrationServiceLoader);

        LOGGER.info("Loaded integrations: " + integrations.size());

        Model resolvedModel = pluginContext.getModel();

        for (RubyIntegration integration : integrations) {
            resolvedModel = integration
                    .preprocessModel(resolvedModel, rubySettings);
        }

        ServiceShape service =
                resolvedModel.expectShape(rubySettings.getService())
                        .asServiceShape().orElseThrow(
                        () -> new CodegenException("Shape is not a service"));

        // Add unique operation input/output shapes
        resolvedModel = ModelTransformer.create()
                .createDedicatedInputAndOutput(resolvedModel, "Input", "Output");

        // Now that service and model are resolved, filter integrations for the service
        final Model finalResolvedModel = resolvedModel;
        integrations = integrations.stream()
                .filter((integration) -> integration
                        .includeFor(service, finalResolvedModel))
                .collect(Collectors.toList());

        Set<ShapeId> supportedProtocols = new HashSet<>();
        for (RubyIntegration integration : integrations) {
            supportedProtocols.addAll(
                    integration.getProtocolGenerators()
                            .stream()
                            .map(ProtocolGenerator::getProtocol)
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
            ProtocolGenerator.resolve(protocol, integrations);

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

        // TODO: Apply CodeInterceptors (where?)

        SymbolProvider symbolProvider = new RubySymbolProvider(resolvedModel, rubySettings);

        for (RubyIntegration integration : integrations) {
            symbolProvider = integration.decorateSymbolProvider(resolvedModel, rubySettings, symbolProvider);
        }

        Set<RubyDependency> rubyDependencies = new HashSet<>();
        rubyDependencies.addAll(rubySettings.getBaseDependencies());
        rubyDependencies.addAll(
                integrations.stream()
                        .map((integration) -> integration
                                .additionalGemDependencies(rubySettings, finalResolvedModel, service, protocol))
                        .flatMap(Collection::stream)
                        .collect(Collectors.toSet())
        );
        protocolGenerator.ifPresent((g) -> rubyDependencies.addAll(
                g.additionalGemDependencies(rubySettings, finalResolvedModel, service, protocol))
        );

        context = new GenerationContext(
                rubySettings,
                pluginContext.getFileManifest(),
                integrations,
                resolvedModel,
                service,
                protocol,
                protocolGenerator,
                applicationTransport,
                rubyDependencies,
                symbolProvider
        );
    }

    /**
     * Execute code generation.
     */
    public void execute() {
        // Integration hook - processFinalizedModel
        context.integrations().forEach(
                (integration) -> integration.processFinalizedModel(context));

        generateModule();
        generateGemSpec();
        generateYardOpts();

        generateTypes();
        generateParams();
        generateValidators();

        generateConfigAndClient();

        if (context.protocolGenerator().isPresent()) {
            ProtocolGenerator protocolGenerator =
                    context.protocolGenerator().get();

            protocolGenerator.generateBuilders(context);
            protocolGenerator.generateParsers(context);
            protocolGenerator.generateErrors(context);
            protocolGenerator.generateStubs(context);
        }

        generateWaiters();
        generatePaginators();

        generateProtocolTests();

        // Integration hook - customize
        context.integrations().forEach(
                (integration) -> integration.customize(context));
    }

    private void generateModule() {
        List<String> additionalFiles = context.integrations().stream()
                .map((integration) -> integration.writeAdditionalFiles(context))
                .flatMap(Collection::stream)
                .collect(Collectors.toList());
        context.protocolGenerator().ifPresent((g) -> additionalFiles.addAll(g.writeAdditionalFiles(context)));
        ModuleGenerator moduleGenerator = new ModuleGenerator(context);
        moduleGenerator.render(additionalFiles);
        LOGGER.info("generated module");
    }

    private void generateGemSpec() {
        new GemspecGenerator(context).render();
        LOGGER.info("generated .gemspec");
    }

    private void generateYardOpts() {
        new YardOptsGenerator(context).render();
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

    private void generateConfigAndClient() {
        // Register all middleware
        MiddlewareBuilder middlewareBuilder = new MiddlewareBuilder();
        middlewareBuilder.addDefaultMiddleware(context);

        context.integrations().forEach((integration) -> {
            integration.modifyClientMiddleware(middlewareBuilder, context);
        });

        context.protocolGenerator().ifPresent((g) -> g.modifyClientMiddleware(middlewareBuilder, context));

        // get all config
        Set<ClientConfig> unorderedConfig = new HashSet<>();
        context.applicationTransport().getClientConfig().forEach((c) -> c.addToConfigCollection(unorderedConfig));
        middlewareBuilder.getClientConfig(context).forEach((c) -> c.addToConfigCollection(unorderedConfig));

        context.integrations().forEach((i) -> {
            i.getAdditionalClientConfig(context).forEach((c) -> c.addToConfigCollection(unorderedConfig));
        });
        context.protocolGenerator().ifPresent((g) -> {
            g.getAdditionalClientConfig(context).forEach((c) -> c.addToConfigCollection(unorderedConfig));
        });

        List<ClientConfig> clientConfigList = unorderedConfig.stream()
                .sorted(Comparator.comparing(ClientConfig::getName))
                .collect(Collectors.toList());

        LOGGER.fine("Client config: "
                + clientConfigList.stream().map((m) -> m.toString()).collect(Collectors.joining(",")));

        ConfigGenerator configGenerator = new ConfigGenerator(context);
        configGenerator.render(clientConfigList);
        configGenerator.renderRbs();
        LOGGER.info("generated config");

        ClientGenerator clientGenerator = new ClientGenerator(context);
        clientGenerator.render(middlewareBuilder);
        clientGenerator.renderRbs();
        LOGGER.info("generated client");
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

    private void generateProtocolTests() {
        if (context.applicationTransport().isHttpTransport()) {
            HttpProtocolTestGenerator testGenerator =
                    new HttpProtocolTestGenerator(context);
            testGenerator.render();
            LOGGER.info("generated protocol tests");
        }
    }
}
