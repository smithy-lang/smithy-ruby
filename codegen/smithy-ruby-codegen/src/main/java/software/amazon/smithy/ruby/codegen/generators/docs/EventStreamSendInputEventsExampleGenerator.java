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

package software.amazon.smithy.ruby.codegen.generators.docs;

import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;

public class EventStreamSendInputEventsExampleGenerator {

    private final RubyCodeWriter writer;

    private final GenerationContext context;
    private final OperationShape operation;
    private final Model model;
    private final SymbolProvider symbolProvider;

    public EventStreamSendInputEventsExampleGenerator(GenerationContext context, OperationShape operation) {
        this.context = context;
        this.operation = operation;
        this.model = context.model();
        this.symbolProvider = context.symbolProvider();
        this.writer = new RubyCodeWriter("");
    }

    public String generate() {
        StructureShape inputShape = model.expectShape(operation.getInputShape(), StructureShape.class);

        MemberShape eventMemberShape = inputShape.members()
                .stream()
                .filter(m -> StreamingTrait.isEventStream(model, m))
                .findFirst().get();

        UnionShape eventStreamUnion = model.expectShape(eventMemberShape.getTarget(), UnionShape.class);

        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        writer
                .write("stream = client.$L(params)", operationName)
                .write("# send (signal) input events");

        for (MemberShape eventMember : eventStreamUnion.members()) {
            StructureShape eventShape = model.expectShape(eventMember.getTarget(), StructureShape.class);
            String eventShapeName = symbolProvider.toSymbol(eventShape).getName();
            String operationCall = "stream.signal_%s".formatted(
                    RubyFormatter.toSnakeCase(symbolProvider.toMemberName(eventMember)));
            String exampleCall = new PlaceholderExampleGenerator(eventShape, operationCall, symbolProvider, model)
                    .generate();
            String[] docstringParts = exampleCall.split("\n");
            for (int i = 0; i < docstringParts.length; i++) {
                writer.write("$L", docstringParts[i]);
            }
            writer.write("");
        }

        return writer.toString();
    }
}
