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

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class ModuleGenerator {
    private final RubySettings settings;

    public ModuleGenerator(RubySettings settings) {
        this.settings = settings;
    }

    public void render(FileManifest fileManifest) {
        RubyCodeWriter writer = new RubyCodeWriter();

        writer.write("require 'seahorse'\n");

        String[] requires = {"builders", "client", "errors", "parsers", "types"};

        for (String require : requires) {
            writer.write("require_relative '$L/$L'", settings.getGemName(), require);
        }

        writer.write("");

        writer.openBlock("module $L", settings.getModule())
                .write("GEM_VERSION = '$L'", settings.getGemVersion())
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + ".rb";

        fileManifest.writeFile(fileName, writer.toString());
    }
}
