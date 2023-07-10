package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.traits.RequestCompressionTrait;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.ConfigProviderChain;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareBuilder;

public class RequestCompression implements RubyIntegration {
    @Override
    public boolean includeFor(ServiceShape service, Model model) {
        return model.isTraitApplied(RequestCompressionTrait.class);
    }

    @Override
    public void modifyClientMiddleware(MiddlewareBuilder middlewareBuilder, GenerationContext context){
        ClientConfig disableRequestCompression = (new ClientConfig.Builder())
                .name("disable_request_compression")
                .type("Boolean")
                .defaultValue("false")
                .documentation("When set to 'true' the request body will not be compressed for supported operations.")
                .allowOperationOverride()
                .defaults( new ConfigProviderChain.Builder()
                        .envProvider("DISABLE_REQUEST_COMPRESSION", "Boolean")
                        .staticProvider("false")
                        .build())
                .build();

        String minCompressionDocumentation = """
                The minimum size bytes that triggers compression for request bodies.
                The value must be non-negative integer value between 0 and 10485780 bytes inclusive.
                """;

        ClientConfig requestMinCompressionSizeBytes = (new ClientConfig.Builder ())
                .name("request_min_compression_size_bytes")
                .type("Integer")
                .defaultValue("10240")
                .documentation(minCompressionDocumentation)
                .allowOperationOverride()
                .defaults( new ConfigProviderChain.Builder()
                        .envProvider("REQUEST_MIN_COMPRESSION_SIZE_BYTES", "Integer")
                        .staticProvider("10240")
                        .build())
                .build();
    }
}
