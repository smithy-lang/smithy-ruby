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

import software.amazon.smithy.gradle.tasks.SmithyBuild
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.node.Node
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.utils.CaseUtils


extra["displayName"] = "Smithy :: Ruby :: Codegen :: Test"
extra["moduleName"] = "software.amazon.smithy.ruby.codegen.test"

tasks["jar"].enabled = false

plugins {
    id("software.amazon.smithy").version("0.5.3")
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
}

repositories {
    mavenLocal()
    mavenCentral()
}

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        "classpath"("software.amazon.smithy:smithy-cli:${rootProject.extra["smithyVersion"]}")
    }
}

dependencies {
    implementation(project(":smithy-ruby-codegen"))
    implementation(project(":smithy-ruby-codegen-test-utils"))
    implementation("software.amazon.smithy:smithy-protocol-tests:${rootProject.extra["smithyVersion"]}")
}

class ServiceDefinition(val file: File) {
    val model: Model
    val service: ServiceShape
    val moduleName: String
    val gemName: String
    val projectionName: String

    init {
        model = Model.assembler()
                .addImport(file.absolutePath)
                // Grab the result directly rather than worrying about checking for errors via unwrap.
                // All we care about here is the service shape, any unchecked errors will be exposed
                // as part of the actual build task done by the smithy gradle plugin.
                .assemble().result.get()
        val services = model.shapes(ServiceShape::class.javaObjectType).sorted().toList()
        if (services.size != 1) {
            throw Exception("There must be exactly one service in each test model file, but found " +
                    "${services.size} in ${file.name}: ${services.map { it.id }}")
        }
        service = services[0]

        moduleName = CaseUtils.toPascalCase(file.name.split(".")[0])
        gemName = moduleName.toLowerCase()

        projectionName = file.name.split(".")[0]
    }
}

fun forEachTestService(task: (service: ServiceDefinition) -> Unit) {
    val modelsDir = "model/test-services"
    val models = project.file(modelsDir)

    fileTree(models).filter { it.isFile }.files.forEach eachFile@{ file ->
        val service = ServiceDefinition(file)
        task(service)
    }
}

// Generates a smithy-build.json file by creating a new projection for every
// JSON file found in models/test-services. The generated smithy-build.json file is
// not committed to git since it's rebuilt each time codegen is performed.
tasks.register("generate-smithy-build") {
    doLast {
        val projectionsBuilder = Node.objectNodeBuilder()
        val modelsDir = "model/test-services"
        val models = project.file(modelsDir)

        forEachTestService { service ->
            val projectionContents = Node.objectNodeBuilder()
                    .withMember("imports", Node.fromStrings("${models.absolutePath}${File.separator}${service.file.name}"))
                    .withMember(
                            "plugins",
                            Node.objectNode()
                                    .withMember(
                                            "ruby-codegen",
                                            Node.objectNodeBuilder()
                                                    .withMember("service", service.service.id.toString())
                                                    .withMember("module", service.moduleName)
                                                    .withMember(
                                                            "gemspec",
                                                            Node.objectNodeBuilder()
                                                                    .withMember("gemName", service.gemName)
                                                                    .withMember("gemVersion", "1.0.0")
                                                                    .withMember("gemSummary", "Test service used to run smithy test cases")
                                                                    .build()
                                                    ).build()
                                    )
                    )
                    .withMember(
                            "transforms",
                            Node.arrayNode(
                                    Node.objectNodeBuilder()
                                            .withMember("name", "endpointTestService")
                                            .build()
                            )
                    ).build()
            projectionsBuilder.withMember(service.projectionName, projectionContents)
        }

        // merge projections from the base build file
        val baseBuild = Node.parse(file("base-smithy-build.json").readText())
        baseBuild.expectObjectNode().expectObjectMember("projections").members.forEach { (k, v) -> projectionsBuilder.withMember(k, v) }

        file("smithy-build.json").writeText(Node.prettyPrintJson(Node.objectNodeBuilder()
                .withMember("version", "1.0")
                .withMember("projections", projectionsBuilder.build())
                .build()))
    }
}


tasks.register<Copy>("copyWhiteLabelGem") {
    mustRunAfter("copyIntegrationSpecs")
    from("$buildDir/smithyprojections/smithy-ruby-codegen-test/white-label/ruby-codegen")
    into("$buildDir/../../projections/")
}

tasks.register<Copy>("copyRpcv2CborGem") {
    mustRunAfter("copyIntegrationSpecs")
    from("$buildDir/smithyprojections/smithy-ruby-codegen-test/rpcv2cbor/ruby-codegen")
    into("$buildDir/../../projections/")
}

tasks.register<Delete>("cleanProjections") {
    delete("$buildDir/../../projections/white_label/")
    delete("$buildDir/../../projections/rpcv2_cbor/")
}

tasks.register<Copy>("copyIntegrationSpecs") {
    from("./integration-specs")
    into("$buildDir/smithyprojections/smithy-ruby-codegen-test/white-label/ruby-codegen/white_label/spec")
}

tasks["smithyBuildJar"].enabled = false

tasks.create<SmithyBuild>("buildSdk") {
    addRuntimeClasspath = true
}.dependsOn(tasks["generate-smithy-build"])

tasks["build"]
        .dependsOn(
                tasks["cleanProjections"],
                tasks["buildSdk"])
        .finalizedBy(
                tasks["copyIntegrationSpecs"],
                tasks["copyWhiteLabelGem"],
                tasks["copyRpcv2CborGem"]
        )
java.sourceSets["main"].java {
    srcDirs("model", "src/main/smithy")
}
