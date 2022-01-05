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

package software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol;

import java.util.logging.Logger;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.generators.BuilderGenerator;
import software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.generators.ErrorsGenerator;
import software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.generators.ParserGenerator;
import software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.generators.StubsGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;


/**
 * Protocol Implementation for fakeProtocol - used by the whitelabel codegen-test.
 */
@SmithyInternalApi
public class FakeProtocolGenerator implements ProtocolGenerator {
    private static final Logger LOGGER = Logger.getLogger(FakeProtocolGenerator.class.getName());

    @Override
    public ShapeId getProtocol() {
        return ShapeId.from("smithy.ruby.tests.protocols#fakeProtocol");
    }

    @Override
    public ApplicationTransport getApplicationTransport() {
        return ApplicationTransport.createDefaultHttpApplicationTransport();
    }

    @Override
    public void generateBuilders(GenerationContext context) {
        (new BuilderGenerator(context)).render(context.getFileManifest());
    }

    @Override
    public void generateParsers(GenerationContext context) {
        (new ParserGenerator(context)).render(context.getFileManifest());
    }

    @Override
    public void generateErrors(GenerationContext context) {
        ErrorsGenerator errorsGenerator = new ErrorsGenerator(context);
        FileManifest fileManifest = context.getFileManifest();
        errorsGenerator.render(fileManifest);
        errorsGenerator.renderRbs(fileManifest);
    }

    @Override
    public void generateStubs(GenerationContext context) {
        (new StubsGenerator(context)).render(context.getFileManifest());
    }
}
