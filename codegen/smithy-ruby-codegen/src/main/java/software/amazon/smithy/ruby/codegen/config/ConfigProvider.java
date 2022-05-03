package software.amazon.smithy.ruby.codegen.config;

import java.util.Optional;

public interface ConfigProvider {

    /**
     * @return the provider rendered into Ruby code
     */
    String render();

    /**
     * @return an optional default value to use in documentation.
     */
    default Optional<String> getDocumentationDefault() {
        return Optional.empty();
    }
}
