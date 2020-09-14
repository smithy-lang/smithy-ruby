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

import java.util.logging.Logger;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.build.SmithyBuildPlugin;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.ruby.codegen.generators.GemspecGenerator;
import software.amazon.smithy.ruby.codegen.generators.ModuleGenerator;
import software.amazon.smithy.ruby.codegen.generators.TypesGenerator;

public final class RubyCodegenPlugin implements SmithyBuildPlugin {
    private static final Logger LOGGER = Logger.getLogger(RubyCodegenPlugin.class.getName());

    @Override
    public String getName() {
        return "ruby-codegen";
    }

    @Override
    public void execute(PluginContext context) {
        RubySettings rubySettings = RubySettings.from(context.getSettings());
        FileManifest fileManifest = context.getFileManifest();

        GemspecGenerator gemspecGenerator = new GemspecGenerator(rubySettings);
        gemspecGenerator.render(fileManifest);
        LOGGER.info("wrote .gemspec");

        ModuleGenerator moduleGenerator = new ModuleGenerator(rubySettings);
        moduleGenerator.render(fileManifest);
        LOGGER.info("created module");

        Model model = context.getModelWithoutTraitShapes();
        Stream<StructureShape> shapes = model.shapes(StructureShape.class);
        TypesGenerator typesGenerator = new TypesGenerator(rubySettings, shapes);
        typesGenerator.render(fileManifest);
        LOGGER.info("created types");
    }
}

