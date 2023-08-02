/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */
/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen.generators;

import java.util.HashSet;
import java.util.Set;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyDependency;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
/**
 * Generate a ruby Gemspec.
 */
public class GemspecGenerator {

    private final GenerationContext context;

    /**
     * @param context generation context
     */
    public GemspecGenerator(GenerationContext context) {
        this.context = context;
    }

    /**
     * Render/Generate the Gemspec.
     */
    public void render() {
        FileManifest fileManifest = context.fileManifest();
        RubySettings settings = context.settings();
        RubyCodeWriter writer = new RubyCodeWriter(context.settings().getModule());

        writer
                .includePreamble()
                .openBlock("Gem::Specification.new do |spec|")
                .write("spec.name          = '$L'", settings.getGemName())
                .write("spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip")
                .write("spec.author        = 'Amazon Web Services'")
                .write("spec.summary       = '$L'", settings.getGemSummary())
                .write("spec.files         = Dir['lib/**/*.rb', 'VERSION']")
                .write("")
                .call(() -> {
                    // determine set of indirect dependencies - covered by requiring another
                    Set<RubyDependency> indirectDependencies = new HashSet<>();
                    context.getRubyDependencies().forEach(rubyDependency -> {
                        indirectDependencies.addAll(rubyDependency.getRubyDependencies());
                    });

                    context.getRubyDependencies().forEach((rubyDependency -> {
                        if (rubyDependency.getType() != RubyDependency.Type.STANDARD_LIBRARY
                                && !indirectDependencies.contains(rubyDependency)) {
                            writer.write("spec.add_runtime_dependency '$L', '$L'",
                                    rubyDependency.getGemName(), rubyDependency.getVersion());
                        }
                    }));
                })
                .closeBlock("end");

        String fileName = settings.getGemName() + "/" + settings.getGemName()
                + ".gemspec";

        fileManifest.writeFile(fileName, writer.toString());
    }
}
