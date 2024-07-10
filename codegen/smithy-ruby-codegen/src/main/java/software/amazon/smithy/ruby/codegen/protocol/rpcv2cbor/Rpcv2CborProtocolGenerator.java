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

package software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor;

import java.util.List;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.protocol.traits.Rpcv2CborTrait;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators.BuilderGenerator;
import software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators.ErrorsGenerator;
import software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators.ParserGenerator;
import software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators.StubsGenerator;

/**
 * Protocol implementation for Rpcv2Cbor.
 */
public class Rpcv2CborProtocolGenerator implements ProtocolGenerator {
    @Override
    public ShapeId getProtocol() {
        return Rpcv2CborTrait.ID;
    }

    @Override
    public ApplicationTransport getEventStreamTransport(ServiceShape service, Model model) {
        Rpcv2CborTrait protocolTrait = service.expectTrait(Rpcv2CborTrait.class);
        List<String> eventStreamHttp = protocolTrait.getEventStreamHttp();
        if (!eventStreamHttp.isEmpty() && eventStreamHttp.get(0).equals("h2")) {
            return ApplicationTransport.createDefaultHttp2ApplicationTransport();
        } else {
            return ApplicationTransport.createDefaultHttpApplicationTransport();
        }
    }

    @Override
    public void generateBuilders(GenerationContext context) {
        new BuilderGenerator(context).render(context.fileManifest());
    }

    @Override
    public void generateParsers(GenerationContext context) {
        new ParserGenerator(context).render(context.fileManifest());
    }

    @Override
    public void generateErrors(GenerationContext context) {
        new ErrorsGenerator(context).render(context.fileManifest());
    }

    @Override
    public void generateStubs(GenerationContext context) {
        new StubsGenerator(context).render(context.fileManifest());
    }
}
