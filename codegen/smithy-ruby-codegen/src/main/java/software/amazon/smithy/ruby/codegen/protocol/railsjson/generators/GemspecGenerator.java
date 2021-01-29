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

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class GemspecGenerator {

    private final RubySettings settings;

    public GemspecGenerator(RubySettings settings) {
        this.settings = settings;
    }

    public void render(FileManifest fileManifest) {
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .openBlock("Gem::Specification.new do |spec|")
                .write("spec.name          = '$L'", settings.getGemName())
                .write("spec.version       = '$L'", settings.getGemVersion())
                .write("spec.author        = 'Amazon Web Services'")
                .write("spec.summary       = '$L'", settings.getGemSummary())
                .write("spec.files         = Dir['lib/**/*.rb']")
                .write("")
                .write("spec.add_runtime_dependency 'seahorse', '~> 1'")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/" + settings.getGemName() + ".gemspec";

        fileManifest.writeFile(fileName, writer.toString());
    }
}
