package software.amazon.smithy.ruby.codegen.integrations;

import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubyIntegration;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.RailsJsonGenerator;

import java.util.Arrays;
import java.util.List;

public class RailsIntegration implements RubyIntegration {
    @Override
    public Byte getOrder() {
        return 0;
    }

    @Override
    public List<ProtocolGenerator> getProtocolGenerators() {
        return Arrays.asList(new RailsJsonGenerator());
    }

    @Override
    public Model preprocessModel(PluginContext context, Model model, RubySettings settings) {
        return model;
    }
}
