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

package software.amazon.smithy.ruby.codegen.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.WriteAdditionalFiles;

public final class RubySource {
    private RubySource() {
    }

    /**
     * Creates a WriteAdditionalFiles that writes a ruby source file.
     * @param rubyFile the path to the ruby source file.
     * @param destPath the destination path inside the generated gem to write the file to.
     * @return the WriteAdditionalFiles.
     */
    public static WriteAdditionalFiles rubySource(String rubyFile, String destPath) {
        return (context) -> {
            String gemName = context.settings().getGemName();
            String gemModule = context.settings().getModule();

            try {
                Path path = Paths.get(rubyFile);
                String relativeName = destPath + path.getFileName();
                String fileName = gemName + "/lib/" + gemName + "/" + relativeName;
                String fileContent =
                        new String(Files.readAllBytes(path), StandardCharsets.UTF_8);

                RubyCodeWriter writer = new RubyCodeWriter(gemModule);
                writer
                        .preamble()
                        .openBlock("module $L", gemModule)
                        .write(fileContent)
                        .closeBlock("end");

                context.fileManifest().writeFile(fileName, writer.toString());
                return Collections.singletonList(relativeName);
            } catch (IOException e) {
                throw new CodegenException(
                        "Error reading rubySource file: " + rubyFile,
                        e);
            }
        };
    }
}
