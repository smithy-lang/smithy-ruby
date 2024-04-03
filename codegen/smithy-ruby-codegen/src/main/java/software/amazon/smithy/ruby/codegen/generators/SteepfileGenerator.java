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

public class SteepfileGenerator {
    private GenerationContext context;

    public SteepfileGenerator(GenerationContext context) {
        this.context = context;
    }

    public void render() {
        FileManifest fileManifest = context.fileManifest();
        RubyCodeWriter writer = new RubyCodeWriter(context.settings().getModule());

        writer
                .preamble()
                .write("D = Steep::Diagnostic")
                .write("")
                .openBlock("target :app do")
                .write("library 'hearth'")
                .write("signature 'sig'")
                .write("")
                .write("configure_code_diagnostics(D::Ruby.strict)")
                .closeBlock("end");

        String fileName = context.settings().getGemName() + "/Steepfile";
        fileManifest.writeFile(fileName, writer.toString());
    }
}
