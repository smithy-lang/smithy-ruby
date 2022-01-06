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

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import java.util.Optional;
import java.util.stream.Stream;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.model.traits.MediaTypeTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.generators.HttpStubsGeneratorBase;
import software.amazon.smithy.ruby.codegen.trait.NoSerializeTrait;

public class StubsGenerator extends HttpStubsGeneratorBase {

    public StubsGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    protected void renderNoPayloadBodyStub(OperationShape operation, Shape outputShape) {
        writer
                .write("http_resp.headers['Content-Type'] = 'application/json'")
                .call(() -> renderMemberStubbers(outputShape))
                .write("http_resp.body = StringIO.new(Seahorse::JSON.dump(data))");
    }

    @Override
    protected void renderPayloadBodyStub(OperationShape operation, Shape outputShape, MemberShape payloadMember,
                                         Shape target) {
        String symbolName = ":" + symbolProvider.toMemberName(payloadMember);
        String inputGetter = "stub[" + symbolName + "]";
        target.accept(new PayloadMemberSerializer(payloadMember, inputGetter));
    }

    @Override
    protected void renderStructureMemberStubbers(StructureShape shape) {
        renderMemberStubbers(shape);
    }

    @Override
    protected void renderUnionMemberStubbers(UnionShape shape) {
        shape.members().forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());

            String symbolName = RubyFormatter.asSymbol(symbolProvider.toMemberName(member));
            String dataName = RubyFormatter.asSymbol(member.getMemberName());
            if (member.hasTrait(JsonNameTrait.class)) {
                dataName = "'" + member.expectTrait(JsonNameTrait.class).getValue() + "'";
            }
            String dataSetter = "data[" + dataName + "] = ";
            String inputGetter = "stub[" + symbolName + "]";
            target.accept(new MemberSerializer(member, dataSetter, inputGetter, true));
        });
    }

    @Override
    protected void renderListMemberStub(ListShape shape) {
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        memberTarget
                .accept(new MemberSerializer(shape.getMember(),
                        "data << ", "element", false));
    }

    @Override
    protected void renderSetMemberStub(SetShape shape) {
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        memberTarget
                .accept(new MemberSerializer(shape.getMember(),
                        "data << ", "element", false));
    }

    @Override
    protected void renderMapMemberStub(MapShape shape) {
        Shape valueTarget = model.expectShape(shape.getValue().getTarget());
        valueTarget
                .accept(new MemberSerializer(shape.getValue(), "data[key] = ",
                        "value", false));
    }

    private void renderMemberStubbers(Shape s) {
        Optional<MemberShape> payload =
                s.members().stream().filter((m) -> m.hasTrait(HttpPayloadTrait.class)).findFirst();

        if (payload.isPresent()) {
            MemberShape member = payload.get();
            Shape target = model.expectShape(member.getTarget());
            String symbolName = ":" + symbolProvider.toMemberName(member);
            String inputGetter = "stub[" + symbolName + "]";
            target.accept(new MemberSerializer(member, "data = ", inputGetter, true));
            writer.write("data ||= {}");
        } else {
            //remove members w/ http traits or marked NoSerialize
            Stream<MemberShape> serializeMembers = s.members().stream()
                    .filter((m) -> !m.hasTrait(HttpLabelTrait.class) && !m.hasTrait(HttpQueryTrait.class)
                            && !m.hasTrait((HttpHeaderTrait.class)));
            serializeMembers = serializeMembers.filter(NoSerializeTrait.excludeNoSerializeMembers());

            serializeMembers.forEach((member) -> {
                Shape target = model.expectShape(member.getTarget());

                String symbolName = ":" + symbolProvider.toMemberName(member);
                String dataName = RubyFormatter.asSymbol(member.getMemberName());
                if (member.hasTrait(JsonNameTrait.class)) {
                    dataName = "'" + member.expectTrait(JsonNameTrait.class).getValue() + "'";
                }
                String dataSetter = "data[" + dataName + "] = ";
                String inputGetter = "stub[" + symbolName + "]";
                target.accept(new MemberSerializer(member, dataSetter, inputGetter, true));
            });
        }
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

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("$LBase64::encode64($L)$L", dataSetter, inputGetter, checkRequired());
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // the default protocol format is date_time
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write("$LSeahorse::TimeHelper.to_epoch_seconds($L)$L", dataSetter, inputGetter,
                                checkRequired());
                        break;
                    case HTTP_DATE:
                        writer.write("$LSeahorse::TimeHelper.to_http_date($L)$L", dataSetter, inputGetter,
                                checkRequired());
                        break;
                    case DATE_TIME:
                    default:
                        writer.write("$LSeahorse::TimeHelper.to_date_time($L)$L", dataSetter, inputGetter,
                                checkRequired());
                        break;
                }
            } else {
                writer.write("$LSeahorse::TimeHelper.to_date_time($L)$L", dataSetter, inputGetter,
                        checkRequired());
            }
            return null;
        }

        /**
         * For complex shapes, simply delegate to their Stubber.
         */
        private void defaultComplexSerializer(Shape shape) {
            writer.write("$LStubs::$L.stub($L)$L", dataSetter, symbolProvider.toSymbol(shape).getName(), inputGetter,
                    checkRequired());
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
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

    private class PayloadMemberSerializer extends ShapeVisitor.Default<Void> {

        private final MemberShape memberShape;
        private final String inputGetter;

        PayloadMemberSerializer(MemberShape memberShape, String inputGetter) {
            this.memberShape = memberShape;
            this.inputGetter = inputGetter;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer
                    .write("http_resp.headers['Content-Type'] = 'text/plain'")
                    .write("http_resp.body = StringIO.new($L || '')", inputGetter);
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            Optional<MediaTypeTrait> mediaTypeTrait = shape.getTrait(MediaTypeTrait.class);
            String mediaType = "application/octet-stream";
            if (mediaTypeTrait.isPresent()) {
                mediaType = mediaTypeTrait.get().getValue();
            }

            writer
                    .write("http_resp.headers['Content-Type'] = '$L'", mediaType)
                    .write("http_resp.body = StringIO.new($L || '')", inputGetter);
            return null;
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

        private void defaultComplexSerializer(Shape shape) {
            writer
                    .write("http_resp.headers['Content-Type'] = 'application/json'")
                    .write("data = Stubs::$1L.stub($2L) unless $2L.nil?", symbolProvider.toSymbol(shape).getName(),
                            inputGetter)
                    .write("http_resp.body = StringIO.new(Seahorse::JSON.dump(data))");
        }

    }

}


