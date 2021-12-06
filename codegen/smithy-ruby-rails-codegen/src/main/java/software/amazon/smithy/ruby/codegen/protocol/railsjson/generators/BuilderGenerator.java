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

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.HttpPrefixHeadersTrait;
import software.amazon.smithy.model.traits.HttpQueryParamsTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.model.traits.MediaTypeTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.ruby.codegen.trait.NoSerializeTrait;


public class BuilderGenerator extends ShapeVisitor.Default<Void> {

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedBuilders;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;

    public BuilderGenerator(GenerationContext context) {
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.generatedBuilders = new HashSet<>();
        this.context = context;
        this.writer = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(model, settings, "Builder", true);
    }

    public void render(FileManifest fileManifest) {

        writer
                .write("require 'base64'\n")
                .openBlock("module $L", settings.getModule())
                .openBlock("module Builders")
                .call(() -> renderBuilders())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/builders.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderBuilders() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderBuildersForOperation(o));
    }

    private void renderBuildersForOperation(OperationShape operation) {
        // Operations MUST have an Input type, even if it is empty
        if (!operation.getInput().isPresent()) {
            throw new RuntimeException("Missing Input Shape for: " + operation.getId());
        }
        ShapeId inputShapeId = operation.getInput().get();

        HttpTrait httpTrait = operation.expectTrait(HttpTrait.class);
        Shape inputShape = model.expectShape(inputShapeId);
        Symbol symbol = symbolProvider.toSymbol(operation);

        writer
                .write("")
                .write("# Operation Builder for $L", operation.getId().getName())
                .openBlock("class $L", symbol.getName())
                .openBlock("def self.build(http_req, input:)")
                .write("http_req.http_method = '$L'", httpTrait.getMethod())
                .call(() -> renderUriBuilder(writer, operation, inputShape))
                .call(() -> renderQueryInputBuilder(writer, operation, inputShape))
                .call(() -> renderHeadersBuilder(writer, operation, inputShape))
                .call(() -> renderPrefixHeadersBuilder(writer, operation, inputShape))
                .call(() -> renderOperationBodyBuilder(writer, operation, inputShape))
                .closeBlock("end")
                .closeBlock("end");

        generatedBuilders.add(operation.toShapeId());

        Iterator<Shape> it = new Walker(model).iterateShapes(inputShape);
        while (it.hasNext()) {
            Shape s = it.next();
            if (!generatedBuilders.contains(s.getId())) {
                generatedBuilders.add(s.getId());
                s.accept(this);
            }
        }
    }

    // The Input shape is combined with the OperationBuilder
    // This generates the setting of the body (if any non-http input) as if it was the Builder for the Input
    // Also marks the InputShape as generated
    private void renderOperationBodyBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        generatedBuilders.add(inputShape.getId());

        //determine if there are any members of the input that need to be serialized to the body
        boolean serializeBody = inputShape.members().stream().anyMatch((m) -> !m.hasTrait(HttpLabelTrait.class)
                && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait(HttpHeaderTrait.class) && !m.hasTrait(
                HttpPrefixHeadersTrait.class) && !m.hasTrait(HttpQueryParamsTrait.class));
        if (serializeBody) {
            //determine if there is an httpPayload member
            List<MemberShape> httpPayloadMembers = inputShape.members()
                    .stream()
                    .filter((m) -> m.hasTrait(HttpPayloadTrait.class))
                    .collect(Collectors.toList());
            if (httpPayloadMembers.size() == 0) {
                writer
                        .write("")
                        .write("http_req.headers['Content-Type'] = 'application/json'")
                        .call(() -> renderMemberBuilders(writer, inputShape))
                        .write("http_req.body = StringIO.new(Seahorse::JSON.dump(data))");
            } else {
                MemberShape payloadMember = httpPayloadMembers.get(0);
                Shape target = model.expectShape(payloadMember.getTarget());
                String symbolName = ":" + symbolProvider.toMemberName(payloadMember);
                String inputGetter = "input[" + symbolName + "]";
                target.accept(new PayloadMemberSerializer(payloadMember, inputGetter));
            }
        }
    }

    private void renderQueryInputBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpQuery members
        List<MemberShape> queryMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpQueryTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : queryMembers) {
            HttpQueryTrait queryTrait = m.expectTrait(HttpQueryTrait.class);
            String inputGetter = "input[:" + symbolProvider.toMemberName(m) + "]";
            Shape target = model.expectShape(m.getTarget());
            target.accept(new QueryMemberSerializer(m, "'" + queryTrait.getValue() + "'", inputGetter));
        }

        // get a list of all HttpQueryParams members - these must be map shapes
        List<MemberShape> queryParamsMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpQueryParamsTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : queryParamsMembers) {
            String inputGetter = "input[:" + symbolProvider.toMemberName(m) + "]";
            MapShape queryParamMap = model.expectShape(m.getTarget(), MapShape.class);
            Shape target = model.expectShape(queryParamMap.getValue().getTarget());
            writer.openBlock("unless $1L.nil? || $1L.empty?", inputGetter)
                    .openBlock("$1L.each do |k, v|", inputGetter)
                    .call(() -> target.accept(new QueryMemberSerializer(queryParamMap.getValue(), "k", "v")))
                    .closeBlock("end")
                    .closeBlock("end");
        }
    }

    private void renderHeadersBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> headerMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            String symbolName = ":" + symbolProvider.toMemberName(m);
            String headerSetter = "http_req.headers['" + headerTrait.getValue() + "'] = ";
            String valueGetter = "input[" + symbolName + "]";
            model.expectShape(m.getTarget()).accept(new HeaderSerializer(m, headerSetter, valueGetter));
        }
    }

    private void renderPrefixHeadersBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> headerMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpPrefixHeadersTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : headerMembers) {
            HttpPrefixHeadersTrait headerTrait = m.expectTrait(HttpPrefixHeadersTrait.class);
            String prefix = headerTrait.getValue();
            // httpPrefixHeaders may only target map shapes
            MapShape targetShape = model.expectShape(m.getTarget(), MapShape.class);
            Shape valueShape = model.expectShape(targetShape.getValue().getTarget());

            String symbolName = ":" + symbolProvider.toMemberName(m);
            String headerSetter = "http_req.headers[\"" + prefix + "#{key}\"] = ";
            writer
                    .openBlock("input[$L].each do |key, value|", symbolName)
                    .call(() -> valueShape.accept(new HeaderSerializer(m, headerSetter, "value")))
                    .closeBlock("end");
        }
    }

    private void renderUriBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        HttpTrait httpTrait = operation.expectTrait(HttpTrait.class);
        List<MemberShape> labelMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpLabelTrait.class))
                .collect(Collectors.toList());

        if (labelMembers.size() > 0) {
            String uri = httpTrait.getUri().toString();
            Optional<String> greedyLabel = Optional.empty();
            Matcher greedyMatch = Pattern.compile("[{]([a-zA-Z0-9_]+)[+][}]").matcher(uri);
            if (greedyMatch.find()) {
                greedyLabel = Optional.of(greedyMatch.group(1));
                uri = greedyMatch.replaceAll("%<$1>s");
            }
            String formatUri = uri
                    .replaceAll("[{]([a-zA-Z0-9_]+)[}]", "%<$1>s");
            StringBuffer formatArgs = new StringBuffer();

            for (MemberShape m : labelMembers) {
                Shape target = model.expectShape(m.getTarget());
                if (greedyLabel.isPresent() && greedyLabel.get().equals(m.getMemberName())) {
                    formatArgs.append(
                            ",\n  " + m.getMemberName() + ": (" + target.accept(new LabelMemberSerializer(m))
                                    + ").split('/').map "
                                    + "{ |s| Seahorse::HTTP.uri_escape(s) }.join('/')"
                    );
                } else {
                    formatArgs.append(
                            ",\n  " + m.getMemberName() + ": Seahorse::HTTP.uri_escape("
                                    + target.accept(new LabelMemberSerializer(m)) + ")"
                    );
                }
            }
            writer.openBlock("http_req.append_path(format(");
            writer.write("  '$L'$L\n)", formatUri, formatArgs.toString());
            writer.closeBlock(")");
        } else {
            writer.write("http_req.append_path('$L')", httpTrait.getUri());
        }
    }

    @Override
    public Void structureShape(StructureShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        writer
                .write("")
                .write("# Structure Builder for $L", shape.getId().getName())
                .openBlock("class $L", symbol.getName())
                .openBlock("def self.build(input)")
                .call(() -> renderMemberBuilders(writer, shape))
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        writer
                .write("")
                .write("# List Builder for $L", shape.getId().getName())
                .openBlock("class $L", symbol.getName())
                .openBlock("def self.build(input)")
                .write("data = []")
                .openBlock("input.each do |element|")
                .call(() -> memberTarget
                        .accept(new MemberSerializer(shape.getMember(), "data << ", "element",
                                false)))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        Shape valueTarget = model.expectShape(shape.getValue().getTarget());

        writer
                .write("")
                .write("# Map Builder for $L", shape.getId().getName())
                .openBlock("class $L", symbol.getName())
                .openBlock("def self.build(input)")
                .write("data = {}")
                .openBlock("input.each do |key, value|")
                .call(() -> valueTarget
                        .accept(new MemberSerializer(shape.getValue(), "data[key] = ", "value",
                                false)))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        writer
                .write("")
                .write("# Set Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", symbol.getName())
                .openBlock("def self.build(input)")
                .write("data = Set.new")
                .openBlock("input.each do |element|")
                .call(() -> memberTarget
                        .accept(new MemberSerializer(shape.getMember(), "data << ", "element",
                                true)))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        Symbol symbol = symbolProvider.toSymbol(shape);
        writer
                .write("")
                .write("# Structure Builder for $L", shape.getId().getName())
                .openBlock("class $L", symbol.getName())
                .openBlock("def self.build(input)")
                .write("data = {}")
                .write("case input");

        shape.members().forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());

            writer.write("when Types::$L::$L", shape.getId().getName(), symbolProvider.toMemberName(member))
                    .indent();

            String symbolName = RubyFormatter.asSymbol(symbolProvider.toMemberName(member));
            String dataSetter = "data[" + symbolName + "] = ";
            target.accept(new MemberSerializer(member, dataSetter, "input", false));
            writer.dedent();
        });
        writer.openBlock("else")
                .write("raise ArgumentError,\n\"Expected input to be one of the subclasses of Types::$L\"",
                        symbol.getName())
                .closeBlock("end")
                .write("")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    private void renderMemberBuilders(RubyCodeWriter writer, Shape s) {
        writer.write("data = {}");

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
    protected Void getDefault(Shape shape) {
        return null;
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

    private class HeaderSerializer extends ShapeVisitor.Default<Void> {

        private final String inputGetter;
        private final String dataSetter;
        private final MemberShape memberShape;

        HeaderSerializer(MemberShape memberShape,
                         String dataSetter, String inputGetter) {
            this.inputGetter = inputGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$1L$2L.to_s unless $2L.nil?", dataSetter, inputGetter);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            // string values with a mediaType trait are always base64 encoded.
            if (shape.hasTrait(MediaTypeTrait.class)) {
                writer.write("$1LBase64::encode64($2L).strip unless $2L.nil? || $2L.empty?", dataSetter, inputGetter);
            } else {
                writer.write("$1L$2L unless $2L.nil? || $2L.empty?", dataSetter, inputGetter);
            }
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // header values are serialized using the http-date format by default
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (!format.isPresent()) {
                format = shape.getTrait(TimestampFormatTrait.class);
            }
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write("$1LSeahorse::TimeHelper.to_epoch_seconds($2L).to_i unless $2L.nil?", dataSetter,
                                inputGetter);
                        break;
                    case DATE_TIME:
                        writer.write("$1LSeahorse::TimeHelper.to_date_time($2L) unless $2L.nil?", dataSetter,
                                inputGetter);
                        break;
                    case HTTP_DATE:
                    default:
                        writer.write("$1LSeahorse::TimeHelper.to_http_date($2L) unless $2L.nil?", dataSetter,
                                inputGetter);
                        break;
                }
            } else {
                writer.write("$1LSeahorse::TimeHelper.to_http_date($2L) unless $2L.nil?", dataSetter, inputGetter);
            }
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            writer.openBlock("unless $1L.nil? || $1L.empty?", inputGetter)
                    .write("$1L$2L", dataSetter, inputGetter)
                    .indent()
                    .write(".compact")
                    .call(() -> model.expectShape(shape.getMember().getTarget())
                            .accept(new HeaderListMemberSerializer(shape.getMember())))
                    .write(".join(', ')")
                    .dedent()
                    .closeBlock("end");
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            writer.openBlock("unless $1L.nil? || $1L.empty?", inputGetter)
                    .write("$1L$2L", dataSetter, inputGetter)
                    .indent()
                    .write(".to_a")
                    .write(".compact")
                    .call(() -> model.expectShape(shape.getMember().getTarget())
                            .accept(new HeaderListMemberSerializer(shape.getMember())))
                    .write(".join(', ')")
                    .dedent()
                    .closeBlock("end");
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            // Not supported in headers
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            // Not supported in headers
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            // Not supported in headers
            return null;
        }
    }

    private class HeaderListMemberSerializer extends ShapeVisitor.Default<Void> {

        private final MemberShape memberShape;

        HeaderListMemberSerializer(MemberShape memberShape) {
            this.memberShape = memberShape;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write(".map { |s| s.to_s }");
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer
                    .write(".map { |s| (s.include?('\"') || s.include?(\",\"))"
                            + " ? \"\\\"#{s.gsub('\"', '\\\"')}\\\"\" : s }");
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // header values are serialized using the http-date format by default
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write(".map { |s| Seahorse::TimeHelper.to_epoch_seconds(s) }");
                        break;
                    case DATE_TIME:
                        writer.write(".map { |s| Seahorse::TimeHelper.to_date_time(s) }");
                        break;
                    case HTTP_DATE:
                    default:
                        writer.write(".map { |s| Seahorse::TimeHelper.to_http_date(s) }");
                        break;
                }
            } else {
                writer.write(".map { |s| Seahorse::TimeHelper.to_http_date(s) }");
            }
            return null;
        }
    }

    private class LabelMemberSerializer extends ShapeVisitor.Default<String> {

        private final MemberShape memberShape;

        LabelMemberSerializer(MemberShape memberShape) {
            this.memberShape = memberShape;
        }

        @Override
        protected String getDefault(Shape shape) {
            String symbolName = ":" + symbolProvider.toMemberName(memberShape);
            return "input[" + symbolName + "].to_s";
        }

        @Override
        public String timestampShape(TimestampShape shape) {
            // label values are serialized using RFC 3399 date-time by default
            Optional<TimestampFormatTrait> formatTrait = memberShape.getTrait(TimestampFormatTrait.class);
            if (!formatTrait.isPresent()) {
                formatTrait = shape.getTrait(TimestampFormatTrait.class);
            }
            TimestampFormatTrait.Format format = TimestampFormatTrait.Format.DATE_TIME;
            if (formatTrait.isPresent()) {
                format = formatTrait.get().getFormat();
            }
            String symbolName = ":" + symbolProvider.toMemberName(memberShape);
            switch (format) {
                case EPOCH_SECONDS:
                    return "Seahorse::TimeHelper.to_epoch_seconds(input[" + symbolName + "]).to_i.to_s";
                case HTTP_DATE:
                    return "Seahorse::TimeHelper.to_http_date(input[" + symbolName + "])";
                case DATE_TIME:
                default:
                    return "Seahorse::TimeHelper.to_date_time(input[" + symbolName + "])";
            }
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

    private class QueryMemberSerializer extends ShapeVisitor.Default<Void> {

        private final String inputGetter;
        private final String headerName;
        private final MemberShape memberShape;

        QueryMemberSerializer(MemberShape memberShape, String headerName, String inputGetter) {
            this.inputGetter = inputGetter;
            this.headerName = headerName;
            this.memberShape = memberShape;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("http_req.append_query_param($1L, $2L.to_s) unless $2L.nil?",
                    headerName, inputGetter);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // header values are serialized using the date-time format by default
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (!format.isPresent()) {
                format = shape.getTrait(TimestampFormatTrait.class);
            }
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write(
                                "http_req.append_query_param($1L, "
                                        + "Seahorse::TimeHelper.to_epoch_seconds($2L).to_i) unless $2L.nil?",
                                headerName,
                                inputGetter);
                        break;
                    case HTTP_DATE:
                        writer.write(
                                "http_req.append_query_param($1L, "
                                        + "Seahorse::TimeHelper.to_http_date($2L)) unless $2L.nil?",
                                headerName,
                                inputGetter);
                        break;
                    case DATE_TIME:
                    default:
                        writer.write(
                                "http_req.append_query_param($1L, "
                                        + "Seahorse::TimeHelper.to_date_time($2L)) unless $2L.nil?",
                                headerName,
                                inputGetter);
                        break;
                }
            } else {
                writer.write(
                        "http_req.append_query_param($1L, "
                                + "Seahorse::TimeHelper.to_date_time($2L)) unless $2L.nil?",
                        headerName,
                        inputGetter);
            }
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            Shape target = model.expectShape(shape.getMember().getTarget());
            writer.openBlock("unless $1L.nil? || $1L.empty?", inputGetter)
                    .openBlock("$1L.each do |value|", inputGetter)
                    .call(() -> target.accept(new QueryMemberSerializer(shape.getMember(), headerName, "value")))
                    .closeBlock("end")
                    .closeBlock("end");
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            Shape target = model.expectShape(shape.getMember().getTarget());
            writer.openBlock("unless $1L.nil? || $1L.empty?", inputGetter)
                    .openBlock("$1L.each do |value|", inputGetter)
                    .call(() -> target.accept(new QueryMemberSerializer(shape.getMember(), headerName, "value")))
                    .closeBlock("end")
                    .closeBlock("end");
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            // Not supported in query
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            // Not supported in query
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            // Not supported in query
            return null;
        }
    }

}


