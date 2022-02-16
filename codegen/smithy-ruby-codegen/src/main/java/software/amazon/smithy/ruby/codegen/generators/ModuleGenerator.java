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
import java.util.logging.Logger;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ModuleGenerator {
    private static final Logger LOGGER =
            Logger.getLogger(ModuleGenerator.class.getName());

    private final GenerationContext context;

    public ModuleGenerator(GenerationContext context) {
        this.context = context;
    }

    public void render(List<String> additionalFiles) {
        FileManifest fileManifest = context.getFileManifest();
        RubySettings settings = context.getRubySettings();
        RubyCodeWriter writer = new RubyCodeWriter();

        writer.writePreamble();

        writer.write("require 'hearth'\n");

        String[] requires = {
                "builders", "client", "errors", "parsers", "types",
                "params", "validators", "stubs", "waiters", "paginators"
        };

        for (String require : requires) {
            writer.write("require_relative '$L/$L'", settings.getGemName(),
                    require);
        }

        for (String require : additionalFiles) {
            writer.write("require_relative '$L'", require);
            LOGGER.finer("Adding additional module require: " + require);
        }

        writer.write("");

        writer.openBlock("module $L", settings.getModule())
                .write("GEM_VERSION = '$L'", settings.getGemVersion())
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/lib/" + settings.getGemName() + ".rb";

        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote module file to " + fileName);
    }
}
