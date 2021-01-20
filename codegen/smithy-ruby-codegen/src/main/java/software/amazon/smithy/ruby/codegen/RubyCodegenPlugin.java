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
import software.amazon.smithy.model.knowledge.OperationIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.ErrorTrait;
// import software.amazon.smithy.ruby.codegen.generators.BuilderGenerator;
import software.amazon.smithy.ruby.codegen.generators.ClientGenerator;
import software.amazon.smithy.ruby.codegen.generators.ErrorsGenerator;
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
        Stream<StructureShape> structureShapeStream = model.shapes(StructureShape.class);
        TypesGenerator typesGenerator = new TypesGenerator(rubySettings, structureShapeStream);
        typesGenerator.render(fileManifest);
        LOGGER.info("created types");

        Stream<OperationShape> operationShapeStream = model.shapes(OperationShape.class);
        ClientGenerator clientGenerator = new ClientGenerator(rubySettings, operationShapeStream);
        clientGenerator.render(fileManifest);
        LOGGER.info("created client");

        Stream<Shape> errorShapeStream = model.shapes().filter((s) -> s.hasTrait(ErrorTrait.class));
        ErrorsGenerator errorsGenerator = new ErrorsGenerator(rubySettings, errorShapeStream);
        errorsGenerator.render(fileManifest);
        LOGGER.info("created errors");

        ServiceShape serviceShape = model.getShape(rubySettings.getService()).get().asServiceShape().get();
        Stream<Shape> shapes = new Walker(model).walkShapes(serviceShape).stream();
        // BuilderGenerator builderGenerator = new BuilderGenerator(rubySettings, shapes);
        LOGGER.info("created builders");
    }
}

