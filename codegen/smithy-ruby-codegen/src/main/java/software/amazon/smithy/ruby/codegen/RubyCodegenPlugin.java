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
import software.amazon.smithy.build.PluginContext;
import software.amazon.smithy.build.SmithyBuildPlugin;

public final class RubyCodegenPlugin implements SmithyBuildPlugin {
    private static final Logger LOGGER =
            Logger.getLogger(RubyCodegenPlugin.class.getName());

    @Override
    public String getName() {
        return "ruby-codegen";
    }

    @Override
    public void execute(PluginContext context) {
        (new CodegenOrchestrator(context)).execute();
//
//        RubySettings rubySettings = RubySettings.from(context.getSettings());
//        FileManifest fileManifest = context.getFileManifest();
//
//        GemspecGenerator gemspecGenerator = new GemspecGenerator(rubySettings);
//        gemspecGenerator.render(fileManifest);
//        LOGGER.info("wrote .gemspec");
//
//        ModuleGenerator moduleGenerator = new ModuleGenerator(rubySettings);
//        moduleGenerator.render(fileManifest);
//        LOGGER.info("created module");
//
//        Model model = context.getModelWithoutTraitShapes();
//        Stream<StructureShape> structureShapeStream = model.shapes(StructureShape.class);
//        TypesGenerator typesGenerator = new TypesGenerator(rubySettings, structureShapeStream);
//        typesGenerator.render(fileManifest);
//        LOGGER.info("created types");
//
//        Stream<OperationShape> operationShapeStream = model.shapes(OperationShape.class);
//        ClientGenerator clientGenerator = new ClientGenerator(rubySettings, operationShapeStream);
//        clientGenerator.render(fileManifest);
//        LOGGER.info("created client");
//
//        Stream<Shape> errorShapeStream = model.shapes().filter((s) -> s.hasTrait(ErrorTrait.class));
//        ErrorsGenerator errorsGenerator = new ErrorsGenerator(rubySettings, errorShapeStream);
//        errorsGenerator.render(fileManifest);
//        LOGGER.info("created errors");
//
//        BuilderGenerator builderGenerator = new BuilderGenerator(rubySettings, model);
//        builderGenerator.render(fileManifest);
//        LOGGER.info("created builders");
//
//        System.out.println("\n\n----------------------------------\n\n");
//
//        ParserGenerator parserGenerator = new ParserGenerator(rubySettings, model);
//        parserGenerator.render(fileManifest);
//        LOGGER.info("created parsers");
//
//        System.out.println("\n\n----------------------------------\n\n");
    }
}

