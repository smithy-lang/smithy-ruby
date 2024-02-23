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

extra["displayName"] = "Smithy :: Ruby :: Rails :: Codegen :: Test"
extra["moduleName"] = "software.amazon.smithy.ruby.rails.codegen.test"

tasks["jar"].enabled = false

plugins {
    id("software.amazon.smithy").version("0.5.3")
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
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
    implementation("software.amazon.smithy:smithy-aws-protocol-tests:${rootProject.extra["smithyVersion"]}")
    implementation(project(":smithy-ruby-codegen"))
    implementation(project(":smithy-ruby-rails-codegen"))
}

tasks.register<Delete>("cleanProjections") {
    delete("$buildDir/../../projections/high_score_service/")
    delete("$buildDir/../../projections/rails_json/")
}
tasks.register<Copy>("copyIntegrationSpecs") {
    from("./integration-specs")
    into("$buildDir/smithyprojections/smithy-ruby-rails-codegen-test/railsjson/ruby-codegen/rails_json/spec")
}
tasks.register<Copy>("copySteepfile") {
    from("./Steepfile")
    into("$buildDir/smithyprojections/smithy-ruby-codegen-test/white-label/ruby-codegen/rails_json")
}
tasks.register<Copy>("copyHighScoreServiceGem") {
    from("$buildDir/smithyprojections/smithy-ruby-rails-codegen-test/high-score-service/ruby-codegen")
    into("$buildDir/../../projections/")
}
tasks.register<Copy>("copyRailsJsonGem") {
    mustRunAfter("copyIntegrationSpecs")
    from("$buildDir/smithyprojections/smithy-ruby-rails-codegen-test/railsjson/ruby-codegen")
    into("$buildDir/../../projections/")
}

tasks["build"].dependsOn(tasks["cleanProjections"])
tasks["build"].finalizedBy(
    tasks["copyIntegrationSpecs"],
    tasks["copySteepfile"],
    tasks["copyHighScoreServiceGem"],
    tasks["copyRailsJsonGem"]
)

java.sourceSets["main"].java {
    srcDirs("model", "src/main/smithy")
}
