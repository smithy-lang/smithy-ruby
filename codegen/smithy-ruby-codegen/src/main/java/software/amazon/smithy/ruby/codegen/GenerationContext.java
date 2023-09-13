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
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.CodegenContext;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.WriterDelegator;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.auth.AuthScheme;
import software.amazon.smithy.ruby.codegen.auth.factories.AnonymousAuthSchemeFactory;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * The context for code generation.
 * Includes all objects required for generators
 * to render code including the transformed model,
 * loaded integrations, service, ect.
 */
@SmithyUnstableApi
public class GenerationContext implements CodegenContext<RubySettings, RubyCodeWriter, RubyIntegration> {

    private final RubySettings rubySettings;
    private final FileManifest fileManifest;
    private final List<RubyIntegration> integrations;
    private final Model model;
    private final ServiceShape service;
    private final ShapeId protocol;
    private final Optional<ProtocolGenerator> protocolGenerator;
    private final ApplicationTransport applicationTransport;
    private final SymbolProvider symbolProvider;
    private final WriterDelegator<RubyCodeWriter> writerDelegator;

    /**
     * @param rubySettings         ruby settings
     * @param fileManifest         file manifest for generating files
     * @param integrations         loaded RubyIntegrations
     * @param model                model to generate for
     * @param service              service to generate for
     * @param protocol             the protocol to generate for
     * @param protocolGenerator    the resolved protocol generate to use for generation
     * @param applicationTransport resolved application transport.
     * @param symbolProvider       a symbol provider scoped to the Types module
     */
    public GenerationContext(RubySettings rubySettings,
                             FileManifest fileManifest,
                             List<RubyIntegration> integrations,
                             Model model,
                             ServiceShape service,
                             ShapeId protocol,
                             Optional<ProtocolGenerator> protocolGenerator,
                             ApplicationTransport applicationTransport,
                             SymbolProvider symbolProvider) {

        this.rubySettings = rubySettings;
        this.fileManifest = fileManifest;
        this.integrations = integrations;
        this.model = model;
        this.service = service;
        this.protocol = protocol;
        this.protocolGenerator = protocolGenerator;
        this.applicationTransport = applicationTransport;
        this.symbolProvider = symbolProvider;
        this.writerDelegator = new WriterDelegator<>(fileManifest, symbolProvider, new RubyCodeWriter.Factory());
    }

    @Override
    public Model model() {
        return model;
    }

    @Override
    public RubySettings settings() {
        return rubySettings;
    }

    @Override
    public SymbolProvider symbolProvider() {
        return symbolProvider;
    }

    @Override
    public FileManifest fileManifest() {
        return fileManifest;
    }

    @Override
    public WriterDelegator<RubyCodeWriter> writerDelegator() {
        return writerDelegator;
    }

    /**
     * @return list of integrations loaded
     */
    public List<RubyIntegration> integrations() {
        return integrations;
    }

    /**
     * @return service being generated for.
     */
    public ServiceShape service() {
        return service;
    }

    /**
     * @return the resolved ApplicationTransport
     */
    public ApplicationTransport applicationTransport() {
        return applicationTransport;
    }

    /**
     * @return the resolved protocol
     */
    public ShapeId protocol() {
        return protocol;
    }

    /**
     * @return resolved generator for the protocol.
     */
    public Optional<ProtocolGenerator> protocolGenerator() {
        return protocolGenerator;
    }

    /**
     * @return Set of RubyDependencies from the base and all integrations
     */
    public Set<RubyDependency> getRubyDependencies() {
        Set<RubyDependency> rubyDependencies = new HashSet<>();
        rubyDependencies.addAll(settings().getBaseDependencies());
        rubyDependencies.addAll(
                integrations.stream()
                        .map((integration) -> integration.getAdditionalGemDependencies(this))
                        .flatMap(Collection::stream)
                        .collect(Collectors.toSet())
        );
        return Collections.unmodifiableSet(rubyDependencies);
    }

    /**
     * @return Set of all RubyRuntimePlugins from all integrations
     */
    public Set<RubyRuntimePlugin> getRuntimePlugins() {
        return integrations.stream()
                .map((i) -> i.getRuntimePlugins(this))
                .flatMap(List::stream)
                .collect(Collectors.toUnmodifiableSet());
    }

    /**
     * @return Set of all AuthSchemes from all integrations and the application transport.
     */
    public Set<AuthScheme> getAuthSchemes() {
        Set<AuthScheme> authSchemes = new HashSet<>(applicationTransport.defaultAuthSchemes());
        authSchemes.add(AnonymousAuthSchemeFactory.build());
        integrations().forEach((i) -> {
            i.getAdditionalAuthSchemes(this).forEach((s) -> authSchemes.add(s));
        });
        return Collections.unmodifiableSet(authSchemes);
    }
}
