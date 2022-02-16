/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

import java.util.List;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyDependency;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class GemspecGenerator {

    private final GenerationContext context;

    public GemspecGenerator(GenerationContext context) {
        this.context = context;
    }

    public void render(List<RubyDependency> additionalDependencies) {
        FileManifest fileManifest = context.getFileManifest();
        RubySettings settings = context.getRubySettings();
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .writePreamble()
                .openBlock("Gem::Specification.new do |spec|")
                .write("spec.name          = '$L'", settings.getGemName())
                .write("spec.version       = '$L'", settings.getGemVersion())
                .write("spec.author        = 'Amazon Web Services'")
                .write("spec.summary       = '$L'", settings.getGemSummary())
                .write("spec.files         = Dir['lib/**/*.rb']")
                .write("")
                .write("spec.add_runtime_dependency 'hearth', '~> 1.0.0.pre1'")
                // TODO: Add additionalDependencies!
                .closeBlock("end");

        String fileName = settings.getGemName() + "/" + settings.getGemName()
                + ".gemspec";

        fileManifest.writeFile(fileName, writer.toString());
    }
}
