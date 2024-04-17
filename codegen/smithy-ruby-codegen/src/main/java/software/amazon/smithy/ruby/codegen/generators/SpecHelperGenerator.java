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

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;

public class SpecHelperGenerator {
    private final GenerationContext context;

    public SpecHelperGenerator(GenerationContext context) {
        this.context = context;
    }

    public void render() {
        FileManifest fileManifest = context.fileManifest();
        RubyCodeWriter writer = new RubyCodeWriter(context.settings().getModule());

        writer
                .preamble()
                .call(() -> context.integrations().forEach(i -> i.writeAdditionalSpecHelper(writer)))
                .write("$$:.unshift(File.expand_path('../lib', __dir__))")
                .write("")
                .write("require '$L'\n", context.settings().getGemName())
                .write("require 'rspec'")
                .write("");

        String fileName = context.settings().getGemName() + "/spec/spec_helper.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

}
