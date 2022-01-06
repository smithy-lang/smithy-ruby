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
import software.amazon.smithy.model.traits.HttpPrefixHeadersTrait;
import software.amazon.smithy.model.traits.HttpQueryParamsTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.model.traits.MediaTypeTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.generators.HttpBuilderGeneratorBase;
import software.amazon.smithy.ruby.codegen.trait.NoSerializeTrait;


public class BuilderGenerator extends HttpBuilderGeneratorBase {

    public BuilderGenerator(GenerationContext context) {
        super(context);
    }

    private void renderMemberBuilders(Shape s) {
        //remove members w/ http traits or marked NoSerialize
        Stream<MemberShape> serializeMembers = s.members().stream()
                .filter((m) -> !m.hasTrait(HttpLabelTrait.class) && !m.hasTrait(HttpQueryTrait.class)
                        && !m.hasTrait(HttpHeaderTrait.class) && !m.hasTrait(HttpPrefixHeadersTrait.class)
                        && !m.hasTrait(HttpQueryParamsTrait.class));
        serializeMembers = serializeMembers.filter(NoSerializeTrait.excludeNoSerializeMembers());

        serializeMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());

            String symbolName = ":" + symbolProvider.toMemberName(member);
            String dataName = RubyFormatter.asSymbol(member.getMemberName());
            if (member.hasTrait(JsonNameTrait.class)) {
                dataName = "'" + member.expectTrait(JsonNameTrait.class).getValue() + "'";
            }
            if (member.hasTrait("smithy.ruby.protocols#nestedAttributes")) {
                dataName = dataName + "_attributes";
            }

            String dataSetter = "data[" + dataName + "] = ";
            String inputGetter = "input[" + symbolName + "]";
            target.accept(new MemberSerializer(member, dataSetter, inputGetter, true));
        });
    }

    @Override
    protected void renderPayloadBodyBuilder(OperationShape operation, Shape inputShape, MemberShape payloadMember,
                                            Shape target) {
        String symbolName = ":" + symbolProvider.toMemberName(payloadMember);
        String inputGetter = "input[" + symbolName + "]";
        target.accept(new PayloadMemberSerializer(payloadMember, inputGetter));
    }

    @Override
    protected void renderNoPayloadBodyBuilder(OperationShape operation, Shape inputShape) {
        writer
                .write("")
                .write("http_req.headers['Content-Type'] = 'application/json'")
                .write("data = {}")
                .call(() -> renderMemberBuilders(inputShape))
                .write("http_req.body = StringIO.new(Seahorse::JSON.dump(data))");
    }

    @Override
    protected void renderStructureMemberBuilders(StructureShape shape) {
        renderMemberBuilders(shape);
    }

    @Override
    protected void renderListMemberBuilder(ListShape shape) {
        Shape memberTarget = model.expectShape(shape.getMember().getTarget());
        memberTarget.accept(new MemberSerializer(shape.getMember(), "data << ", "element",
                false));
    }

    @Override
    protected void renderUnionMemberBuilder(UnionShape shape, MemberShape member) {
        Shape target = model.expectShape(member.getTarget());
        String symbolName = RubyFormatter.asSymbol(symbolProvider.toMemberName(member));
        String dataSetter = "data[" + symbolName + "] = ";
        target.accept(new MemberSerializer(member, dataSetter, "input", false));
    }

    @Override
    protected void renderMapMemberBuilder(MapShape shape) {
        Shape valueTarget = model.expectShape(shape.getValue().getTarget());
        valueTarget.accept(new MemberSerializer(shape.getValue(), "data[key] = ", "value",
                false));
    }

    @Override
    protected void renderSetMemberBuilder(SetShape shape) {
        Shape memberTarget = model.expectShape(shape.getMember().getTarget());
        memberTarget.accept(new MemberSerializer(shape.getMember(), "data << ", "element",
                false));

    }

    private class MemberSerializer extends ShapeVisitor.Default<Void> {

        private final String inputGetter;
        private final String dataSetter;
        private final MemberShape memberShape;
        private final boolean checkRequired;

        MemberSerializer(MemberShape memberShape,
                         String dataSetter, String inputGetter, boolean checkRequired) {
            this.inputGetter = inputGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
            this.checkRequired = checkRequired;
        }

        private String checkRequired(Shape shape) {
            if (this.checkRequired) {
                return " unless " + inputGetter + ".nil?";
            } else {
                return "";
            }
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L$L", dataSetter, inputGetter, checkRequired(shape));
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("$LBase64::encode64($L).strip$L", dataSetter, inputGetter, checkRequired(shape));
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
                                checkRequired(shape));
                        break;
                    case HTTP_DATE:
                        writer.write("$LSeahorse::TimeHelper.to_http_date($L)$L", dataSetter, inputGetter,
                                checkRequired(shape));
                        break;
                    case DATE_TIME:
                    default:
                        writer.write("$LSeahorse::TimeHelper.to_date_time($L)$L", dataSetter, inputGetter,
                                checkRequired(shape));
                        break;
                }
            } else {
                writer.write("$LSeahorse::TimeHelper.to_date_time($L)$L", dataSetter, inputGetter,
                        checkRequired(shape));
            }
            return null;
        }

        /**
         * For complex shapes, simply delegate to their builder.
         */
        private void defaultComplexSerializer(Shape shape) {
            writer.write("$LBuilders::$L.build($L)$L", dataSetter, symbolProvider.toSymbol(shape).getName(),
                    inputGetter,
                    checkRequired(shape));
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            writer.write("$LBuilders::$L.build($L).to_a$L", dataSetter, symbolProvider.toSymbol(shape).getName(),
                    inputGetter,
                    checkRequired(shape));
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
                    .write("http_req.headers['Content-Type'] = 'text/plain'")
                    .write("http_req.body = StringIO.new($L || '')", inputGetter);
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
                    .write("http_req.headers['Content-Type'] = '$L'", mediaType)
                    .write("http_req.body = StringIO.new($L || '')", inputGetter);
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
                    .write("http_req.headers['Content-Type'] = 'application/json'")
                    .write("data = Builders::$1L.build($2L) unless $2L.nil?", symbolProvider.toSymbol(shape).getName(),
                            inputGetter)
                    .write("http_req.body = StringIO.new(Seahorse::JSON.dump(data))");
        }

    }

}


