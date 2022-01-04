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

import java.util.List;
import java.util.Optional;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * The context for code generation.
 * Includes all objects required for generators
 * to render code including the transformed model,
 * loaded integrations, service, ect.
 */
@SmithyUnstableApi
public class GenerationContext {

    private final RubySettings rubySettings;
    private final FileManifest fileManifest;
    private final List<RubyIntegration> integrations;
    private final Model model;
    private final ServiceShape service;
    private final ShapeId protocol;
    private final Optional<ProtocolGenerator> protocolGenerator;
    private final ApplicationTransport applicationTransport;

    public GenerationContext(RubySettings rubySettings,
                             FileManifest fileManifest,
                             List<RubyIntegration> integrations, Model model,
                             ServiceShape service, ShapeId protocol,
                             Optional<ProtocolGenerator> protocolGenerator,
                             ApplicationTransport applicationTransport) {

        this.rubySettings = rubySettings;
        this.fileManifest = fileManifest;
        this.integrations = integrations;
        this.model = model;
        this.service = service;
        this.protocol = protocol;
        this.protocolGenerator = protocolGenerator;
        this.applicationTransport = applicationTransport;
    }

    public RubySettings getRubySettings() {
        return rubySettings;
    }

    public FileManifest getFileManifest() {
        return fileManifest;
    }

    public List<RubyIntegration> getIntegrations() {
        return integrations;
    }

    public Model getModel() {
        return model;
    }

    public ServiceShape getService() {
        return service;
    }

    public ApplicationTransport getApplicationTransport() {
        return applicationTransport;
    }

    public ShapeId getProtocol() {
        return protocol;
    }

    public Optional<ProtocolGenerator> getProtocolGenerator() {
        return protocolGenerator;
    }

}
