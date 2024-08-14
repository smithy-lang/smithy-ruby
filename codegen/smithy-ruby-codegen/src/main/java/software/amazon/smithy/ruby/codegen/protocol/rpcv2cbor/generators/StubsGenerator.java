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

package software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators;

import java.util.Optional;
import java.util.stream.Stream;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.model.traits.HttpErrorTrait;
import software.amazon.smithy.model.traits.SparseTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.generators.StubsGeneratorBase;
import software.amazon.smithy.ruby.codegen.traits.NoSerializeTrait;

public class StubsGenerator extends StubsGeneratorBase {

    public StubsGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    protected void renderUnionStubMethod(UnionShape shape) {
        writer
                .openBlock("def self.stub(stub)")
                .write("data = {}")
                .write("case stub");

        shape.members().forEach((member) -> {
            writer
                    .write("when $T", context.symbolProvider().toSymbol(member))
                    .indent();
            renderUnionMemberStubber(shape, member);
            writer.dedent();
        });
        writer.openBlock("else")
                .write("raise ArgumentError,\n\"Expected input to be one of the subclasses of $T\"",
                        context.symbolProvider().toSymbol(shape))
                .closeBlock("end")
                .write("")
                .write("data")
                .closeBlock("end");
    }

    private void renderUnionMemberStubber(UnionShape shape, MemberShape member) {
        Shape target = model.expectShape(member.getTarget());
        String symbolName = "'" + member.getMemberName() + "'";
        String dataSetter = "data[" + symbolName + "] = ";
        target.accept(new MemberSerializer(member, dataSetter, "stub.__getobj__", false));
    }

    @Override
    protected void renderListStubMethod(ListShape shape) {
        writer
                .openBlock("def self.stub(stub)")
                .write("stub ||= []")
                .write("data = []")
                .openBlock("stub.each do |element|")
                .call(() -> {
                    Shape memberTarget =
                            model.expectShape(shape.getMember().getTarget());
                    memberTarget
                            .accept(new MemberSerializer(shape.getMember(), "data << ", "element", !shape.hasTrait(
                                    SparseTrait.class)));
                })
                .closeBlock("end")
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderMapStubMethod(MapShape shape) {
        writer
                .openBlock("def self.stub(stub)")
                .write("stub ||= {}")
                .write("data = {}")
                .openBlock("stub.each do |key, value|")
                .call(() -> {
                    Shape valueTarget = model.expectShape(shape.getValue().getTarget());
                    valueTarget
                            .accept(new MemberSerializer(
                                    shape.getValue(), "data[key] = ",
                                    "value", !shape.hasTrait(SparseTrait.class)));
                })
                .closeBlock("end")
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderStructureStubMethod(StructureShape shape) {
        writer
                .openBlock("def self.stub(stub)")
                .write("stub ||= $T.new", context.symbolProvider().toSymbol(shape))
                .write("data = {}")
                .call(() -> renderMemberStubbers(shape))
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderOperationStubMethod(OperationShape operation, Shape outputShape) {
        writer
                .openBlock("def self.stub(http_resp, stub:)")
                .write("data = {}")
                .call(() -> renderMemberStubbers(outputShape))
                .write("http_resp.body = $T.new($T.encode(data))",
                        RubyImportContainer.STRING_IO, Hearth.CBOR)
                .write("http_resp.status = 200")
                .closeBlock("end");
    }

    @Override
    protected void renderErrorStubMethod(Shape errorShape) {
        writer
                .openBlock("def self.stub(http_resp, stub:)")
                .call(() -> renderStatusCodeStubber(errorShape))
                .write("data = {}")
                .write("data['__type'] = '$L'", errorShape.toShapeId().getName())
                .call(() -> renderMemberStubbers(errorShape))
                .write("http_resp.body = $T.new($T.encode(data))", RubyImportContainer.STRING_IO, Hearth.CBOR)
                .closeBlock("end");
    }

    protected void renderStatusCodeStubber(Shape errorShape) {
        String statusCode = "";
        Optional<HttpErrorTrait> optionalHttpErrorTrait = errorShape.getTrait(HttpErrorTrait.class);
        if (optionalHttpErrorTrait.isPresent()) {
            statusCode = Integer.toString(optionalHttpErrorTrait.get().getCode());
        } else {
            ErrorTrait errorTrait = errorShape.getTrait(ErrorTrait.class).get();
            if (errorTrait.isClientError()) {
                statusCode = "400";
            } else if (errorTrait.isServerError()) {
                statusCode = "500";
            }
        }

        this.writer.write("http_resp.status = $1L", statusCode);
    }

    private void renderMemberStubbers(Shape s) {
        renderMemberStubbers(s, "stub");
    }

    private void renderMemberStubbers(Shape s, String input) {
        //remove members w/ http traits or marked NoSerialize
        Stream<MemberShape> serializeMembers = s.members().stream()
                .filter(NoSerializeTrait.excludeNoSerializeMembers());

        serializeMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());
            String dataName = "'" + member.getMemberName() + "'";
            String dataSetter = "data[" + dataName + "] = ";
            String inputGetter = input + "." + symbolProvider.toMemberName(member);
            target.accept(new MemberSerializer(member, dataSetter, inputGetter, true));
        });
    }

    @Override
    protected void renderEventPayloadStructureStub(StructureShape eventPayload) {
        writer
                .write("message.headers[':content-type'] = "
                       + "Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')")
                .write("data = {}")
                .call(() -> renderMemberStubbers(eventPayload, "payload_stub"))
                .write("message.payload = $T.new($T.encode(data))",
                        RubyImportContainer.STRING_IO, Hearth.CBOR);
    }

    private class MemberSerializer extends ShapeVisitor.Default<Void> {

        private final MemberShape memberShape;
        private final String inputGetter;
        private final String dataSetter;
        private final boolean checkRequired;


        MemberSerializer(MemberShape memberShape,
                         String dataSetter, String inputGetter, boolean checkRequired) {
            this.memberShape = memberShape;
            this.inputGetter = inputGetter;
            this.dataSetter = dataSetter;
            this.checkRequired = checkRequired;
        }

        private String checkRequired() {
            if (this.checkRequired) {
                return " unless " + inputGetter + ".nil?";
            } else {
                return "";
            }
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L$L", dataSetter, inputGetter, checkRequired());
            return null;
        }

        public Void blobShape(BlobShape shape) {
            writer.write("$1L((String === $2L ? $2L : $2L.read).encode(Encoding::BINARY))$3L",
                    dataSetter, inputGetter, checkRequired());
            return null;
        }

        /**
         * For complex shapes, simply delegate to their Stubber.
         */
        private void defaultComplexSerializer(Shape shape) {
            if (checkRequired) {
                writer.write("$1L$2L.stub($3L) unless $3L.nil?", dataSetter,
                        symbolProvider.toSymbol(shape).getName(), inputGetter);
            } else {
                writer.write("$1L($2L.stub($3L) unless $3L.nil?)", dataSetter,
                        symbolProvider.toSymbol(shape).getName(), inputGetter);
            }
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }
    }
}



