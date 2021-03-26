package software.amazon.smithy.ruby.codegen.integrations;

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.ServiceIndex;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.Trait;
import software.amazon.smithy.ruby.codegen.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class RailsLocalRegion implements RubyIntegration {

    @Override
    public boolean includeFor(ServiceShape service, Model model){
        Map<ShapeId, Trait> serviceProtocols = ServiceIndex.of(model).getProtocols(service);

        // return true only if the service is rails
        return serviceProtocols.containsKey(ShapeId.from("smithy.rails#RailsJson"));
    }

    @Override
    public List<ClientConfig> getAdditionalClientConfig() {
        ClientConfig region = (new ClientConfig.Builder())
                .name("region")
                .type("string")
                .defaultValue("'local'")
                .documentation("Provide a region to resolve to an endpoint")
                .postInitializeCustomization("@endpoint ||= RegionResolver.resolve(@region)")
                .build();

        return Collections.singletonList(region);
    }

    @Override
    public List<String> writeAdditionalFiles(GenerationContext context ) {
        FileManifest fileManifest = context.getFileManifest();
        RubySettings settings = context.getRubySettings();
        RubyCodeWriter writer = new RubyCodeWriter();


        writer
                .openBlock("module $L", settings.getModule())
                .write("# A Region resolver for $L", settings.getService().getName())
                .openBlock("class RegionResolver")
                .openBlock("def self.resolve(region)")
                .write("return 'http://127.0.0.1:3000' if region == 'local'")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        String relativeName = settings.getGemName() + "/customizations/region_resolver";
        String fileName = settings.getGemName() + "/lib/" + relativeName + ".rb";
        fileManifest.writeFile(fileName, writer.toString());

        return Collections.singletonList(relativeName);
    }


}
