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

package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.utils.CodeWriter;

public class GemspecWriter {

    private final RubySettings settings;

    public GemspecWriter(RubySettings settings) {
        this.settings = settings;
    }

    /**
     * Render the Gemspec file.
     *
     * @param fileManifest - FileManifest to write to.
     */
    public void render(FileManifest fileManifest) {
        CodeWriter writer = CodeWriter.createDefault();
        // TODO make a RubyCodeWriter that adds generated warnings
        writer.write(
                "# WARNING ABOUT GENERATED CODE\n"
                + "#\n"
                + "# This file is generated. See the contributing guide for more information:\n"
                + "# https://github.com/aws/aws-sdk-ruby/blob/master/CONTRIBUTING.md\n"
                + "#\n"
                + "# WARNING ABOUT GENERATED CODE\n"
        );
        writer.openBlock("Gem::Specification.new do |spec|")
                .write("spec.name          = '$L'", settings.getGemName())
                .write("spec.version       = '$L'", settings.getGemVersion())
                .write("spec.author        = 'Amazon Web Services'")
                .write("spec.summary       = '$L'", settings.getGemSummary())
                .write("spec.files         = Dir['lib/**/*.rb']")
                .write("spec.add_dependency('aws-sdk-core', '~> 4')")
                .write("spec.add_dependency('aws-sigv4', '~> 2')")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/" + settings.getGemName() + ".gemspec";

        fileManifest.writeFile(fileName, writer.toString());
    }
}
