/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0.
 */

package software.amazon.smithy.ruby.codegen

import com.sun.xml.internal.ws.spi.db.BindingContextFactory
import software.amazon.smithy.build.PluginContext
import software.amazon.smithy.build.SmithyBuildPlugin
import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import com.sun.xml.internal.ws.spi.db.BindingContextFactory.LOGGER

import software.amazon.smithy.ruby.codegen.generators.GemspecGenerator
import com.sun.xml.internal.ws.spi.db.BindingContextFactory.LOGGER

import software.amazon.smithy.model.neighbor.Walker

import java.util.stream.Stream

import software.amazon.smithy.model.shapes.ServiceShape

import software.amazon.smithy.ruby.codegen.generators.ErrorsGenerator

import software.amazon.smithy.model.traits.ErrorTrait

import software.amazon.smithy.ruby.codegen.generators.ClientGenerator

import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.Shape

import software.amazon.smithy.ruby.codegen.generators.TypesGenerator

import software.amazon.smithy.model.shapes.StructureShape

import software.amazon.smithy.ruby.codegen.generators.ModuleGenerator


/**
 * Plugin to trigger Ruby code generation.
 */
class RubyCodegenPlugin : SmithyBuildPlugin {
    override fun getName(): String = "ruby-codegen"

    override fun execute(context: PluginContext?) {
        println("\n\n-------------------\nExecuting ruby codegen\n\n")
        val rubySettings = RubySettings.from(context?.settings)
        val fileManifest = context?.fileManifest

        val gemspecGenerator = GemspecGenerator(rubySettings)
        gemspecGenerator.render(fileManifest)

        val moduleGenerator = ModuleGenerator(rubySettings)
        moduleGenerator.render(fileManifest)
        LOGGER.info("created module")

        val model = context!!.modelWithoutTraitShapes
        val structureShapeStream = model.shapes(
            StructureShape::class.java
        )
        val typesGenerator = TypesGenerator(rubySettings, structureShapeStream)
        typesGenerator.render(fileManifest)
        LOGGER.info("created types")

        val operationShapeStream = model.shapes(
            OperationShape::class.java
        )
        val clientGenerator = ClientGenerator(rubySettings, operationShapeStream)
        clientGenerator.render(fileManifest)
        LOGGER.info("created client")

        val errorShapeStream: Stream<Shape> = model.shapes().filter { s: Shape ->
            s.hasTrait(
                ErrorTrait::class.java
            )
        }
        val errorsGenerator = ErrorsGenerator(rubySettings, errorShapeStream)
        errorsGenerator.render(fileManifest)
        LOGGER.info("created errors")

        // val serviceShape = model.getShape(rubySettings.service).get().asServiceShape().get()
        // val shapes: Stream<Shape> = Walker(model).walkShapes(serviceShape).stream()
        // BuilderGenerator builderGenerator = new BuilderGenerator(rubySettings, shapes);
        // BuilderGenerator builderGenerator = new BuilderGenerator(rubySettings, shapes);
        LOGGER.info("created builders")

        println("--------------\nCodeGen Completed!")

    }
}
