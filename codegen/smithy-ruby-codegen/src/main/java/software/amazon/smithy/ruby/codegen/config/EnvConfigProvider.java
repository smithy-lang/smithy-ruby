package software.amazon.smithy.ruby.codegen.config;

public class EnvConfigProvider implements ConfigProvider {
    private final String environmentKey;
    private final String type;

    public EnvConfigProvider(String environmentKey, String type) {
        this.environmentKey = environmentKey;
        this.type = type;
    }

    @Override
    public String render() {
        return "Hearth::Config::EnvProvider.new(" + environmentKey + ", type: '" + type + "')";
    }
}
