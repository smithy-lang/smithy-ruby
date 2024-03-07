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

import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import software.amazon.smithy.build.SmithyBuildException;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.WriteAdditionalFiles;
import software.amazon.smithy.utils.IoUtils;

public final class RubySource {
    private RubySource() {
    }

    /**
     * Creates a WriteAdditionalFiles that writes a ruby source file.  Ruby source files should be placed
     * in a `ruby` directory in your resources, eg: `src/main/resources/ruby/middleware/my_middleware.rb'.
     * Do not include the `ruby/` prefix in the `rubyFile` path.
     *
     * @param rubyFile the path to the ruby source file in resources.
     *                 Do not including the leading `ruby/`, it will be added.
     * @param destPath the destination path inside the generated gem to write the file to.
     * @return the WriteAdditionalFiles.
     */
    public static WriteAdditionalFiles rubySource(String rubyFile, String destPath) {
        return (context) -> {
            String gemName = context.settings().getGemName();
            String gemModule = context.settings().getModule();

            Path path = Paths.get(rubyFile);
            String relativeName = Paths.get(destPath, path.getFileName().toString()).toString();
            String fileName = Paths.get(gemName, "lib", gemName, relativeName).toString();

            String resourcePath = Paths.get("ruby", rubyFile).toString();
            InputStream io = RubySource.class.getClassLoader().getResourceAsStream(resourcePath);
            if (io == null) {
                throw new SmithyBuildException("Unable to find rubySource file in resources: " + resourcePath);
            }
            String fileContent = IoUtils.toUtf8String(io);

            RubyCodeWriter writer = new RubyCodeWriter(gemModule);
            writer
                    .preamble()
                    .openBlock("module $L", gemModule)
                    .write(fileContent)
                    .closeBlock("end");

            context.fileManifest().writeFile(fileName, writer.toString());
            return Collections.singletonList(relativeName);
        };
    }
}
