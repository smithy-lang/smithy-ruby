package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubySettings;

import java.util.List;

/**
 * JVM SPI for customizing Ruby code generation, registering new protocol
 * generators, renaming shapes, modifying the model, adding custom code, etc
 */
public interface RubyIntegration {

    Byte getOrder();

    List<ProtocolGenerator> getProtocolGenerators();

    Model preprocessModel(PluginContext context, Model model, RubySettings settings);
}
