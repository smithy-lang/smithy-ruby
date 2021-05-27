package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.utils.SmithyBuilder;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class ClientConfig {

    private final String name;
    private final String type;
    private final String documentation;
    private final String defaultValue;
    private final String initializationCustomization;
    private final String postInitializeCustomization;

    public ClientConfig(Builder builder) {
        this.name = builder.name;
        this.type = builder.type;
        this.documentation = builder.documentation;
        this.defaultValue = builder.defaultValue;
        this.initializationCustomization = builder.initializationCustomization;
        this.postInitializeCustomization = builder.postInitializeCustomization;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public String getDocumentation() {
        return documentation;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public String getInitializationCustomization() {
        return initializationCustomization;
    }

    public String getPostInitializeCustomization() { return postInitializeCustomization; }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        ClientConfig that = (ClientConfig) o;
        return Objects.equals(getName(), that.getName())
                && Objects.equals(getType(), that.getType());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getName(), getType());
    }

    public static class Builder implements SmithyBuilder<ClientConfig> {
        private String name;
        private String type;
        private String documentation;
        private String defaultValue;
        private String initializationCustomization;
        private String postInitializeCustomization;

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder type(String type) {
            this.type = type;
            return this;
        }

        public Builder documentation(String documentation) {
            this.documentation = documentation;
            return this;
        }

        public Builder defaultValue(String defaultValue) {
            this.defaultValue = defaultValue;
            return this;
        }

        public Builder initializationCustomization(String initializationCustomization) {
            this.initializationCustomization = initializationCustomization;
            return this;
        }

        public Builder postInitializeCustomization(String postInitializeCustomization) {
            this.postInitializeCustomization = postInitializeCustomization;
            return this;
        }


        @Override
        public ClientConfig build() {
            return new ClientConfig(this);
        }
    }

    public static Set<ClientConfig> defaultConfig(GenerationContext context) {
        Set<ClientConfig> configs = new HashSet();

        ClientConfig middleware = (new Builder())
                .name("middleware")
                .type("MiddlewareBuilder")
                .documentation("Additional Middleware to be applied for every operation")
                .initializationCustomization("@middleware = Seahorse::MiddlewareBuilder.new(options[:middleware])")
                .build();

        configs.add(middleware);

        return configs;
    }
}
