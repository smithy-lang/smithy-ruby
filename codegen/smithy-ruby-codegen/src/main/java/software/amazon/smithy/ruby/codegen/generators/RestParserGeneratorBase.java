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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.HttpPrefixHeadersTrait;
import software.amazon.smithy.model.traits.HttpResponseCodeTrait;
import software.amazon.smithy.model.traits.MediaTypeTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.util.TimestampFormat;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Base class for Parsers for REST protocols which support HTTP binding traits.
 * <p>
 * Protocols should extend this class to get common functionality -
 * generates the framework and non-protocol specific parts of
 * parsers.rb to handle http binding traits.
 */
@SmithyUnstableApi
public abstract class RestParserGeneratorBase extends ParserGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(RestParserGeneratorBase.class.getName());

    /**
     * @param context generation context
     */
    public RestParserGeneratorBase(GenerationContext context) {
        super(context);
    }

    /**
     * Called to render an operation's body parser when it has a Payload member.
     * The generated code should deserialize the payloadMember from the
     * response body. The skeleton creates a data variable of the Output type.
     * The payload should be deserialzed and its values set onto data.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class HttpPayloadTraits
     *   def self.parse(http_resp)
     *     data = Types::HttpPayloadTraitsOutput.new
     *     #### START code generated by this method
     *     payload = http_resp.body.read
     *     data.blob = payload unless payload.empty?
     *     #### END code generated by this method
     *     data
     *   end
     * end
     * }</pre>
     *
     * @param outputShape   the operation's outputShape
     * @param payloadMember the payload member
     * @param target        the target shape of the paylaod member
     */
    protected abstract void renderPayloadBodyParser(Shape outputShape, MemberShape payloadMember, Shape target);

    /**
     * Called to render an operation's body parser when it does not have a payload member.
     * The skeleton creates a data variable of the output type.
     * The generated code should deserialize all of the appropriate outputShape's members
     * to the data object.  The parsed response body is available in map as a ruby hash.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class JsonEnums
     *   def self.parse(http_resp)
     *     data = Types::JsonEnumsOutput.new
     *     map = Hearth::JSON.load(http_resp.body)
     *     #### START code generated by this method
     *     data.foo_enum1 = map['foo_enum1']
     *     #### END code generated by this method
     *     data
     *   end
     * end
     * }</pre>
     *
     * @param outputShape the operation's outputShape
     */
    protected abstract void renderBodyParser(Shape outputShape);

    @Override
    protected void renderOperationParseMethod(OperationShape operation, Shape outputShape) {

        writer
                .openBlock("def self.parse(http_resp)")
                .write("data = $T.new", context.symbolProvider().toSymbol(outputShape))
                .call(() -> renderHeaderParsers(outputShape))
                .call(() -> renderPrefixHeaderParsers(outputShape))
                .call(() -> renderResponseCodeParser(outputShape))
                .call(() -> renderOperationBodyParser(outputShape))
                .write("data")
                .closeBlock("end");
        LOGGER.finer("Generated parse method for " + operation.getId().getName());
    }

    @Override
    protected void renderErrorParseMethod(Shape s) {
        writer
                .openBlock("def self.parse(http_resp)")
                .write("data = $T.new", context.symbolProvider().toSymbol(s))
                .call(() -> renderHeaderParsers(s))
                .call(() -> renderPrefixHeaderParsers(s))
                .call(() -> renderOperationBodyParser(s))
                .write("data")
                .closeBlock("end");
        LOGGER.finer("Generated Error parser for " + s.getId().getName());
    }

    /**
     * @param outputShape outputShape to render for
     */
    protected void renderHeaderParsers(Shape outputShape) {
        List<MemberShape> headerMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            String symbolName = symbolProvider.toMemberName(m);
            String dataSetter = "data." + symbolName + " = ";
            String valueGetter = "http_resp.headers['" + headerTrait.getValue() + "']";
            model.expectShape(m.getTarget()).accept(new HeaderDeserializer(m, dataSetter, valueGetter));
            LOGGER.finest("Generated header parser for " + m.getMemberName());
        }
    }

    /**
     * @param outputShape outputShape to render for.
     */
    protected void renderPrefixHeaderParsers(Shape outputShape) {
        List<MemberShape> headerMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpPrefixHeadersTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : headerMembers) {
            HttpPrefixHeadersTrait headerTrait = m.expectTrait(HttpPrefixHeadersTrait.class);
            String prefix = headerTrait.getValue();
            // httpPrefixHeaders may only target map shapes
            MapShape targetShape = model.expectShape(m.getTarget(), MapShape.class);
            Shape valueShape = model.expectShape(targetShape.getValue().getTarget());
            String symbolName = symbolProvider.toMemberName(m);

            String dataSetter = "data." + symbolName + "[key.delete_prefix('" + prefix + "')] = ";
            writer
                    .write("data.$L = {}", symbolName)
                    .openBlock("http_resp.headers.each do |key, value|")
                    .openBlock("if key.start_with?('$L')", prefix)
                    .call(() -> valueShape.accept(new HeaderDeserializer(m, dataSetter, "value")))
                    .closeBlock("end")
                    .closeBlock("end");
            LOGGER.finest("Generated prefix header parser for " + m.getMemberName());

        }
    }

    protected void renderResponseCodeParser(Shape outputShape) {
        List<MemberShape> responseCodeMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpResponseCodeTrait.class))
                .collect(Collectors.toList());

        if (responseCodeMembers.size() == 1) {
            MemberShape responseCodeMember = responseCodeMembers.get(0);
            writer.write("data.$L = http_resp.status", symbolProvider.toMemberName(responseCodeMember));
            LOGGER.finest("Generated response code parser for " + responseCodeMember.getMemberName());
        }
    }

    /**
     * The Output shape is combined with the Operation Parser.
     * This generates the parsing of the body as if it was the Parser for the Output
     * @param outputShape outputShape to render for
     */
    protected void renderOperationBodyParser(Shape outputShape) {
        //determine if there is an httpPayload member
        List<MemberShape> httpPayloadMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpPayloadTrait.class))
                .collect(Collectors.toList());

        if (httpPayloadMembers.size() == 0) {
            renderBodyParser(outputShape);
        } else if (httpPayloadMembers.size() == 1) {
            MemberShape payloadMember = httpPayloadMembers.get(0);
            Shape target = model.expectShape(payloadMember.getTarget());
            renderPayloadBodyParser(outputShape, payloadMember, target);
        }
    }

    private class HeaderDeserializer extends ShapeVisitor.Default<Void> {

        private final String valueGetter;
        private final String dataSetter;
        private final MemberShape memberShape;

        HeaderDeserializer(MemberShape memberShape,
                           String dataSetter, String valueGetter) {
            this.valueGetter = valueGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
        }

        /**
         * For simple shapes, just copy to the data.
         */
        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L", dataSetter, valueGetter);
            return null;
        }

        private void rubyFloat() {
            writer.write("$1L$3T.deserialize($2L) unless $2L.nil?",
                    dataSetter, valueGetter, Hearth.NUMBER_HELPER);
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
        public Void booleanShape(BooleanShape shape) {
            writer.write("$1L$2L == 'true' unless $2L.nil?", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("$1L$2L.to_i unless $2L.nil?", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("$1L$2L.to_i unless $2L.nil?", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("$1L$2L.to_i unless $2L.nil?", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("$1L$2L.to_i unless $2L.nil?", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            // string values with a mediaType trait are always base64 encoded.
            if (shape.hasTrait(MediaTypeTrait.class)) {
                writer.write("$1L$3T::decode64($2L).strip unless $2L.nil?", dataSetter, valueGetter,
                        RubyImportContainer.BASE64);
            } else {
                writer.write("$1L$2L", dataSetter, valueGetter);
            }
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$L$L if $L", dataSetter,
                    TimestampFormat.parseTimestamp(
                            shape, memberShape, valueGetter, TimestampFormatTrait.Format.DATE_TIME),
                    valueGetter);
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            writer.openBlock("unless $1L.nil? || $1L.empty?", valueGetter)

                    .call(() -> model.expectShape(shape.getMember().getTarget())
                            .accept(new HeaderListMemberDeserializer(shape.getMember(), valueGetter, dataSetter)))
                    .closeBlock("end");

            return null;
        }
    }

    private class HeaderListMemberDeserializer extends ShapeVisitor.Default<Void> {

        private final MemberShape memberShape;
        private final String valueGetter;
        private final String dataSetter;

        HeaderListMemberDeserializer(MemberShape memberShape, String valueGetter, String dataSetter) {
            this.memberShape = memberShape;
            this.valueGetter = valueGetter;
            this.dataSetter = dataSetter;
        }

        private RubyCodeWriter splitByComma() {
            writer.write("$1L$2L", dataSetter, valueGetter)
                    .indent()
                    .write(".split(', ')");
            return writer;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("$1LHearth::Http::HeaderListParser.parse_string_list($2L)", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            splitByComma()
                    .write(".map { |s| s == 'true' }")
                    .dedent();
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            splitByComma()
                    .write(".map { |s| s.to_i }")
                    .dedent();
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {

            TimestampFormatTrait.Format format = memberShape
                    .getTrait(TimestampFormatTrait.class)
                    .map((t) -> t.getFormat())
                    .orElseGet(() ->
                            shape.getTrait(TimestampFormatTrait.class)
                                    .map((t) -> t.getFormat())
                                    .orElse(TimestampFormatTrait.Format.HTTP_DATE));
            switch (format) {
                case HTTP_DATE:
                    // header timestamps default to rfc822/http-date, which has a comma after day
                    writer.write("$1LHearth::Http::HeaderListParser.parse_http_date_list($2L)",
                                    dataSetter, valueGetter);
                    break;
                default:
                    splitByComma()
                            .write(".map { |s| $L }",
                                    TimestampFormat.parseTimestamp(shape, memberShape, "s",
                                            TimestampFormatTrait.Format.HTTP_DATE))
                            .dedent();
            }
            return null;
        }
    }

}
