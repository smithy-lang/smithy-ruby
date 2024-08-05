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

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.EventHeaderTrait;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpPrefixHeadersTrait;
import software.amazon.smithy.model.traits.HttpQueryParamsTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpResponseCodeTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.model.traits.SparseTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.generators.RestParserGeneratorBase;
import software.amazon.smithy.ruby.codegen.traits.NoSerializeTrait;
import software.amazon.smithy.ruby.codegen.util.TimestampFormat;

/**
 * ParserGenerator for RailsJson.
 */
public class ParserGenerator extends RestParserGeneratorBase {

    /**
     * @param context generation context
     */
    public ParserGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    protected void renderBodyParser(Shape outputShape) {
        List<MemberShape> parseMembers = parseMembers(outputShape.members());

        if (!parseMembers.isEmpty()) {
            writer.write("map = $T.parse(http_resp.body.read)", Hearth.JSON);
            renderMemberParsers(parseMembers);
        }
    }

    @Override
    protected void renderMapParseMethod(MapShape s) {
        writer
                .openBlock("def self.parse(map)")
                .write("data = {}")
                .openBlock("map.map do |key, value|")
                .call(() -> {
                    Shape valueTarget = model.expectShape(s.getValue().getTarget());
                    valueTarget
                            .accept(new MemberDeserializer(s.getValue(),
                                    "data[key] = ", "value",
                                    !s.hasTrait(SparseTrait.class)));
                })
                .closeBlock("end")
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderListParseMethod(ListShape s) {
        writer
                .openBlock("def self.parse(list)")
                .openBlock("list.map do |value|")
                .call(() -> {
                    Shape memberTarget =
                            model.expectShape(s.getMember().getTarget());
                    memberTarget
                            .accept(new MemberDeserializer(s.getMember(),
                                    "", "value",
                                    !s.hasTrait(SparseTrait.class)));
                })
                .closeBlock("end")
                .closeBlock("end");
    }

    @Override
    protected void renderStructureParseMethod(StructureShape s) {
        List<MemberShape> parseMembers = parseMembers(s.members());

        writer
                .openBlock("def self.parse(map)")
                .write("data = Types::$L.new", symbolProvider.toSymbol(s).getName())
                .call(() -> renderMemberParsers(parseMembers))
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderUnionParseMethod(UnionShape s) {
        writer
                .openBlock("def self.parse(map)")
                .write("key, value = map.flatten")
                .write("return nil if key.nil?\n")
                .write("case key")
                .call(() -> {
                    s.members().forEach((member) -> {
                        writer
                                .write("when '$L'", unionMemberDataName(s, member))
                                .indent()
                                .call(() -> {
                                    renderUnionMemberParser(s, member);
                                })
                                .write("$T.new(value) if value", context.symbolProvider().toSymbol(member))
                                .dedent();
                    });
                })
                .openBlock("else")
                .write("$T::Unknown.new(name: key, value: value)", context.symbolProvider().toSymbol(s))
                .closeBlock("end") // end of case
                .closeBlock("end");
    }

    @Override
    protected void renderEventImplicitStructurePayloadParser(StructureShape event) {
        List<MemberShape> parseMembers = parseMembers(event.members());
        writer
                .write("map = $T.parse(payload)", Hearth.JSON)
                .call(() -> renderMemberParsers(parseMembers));
    }

    @Override
    protected void renderEventExplicitStructurePayloadParser(MemberShape payloadMember, StructureShape shape) {
        String dataName = symbolProvider.toMemberName(payloadMember);
        String dataSetter = "data." + dataName + " = ";
        String valueGetter = "map";
        writer
                .write("map = $T.decode(payload.force_encoding(Encoding::BINARY))", Hearth.CBOR)
                .call(() -> shape.accept(
                        new MemberDeserializer(payloadMember, dataSetter, valueGetter, false)));
    }

    private String unionMemberDataName(UnionShape s, MemberShape member) {
        String dataName = RubyFormatter.toSnakeCase(symbolProvider.toMemberName(member));
        String jsonName = dataName;
        if (member.hasTrait(JsonNameTrait.class)) {
            jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
        }
        return jsonName;
    }

    private void renderUnionMemberParser(UnionShape s, MemberShape member) {
        Shape target = model.expectShape(member.getTarget());
        target.accept(new UnionMemberDeserializer(member, "value = ", "value", false));
    }

    @Override
    protected void renderPayloadBodyParser(Shape outputShape, MemberShape payloadMember, Shape target) {
        if (target.hasTrait(StreamingTrait.class)) {
            renderStreamingBodyParser(outputShape);
        } else {
            String dataName = symbolProvider.toMemberName(payloadMember);
            String dataSetter = "data." + dataName + " = ";
            target.accept(new PayloadMemberDeserializer(dataSetter));
        }
    }

    private void renderMemberParsers(List<MemberShape> parseMembers) {
        parseMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());
            String dataName = symbolProvider.toMemberName(member);
            String dataSetter = "data." + dataName + " = ";
            String jsonName = RubyFormatter.toSnakeCase(member.getMemberName());
            if (member.hasTrait(JsonNameTrait.class)) {
                jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
            }

            String valueGetter = "map['" + jsonName + "']";
            target.accept(new MemberDeserializer(member, dataSetter, valueGetter, !member.hasTrait(SparseTrait.class)));
        });
    }

    private List<MemberShape> parseMembers(Collection<MemberShape> members) {
        return members.stream()
                .filter((m) -> !m.hasTrait(HttpHeaderTrait.class) && !m.hasTrait(HttpPrefixHeadersTrait.class)
                        && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait(HttpQueryParamsTrait.class)
                        && !m.hasTrait(HttpResponseCodeTrait.class) && !m.hasTrait(EventHeaderTrait.class))
                .filter(NoSerializeTrait.excludeNoSerializeMembers())
                .collect(Collectors.toList());
    }

    private class MemberDeserializer extends ShapeVisitor.Default<Void> {

        private final String jsonGetter;
        private final String dataSetter;
        private final MemberShape memberShape;
        private final boolean checkRequired;

        MemberDeserializer(MemberShape memberShape,
                           String dataSetter, String jsonGetter, boolean checkRequired) {
            this.jsonGetter = jsonGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
            this.checkRequired = checkRequired;
        }

        private String checkRequired() {
            if (this.checkRequired) {
                return " unless " + jsonGetter + ".nil?";
            } else {
                return "";
            }
        }

        /**
         * For simple shapes, just copy to the data.
         */
        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L$L", dataSetter, jsonGetter, checkRequired());
            return null;
        }

        private void rubyFloat() {
            writer.write("$L$T.deserialize($L)$L",
                    dataSetter, Hearth.NUMBER_HELPER, jsonGetter, checkRequired());
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            rubyFloat();
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            rubyFloat();
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("$1L$3T::decode64($2L) unless $2L.nil?",
                    dataSetter, jsonGetter, RubyImportContainer.BASE64);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$L$L if $L", dataSetter,
                    TimestampFormat.parseTimestamp(
                            shape, memberShape, jsonGetter, TimestampFormatTrait.Format.DATE_TIME),
                    jsonGetter);
            return null;
        }

        /**
         * For complex shapes, simply delegate to their builder.
         */
        private void defaultComplexDeserializer(Shape shape) {
            if (checkRequired) {
                writer.write("$1LParsers::$2L.parse($3L) unless $3L.nil?",
                        dataSetter, symbolProvider.toSymbol(shape).getName(),
                        jsonGetter);
            } else {
                writer.write("$1L(Parsers::$2L.parse($3L) unless $3L.nil?)",
                        dataSetter, symbolProvider.toSymbol(shape).getName(),
                        jsonGetter);
            }
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

    private class UnionMemberDeserializer extends MemberDeserializer {
        UnionMemberDeserializer(MemberShape memberShape, String dataSetter, String jsonGetter, boolean checkRequired) {
            super(memberShape, dataSetter, jsonGetter, checkRequired);
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }
    }

    private class PayloadMemberDeserializer extends ShapeVisitor.Default<Void> {

        private final String dataSetter;

        PayloadMemberDeserializer(String dataSetter) {
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
        public Void documentShape(DocumentShape shape) {
            writer
                    .write("payload = $T.parse(http_resp.body.read)", Hearth.JSON)
                    .write("$Lpayload", dataSetter);
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
                    .write("map = $T.parse(http_resp.body.read)", Hearth.JSON)
                    .write("$LParsers::$L.parse(map)", dataSetter, symbolProvider.toSymbol(shape).getName());
        }

    }
}
