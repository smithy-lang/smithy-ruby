package software.amazon.smithy.ruby.codegen.integrations;

import java.util.Arrays;
import java.util.List;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubyIntegration;
import software.amazon.smithy.ruby.codegen.protocol.railsjson.RailsJsonGenerator;

// Provide support for generating SDKs for Rails (RailsJson)
public class RailsIntegration implements RubyIntegration {

    @Override
    public List<ProtocolGenerator> getProtocolGenerators() {
        return Arrays.asList(new RailsJsonGenerator());
    }
}
