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
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpPrefixHeadersTrait;
import software.amazon.smithy.model.traits.HttpQueryParamsTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpResponseCodeTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.generators.HttpParserGeneratorBase;
import software.amazon.smithy.ruby.codegen.trait.NoSerializeTrait;

public class ParserGenerator extends HttpParserGeneratorBase {

    public ParserGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    protected void renderNoPayloadBodyParser(Shape outputShape) {
        writer.write("map = Seahorse::JSON.load(http_resp.body)");
        renderMemberParsers(outputShape);
    }

    @Override
    protected void renderStructureMemberParsers(StructureShape s) {
        renderMemberParsers(s);
    }

    @Override
    protected String unionMemberDataName(UnionShape s, MemberShape member) {
        String dataName = RubyFormatter.toSnakeCase(symbolProvider.toMemberName(member));
        String jsonName = dataName;
        if (member.hasTrait(JsonNameTrait.class)) {
            jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
        }
        return jsonName;
    }

    @Override
    protected void renderUnionMemberParser(UnionShape s, MemberShape member) {
        Shape target = model.expectShape(member.getTarget());
        target.accept(new MemberDeserializer(member, "value = ",
                "value"));
    }

    @Override
    protected void renderMapMemberParser(MapShape s) {
        Shape valueTarget = model.expectShape(s.getValue().getTarget());
        valueTarget
                .accept(new MemberDeserializer(s.getValue(), "data[key] = ", "value"));
    }

    @Override
    protected void renderListMemberParser(ListShape s) {
        Shape memberTarget =
                model.expectShape(s.getMember().getTarget());
        memberTarget
                .accept(new MemberDeserializer(s.getMember(), "", "value"));
    }

    @Override
    protected void renderSetMemberParser(SetShape s) {
        Shape memberTarget =
                model.expectShape(s.getMember().getTarget());
        memberTarget
                .accept(new MemberDeserializer(s.getMember(), "", "value"));
    }

    @Override
    protected void renderPayloadBodyParser(Shape outputShape, MemberShape payloadMember, Shape target) {
        String dataName = symbolProvider.toMemberName(payloadMember);
        String dataSetter = "data." + dataName + " = ";
        target.accept(new PayloadMemberDeserializer(payloadMember, dataSetter));
    }


    private void renderMemberParsers(Shape s) {
        Stream<MemberShape> parseMembers = s.members().stream()
                .filter((m) -> !m.hasTrait(HttpHeaderTrait.class) && !m.hasTrait(HttpPrefixHeadersTrait.class)
                        && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait(HttpQueryParamsTrait.class)
                        && !m.hasTrait(HttpResponseCodeTrait.class));
        parseMembers = parseMembers.filter(NoSerializeTrait.excludeNoSerializeMembers());

        parseMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());
            String dataName = symbolProvider.toMemberName(member);
            String dataSetter = "data." + dataName + " = ";
            String jsonName = RubyFormatter.toSnakeCase(member.getMemberName());
            if (member.hasTrait(JsonNameTrait.class)) {
                jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
            }

            String valueGetter = "map['" + jsonName + "']";
            target.accept(new MemberDeserializer(member, dataSetter, valueGetter));
        });
    }


    private class MemberDeserializer extends ShapeVisitor.Default<Void> {

        private final String jsonGetter;
        private final String dataSetter;
        private final MemberShape memberShape;

        MemberDeserializer(MemberShape memberShape,
                           String dataSetter, String jsonGetter) {
            this.jsonGetter = jsonGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
        }

        /**
         * For simple shapes, just copy to the data.
         */
        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L", dataSetter, jsonGetter);
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("$1LBase64::decode64($2L) if $2L", dataSetter, jsonGetter);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // the default protocol format is date_time, which is parsed by Time.parse
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write("$1LTime.at($2L.to_i) if $2L", dataSetter, jsonGetter);
                        break;
                    case HTTP_DATE:
                    case DATE_TIME:
                    default:
                        writer.write("$1LTime.parse($2L) if $2L", dataSetter, jsonGetter);
                        break;
                }
            } else {
                writer.write("$1LTime.parse($2L) if $2L", dataSetter, jsonGetter);
            }
            return null;
        }

        /**
         * For complex shapes, simply delegate to their builder.
         */
        private void defaultComplexDeserializer(Shape shape) {
            writer.write("$1LParsers::$2L.parse($3L) if $3L", dataSetter, symbolProvider.toSymbol(shape).getName(),
                    jsonGetter);
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }
    }

    private class PayloadMemberDeserializer extends ShapeVisitor.Default<Void> {

        private final MemberShape memberShape;
        private final String dataSetter;

        PayloadMemberDeserializer(MemberShape memberShape, String dataSetter) {
            this.memberShape = memberShape;
            this.dataSetter = dataSetter;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer
                    .write("payload = http_resp.body.read")
                    .write("$Lpayload unless payload.empty?", dataSetter);
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer
                    .write("payload = http_resp.body.read")
                    .write("$Lpayload unless payload.empty?", dataSetter);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        private void defaultComplexDeserializer(Shape shape) {
            writer
                    .write("json = Seahorse::JSON.load(http_resp.body)")
                    .write("$LParsers::$L.parse(json)", dataSetter, symbolProvider.toSymbol(shape).getName());
        }

    }
}
