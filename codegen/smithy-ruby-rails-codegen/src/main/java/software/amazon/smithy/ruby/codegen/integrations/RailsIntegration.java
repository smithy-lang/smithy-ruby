package software.amazon.smithy.ruby.codegen.integrations;

import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubyIntegration;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.RailsJsonGenerator;

import java.util.Arrays;
import java.util.List;

// Provide support for generating SDKs for Rails (RailsJson)
public class RailsIntegration implements RubyIntegration {

    @Override
    public List<ProtocolGenerator> getProtocolGenerators() {
        return Arrays.asList(new RailsJsonGenerator());
    }
}
