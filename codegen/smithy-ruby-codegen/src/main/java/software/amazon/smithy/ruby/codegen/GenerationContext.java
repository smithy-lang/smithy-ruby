package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;

import java.util.List;
import java.util.Optional;

public class GenerationContext {

    private final RubySettings rubySettings;
    private final FileManifest fileManifest;
    private final List<RubyIntegration> integrations;
    private Model model;
    private ServiceShape service;
    private ShapeId protocol;
    private Optional<ProtocolGenerator> protocolGenerator;
    private ApplicationTransport applicationTransport;

    public GenerationContext(RubySettings rubySettings, FileManifest fileManifest,
                             List<RubyIntegration> integrations, Model model,
                             ServiceShape service, ShapeId protocol,
                             Optional<ProtocolGenerator> protocolGenerator, ApplicationTransport applicationTransport) {

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

    public ShapeId getProtocol() {
        return protocol;
    }

    public Optional<ProtocolGenerator> getProtocolGenerator() { return protocolGenerator; }
}
