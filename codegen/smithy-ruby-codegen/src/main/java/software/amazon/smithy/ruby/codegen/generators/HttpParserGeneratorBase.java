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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
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
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.HttpPrefixHeadersTrait;
import software.amazon.smithy.model.traits.HttpResponseCodeTrait;
import software.amazon.smithy.model.traits.MediaTypeTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;

public abstract class HttpParserGeneratorBase {

    protected final GenerationContext context;
    protected final RubySettings settings;
    protected final Model model;
    protected final Set<ShapeId> generatedParsers;
    protected final SymbolProvider symbolProvider;

    protected final RubyCodeWriter writer;

    public HttpParserGeneratorBase(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.generatedParsers = new HashSet<>();
        this.writer = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Params", true);
    }

    public void render(FileManifest fileManifest) {
        writer
                .write("require 'base64'\n")
                .openBlock("module $L", settings.getModule())
                .openBlock("module Parsers")
                .call(() -> renderParsers())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/parsers.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    protected void renderParsers() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> {
                    Shape outputShape = model.expectShape(o.getOutput().orElseThrow(IllegalArgumentException::new));
                    renderParsersForOperation(o, outputShape);
                    generatedParsers.add(o.toShapeId());
                    generatedParsers.add(outputShape.toShapeId());

                    Iterator<Shape> it = new Walker(model).iterateShapes(outputShape);
                    while (it.hasNext()) {
                        Shape s = it.next();
                        if (!generatedParsers.contains(s.getId())) {
                            generatedParsers.add(s.getId());
                            s.accept(new ParserClassGenerator());
                        } else {
                            System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
                        }
                    }

                    for (ShapeId errorShapeId : o.getErrors()) {
                        System.out.println("\tGenerating Error parsers connected to: " + errorShapeId);
                        Iterator<Shape> errIt = new Walker(model).iterateShapes(model.expectShape(errorShapeId));
                        while (errIt.hasNext()) {
                            Shape s = errIt.next();
                            if (!generatedParsers.contains(s.getId())) {
                                generatedParsers.add(s.getId());
                                if (s.hasTrait(ErrorTrait.class)) {
                                    renderErrorParser(s);
                                } else {
                                    s.accept(new ParserClassGenerator());
                                }
                            }
                        }
                    }
                });
    }

    protected void renderParsersForOperation(OperationShape operation, Shape outputShape) {

        writer
                .write("")
                .write("# Operation Parser for $L", operation.getId().getName())
                .openBlock("class $L", symbolProvider.toSymbol(operation).getName())
                .openBlock("def self.parse(http_resp)")
                .write("data = Types::$L.new", symbolProvider.toSymbol(outputShape).getName())
                .call(() -> renderHeaderParsers(outputShape))
                .call(() -> renderPrefixHeaderParsers(outputShape))
                .call(() -> renderResponseCodeParser(outputShape))
                .call(() -> renderOperationBodyParser(outputShape))
                .write("data")
                .closeBlock("end")
                .closeBlock("end");
    }

    protected void renderErrorParser(Shape s) {
        writer
                .write("")
                .write("# Error Parser for $L", s.getId().getName())
                .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                .openBlock("def self.parse(http_resp)")
                .write("data = Types::$L.new", symbolProvider.toSymbol(s).getName())
                .call(() -> renderHeaderParsers(s))
                .call(() -> renderPrefixHeaderParsers(s))
                .call(() -> renderOperationBodyParser(s))
                .write("data")
                .closeBlock("end")
                .closeBlock("end");
    }

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
        }
    }

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
            String headerSetter = "http_req.headers[\"" + prefix + "#{key.delete_prefix('" + prefix + "')}\"] = ";

            String dataSetter = "data." + symbolName + "[key.delete_prefix('" + prefix + "')] = ";
            writer
                    .write("data.$L = {}", symbolName)
                    .openBlock("http_resp.headers.each do |key, value|")
                    .openBlock("if key.start_with?('$L')", prefix)
                    .call(() -> valueShape.accept(new HeaderDeserializer(m, dataSetter, "value")))
                    .closeBlock("end")
                    .closeBlock("end");

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
        }
    }

    // The Output shape is combined with the Operation Parser
    // This generates the parsing of the body as if it was the Parser for the Out[put
    protected void renderOperationBodyParser(Shape outputShape) {
        //determine if there is an httpPayload member
        List<MemberShape> httpPayloadMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpPayloadTrait.class))
                .collect(Collectors.toList());

        if (httpPayloadMembers.size() == 0) {
            renderNoPayloadBodyParser(outputShape);
        } else if (httpPayloadMembers.size() == 1) {
            MemberShape payloadMember = httpPayloadMembers.get(0);
            Shape target = model.expectShape(payloadMember.getTarget());
            renderPayloadBodyParser(outputShape, payloadMember, target);
        }
    }

    protected abstract void renderPayloadBodyParser(Shape outputShape, MemberShape payloadMember, Shape target);

    protected abstract void renderNoPayloadBodyParser(Shape outputShape);

    protected abstract void renderUnionMemberParser(UnionShape s, MemberShape member);

    protected abstract String unionMemberDataName(UnionShape s, MemberShape member);

    protected abstract void renderMapMemberParser(MapShape s);

    protected abstract void renderSetMemberParser(SetShape s);

    protected abstract void renderListMemberParser(ListShape s);

    protected abstract void renderStructureMemberParsers(StructureShape s);

    private class ParserClassGenerator extends ShapeVisitor.Default<Void> {
        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .openBlock("def self.parse(map)")
                    .write("data = Types::$L.new", symbolProvider.toSymbol(s).getName())
                    .call(() -> renderStructureMemberParsers(s))
                    .write("return data")
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void listShape(ListShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .openBlock("def self.parse(list)")
                    .openBlock("list.map do |value|")
                    .call(() -> renderListMemberParser(s))
                    .closeBlock("end")
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void setShape(SetShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .openBlock("def self.parse(list)")
                    .openBlock("data = list.map do |value|")
                    .call(() -> renderSetMemberParser(s))
                    .closeBlock("end")
                    .write("Set.new(data)")
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void mapShape(MapShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .openBlock("def self.parse(map)")
                    .write("data = {}")
                    .openBlock("map.map do |key, value|")
                    .call(() -> renderMapMemberParser(s))
                    .closeBlock("end")
                    .write("data")
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void unionShape(UnionShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .openBlock("def self.parse(map)")
                    .write("key, value = map.flatten")
                    .write("case key")
                    .call(() -> {
                        s.members().forEach((member) -> {
                            writer
                                    .write("when '$L'", unionMemberDataName(s, member))
                                    .indent()
                                    .call(() -> {
                                        renderUnionMemberParser(s, member);
                                    })
                                    .write("Types::$L::$L.new(value) if value", symbolProvider.toSymbol(s).getName(),
                                            symbolProvider.toMemberName(member))
                                    .dedent();
                        });
                    })
                    .openBlock("else")
                    .write("Types::$L::Unknown.new({name: key, value: value})", s.getId().getName())
                    .closeBlock("end") // end of case
                    .closeBlock("end")
                    .closeBlock("end");

            return null;
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

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("$1L$2L == 'true' unless $2L.nil?", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("$1L$2L&.to_i", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("$1L$2L&.to_i", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("$1L$2L&.to_i", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("$1L$2L&.to_i", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("$1L$2L&.to_f", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write("$1L$2L&.to_f", dataSetter, valueGetter);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            // string values with a mediaType trait are always base64 encoded.
            if (shape.hasTrait(MediaTypeTrait.class)) {
                writer.write("$1LBase64::decode64($2L).strip unless $2L.nil?", dataSetter, valueGetter);
            } else {
                writer.write("$1L$2L", dataSetter, valueGetter);
            }
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // the default protocol format is date_time, which is parsed by Time.parse
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (!format.isPresent()) {
                format = shape.getTrait(TimestampFormatTrait.class);
            }
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write("$1LTime.at($2L.to_i) if $2L", dataSetter, valueGetter);
                        break;
                    case HTTP_DATE:
                    case DATE_TIME:
                    default:
                        writer.write("$1LTime.parse($2L) if $2L", dataSetter, valueGetter);
                        break;
                }
            } else {
                writer.write("$1LTime.parse($2L) if $2L", dataSetter, valueGetter);
            }
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            writer.openBlock("unless $1L.nil? || $1L.empty?", valueGetter)
                    .write("$1L$2L", dataSetter, valueGetter)
                    .indent()
                    .write(".split(', ')")
                    .call(() -> model.expectShape(shape.getMember().getTarget())
                            .accept(new HeaderListMemberDeserializer(shape.getMember())))
                    .dedent()
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            writer.openBlock("unless $1L.nil? || $1L.empty?", valueGetter)
                    .write("$1LSet.new($2L", dataSetter, valueGetter)
                    .indent()
                    .write(".split(', ')")
                    .call(() -> model.expectShape(shape.getMember().getTarget())
                            .accept(new HeaderListMemberDeserializer(shape.getMember())))
                    .dedent()
                    .write(")")
                    .closeBlock("end");

            return null;
        }

    }

    private class HeaderListMemberDeserializer extends ShapeVisitor.Default<Void> {

        private final MemberShape memberShape;

        HeaderListMemberDeserializer(MemberShape memberShape) {
            this.memberShape = memberShape;
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            // TODO: there is likely some stripping of extra quotes. Pending SEP definition
            writer.write(".map { |s| s.to_s }");
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write(".map { |s| s == 'true' }");
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write(".map { |s| s.to_i }");
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // header values are serialized using the http-date format by default
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write(".map { |s| Time.at(s.to_i) }");
                        break;
                    case DATE_TIME:
                    case HTTP_DATE:
                    default:
                        writer.write(".map { |s| Time.parse(s) }");
                        break;
                }
            } else {
                writer.write(".map { |s| Time.parse(s) }");
            }
            return null;
        }
    }

}
