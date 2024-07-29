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

package software.amazon.smithy.ruby.codegen.protocol;

import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.protocol.generators.BuilderGenerator;
import software.amazon.smithy.ruby.codegen.protocol.generators.ErrorsGenerator;
import software.amazon.smithy.ruby.codegen.protocol.generators.ParserGenerator;
import software.amazon.smithy.ruby.codegen.protocol.generators.StubsGenerator;
import software.amazon.smithy.ruby.codegen.traits.TestProtocolTrait;
import software.amazon.smithy.utils.SmithyInternalApi;


/**
 * Protocol Implementation for testProtocol - used by the whitelabel codegen-test.
 */
@SmithyInternalApi
public class TestProtocolGenerator implements ProtocolGenerator {
    @Override
    public ShapeId getProtocol() {
        return TestProtocolTrait.ID;
    }

    @Override
    public ApplicationTransport getApplicationTransport() {
        return ApplicationTransport.createDefaultHttpApplicationTransport();
    }

    @Override
    public void generateBuilders(GenerationContext context) {
        (new BuilderGenerator(context)).render(context.fileManifest());
    }

    @Override
    public void generateParsers(GenerationContext context) {
        (new ParserGenerator(context)).render(context.fileManifest());
    }

    @Override
    public void generateErrors(GenerationContext context) {
        ErrorsGenerator errorsGenerator = new ErrorsGenerator(context);
        FileManifest fileManifest = context.fileManifest();
        errorsGenerator.render(fileManifest);
        errorsGenerator.renderRbs(fileManifest);
    }

    @Override
    public void generateStubs(GenerationContext context) {
        (new StubsGenerator(context)).render(context.fileManifest());
    }
}
