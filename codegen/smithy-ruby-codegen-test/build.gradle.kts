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

extra["displayName"] = "Smithy :: Ruby :: Codegen :: Test"
extra["moduleName"] = "software.amazon.smithy.ruby.codegen.test"

tasks["jar"].enabled = false

plugins {
    id("software.amazon.smithy").version("0.5.0")
}

repositories {
    mavenLocal()
    mavenCentral()
}

dependencies {
    implementation("software.amazon.smithy:smithy-protocol-test-traits:[1.0.10,1.1.0[")
    implementation(project(":smithy-ruby-codegen"))
    implementation(project(":smithy-ruby-rails-codegen"))
}

tasks.register<Copy>("copyGem") {
    from("$buildDir/smithyprojections/smithy-ruby-codegen-test/sample-service/ruby-codegen")
    into("$buildDir/../../../")
}
tasks.register<Copy>("copyIntegrationSpecs") {
    from("./integration-specs")
    into("$buildDir/smithyprojections/smithy-ruby-codegen-test/sample-service/ruby-codegen/sample_service/spec")
}
tasks["build"].finalizedBy(tasks["copyIntegrationSpecs"], tasks["copyGem"])
