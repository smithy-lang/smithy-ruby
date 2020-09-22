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
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.model.traits.RequiredTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.CodeWriter;

public class ClientApiGenerator {
    private static final Set<String> RUBY_SHAPES = new HashSet<String>() {
        {
            add("BlobShape");
            add("BooleanShape");
            add("DocumentShape");
            add("FloatShape");
            add("IntegerShape");
            add("ListShape");
            add("MapShape");
            add("StringShape");
            add("StructureShape");
            add("TimestampShape");
        }
    };

    private static final Map<String, String> SMITHY_TO_RUBY_SHAPE = new HashMap<String, String>() {
        {
            // Smithy Shape => Ruby Shape
            // byte, short, integer, long, bigInteger => Integer
            put("ByteShape", "IntegerShape");
            put("ShortShape", "IntegerShape");
            put("LongShape", "IntegerShape");
            put("BigIntegerShape", "IntegerShape");
            // double, bigDecimal => Float
            put("DoubleShape", "FloatShape");
            put("BigDecimalShape", "FloatShape");
        }
    };

    private final Model model;
    private final RubySettings settings;

    public ClientApiGenerator(RubySettings settings, Model model) {
        this.settings = settings;
        this.model = model;
    }

    public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        final Set<Object> seen = new HashSet<>();
        return t -> seen.add(keyExtractor.apply(t));
    }

    public void render(FileManifest fileManifest) {
        CodeWriter writer = RubyCodeWriter.createDefault();
        writer.openBlock("module " + settings.getModule())
                .write("# @api private")
                .openBlock("module ClientApi\n")
                .write("include Seahorse::Model\n")
                .call(() -> renderShapeDeclarations(writer))
                .call(() -> renderShapeDefinitions(writer))
                .call(() -> renderApiDefinitions(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/client_api.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderShapeDeclarations(CodeWriter writer) {
        model.shapes()
                .filter((s) -> RUBY_SHAPES.contains(s.getClass().getSimpleName()))
                .filter(distinctByKey((s) -> s.getId().getName()))
                .sorted(Comparator.comparing((s) -> s.getId().getName()))
                .forEach((s) -> writer.write(
                        "$1L = Shapes::$2L.new(name: '$1L')", s.getId().getName(), getRubyShapeFrom(s)));
        writer.write("\n");
    }

    private void renderShapeDefinitions(CodeWriter writer) {
        model.shapes(StructureShape.class)
                .sorted(Comparator.comparing((s) -> s.getId().getName()))
                .forEach((s) -> renderStructureDefinition(writer, s));

        model.shapes(ListShape.class)
                .sorted(Comparator.comparing((s) -> s.getId().getName()))
                .forEach((s) -> renderListDefinition(writer, s));

        model.shapes(MapShape.class)
                .sorted(Comparator.comparing((s) -> s.getId().getName()))
                .forEach((s) -> renderMapDefinition(writer, s));
    }

    private void renderMapDefinition(CodeWriter writer, MapShape s) {
        String shapeName = s.getId().getName();

        writer.write("$L.key = Shapes::ShapeRef.new(shape: $L)", shapeName, s.getKey().getTarget().getName());
        writer.write("$L.value = Shapes::ShapeRef.new(shape: $L)", shapeName, s.getValue().getTarget().getName());

        writer.write("");
    }

    private void renderStructureDefinition(CodeWriter writer, StructureShape s) {
        String shapeName = s.getId().getName();
        //writer.write("# TODO members for $L", shapeName);
        s.members().forEach((memberShape ->
                writer.write("$L.add_member($L, $L)",
                        shapeName,
                        RubyFormatter.asSymbol(memberShape.getMemberName()),
                        generateMemberShapeRef(memberShape))));
        s.members().stream().forEach((memberShape -> {
            memberShape.getTrait(HttpPayloadTrait.class).ifPresent((t) -> {
                String payloadName = RubyFormatter.asSymbol(memberShape.getMemberName());
                writer.write("$L[:payload] = $L", shapeName, payloadName);
                writer.write("$1L[:payload_member] = $1L.member($2L)",
                        shapeName, payloadName);
            });
        }));

        writer.write("$1L.struct_class = Types::$1L", shapeName);

        writer.write("");
    }

    private String generateMemberShapeRef(MemberShape memberShape) {
        Map<String, String> traits = new HashMap<>();
        traits.put("shape", memberShape.getTarget().getName());
        traits.put("location_name", q(memberShape.getMemberName()));

        memberShape.getTrait(RequiredTrait.class).ifPresent((t) -> traits.put("required", "true"));
        memberShape.getTrait(HttpLabelTrait.class).ifPresent((t) -> traits.put("location", "'uri'"));
        memberShape.getTrait(HttpQueryTrait.class).ifPresent((t) -> traits.put("location", "'querystring'"));
        memberShape.getTrait(HttpHeaderTrait.class).ifPresent((t) -> {
            traits.put("location", "'header'");
            traits.put("location_name", q(t.getValue()));
        });


        String traitStr = traits.entrySet().stream()
                .map((e) -> e.getKey() + ": " + e.getValue())
                .collect(Collectors.joining(", "));

        return "Shapes::ShapeRef.new(" + traitStr + ")";
    }

    private String q(String s) {
        return "'" + s + "'";
    }

    private void renderListDefinition(CodeWriter writer, ListShape s) {
        String shapeName = s.getId().getName();

        writer.write("$L.member = Shapes::ShapeRef.new(shape: $L)",
                shapeName, s.getMember().getTarget().getName());
        writer.write("");
    }

    private void renderApiDefinitions(CodeWriter writer) {
        // TODO move to settings
//        ServiceShape service =
//                model.getShape(settings.getService()).get().asServiceShape().get();
        // String version = service.getVersion();
        writer
                .write("# @api private")
                .openBlock("API = Seahorse::Model::Api.new.tap do |api|");
        // .write("api.version = '$L'", version);

        // var protocol = SMITHY_PROTOCOL_TO_RUBY_PROTOCOL_CLASS.get(settings.getProtocol());
        // var signature = SMITHY_SIGNATURE_TO_RUBY_SIGNATURE.get(settings.getSignatureVersion());

//        writer.openBlock("api.metadata = {")
//                .write("'apiVersion' => '$L',", version)
//                .write("'endpointPrefix' => '$L',", settings.getPackageName()) // is this right ?..
//                .write("'protocol' => '$L',", "rest-json")
//                .write("'serviceFullName' => '$L',",
//                settings.getService().getTrait(TitleTrait.class).get().getValue())
//                .write("'serviceId' => '$L',", service.getTrait(ServiceTrait.class).get().getSdkId())
//                .write("'signatureVersion' => '$L',", "v4")
//                .write("'uid' => '$L'", settings.getPackageName() + "-" + settings.getService().getVersion())
//                .closeBlock("}");

        model.shapes(OperationShape.class).sorted(Comparator.comparing((o) -> o.getId().getName())).forEach(
                (o) -> {
                    String name = o.getId().getName();
                    String method = RubyFormatter.asSymbol(name);
                    writer.openBlock("api.add_operation($L, Seahorse::Model::Operation.new.tap do |o|", method)
                            .write("o.name = '$L'", name)
                            .write("o.http_method = '$L'", o.getTrait(HttpTrait.class).get().getMethod())
                            .write("o.http_request_uri = '$L'", o.getTrait(HttpTrait.class).get().getUri());

                    writer.write("o.input = Shapes::ShapeRef.new(shape: $L)", o.getInput().map((in) -> in.getName())
                            .orElse("Shapes::StructureShape.new(struct_class: Aws::EmptyStructure)"));
                    writer.write("o.output = Shapes::ShapeRef.new(shape: $L)", o.getOutput().map((out) -> out.getName())
                            .orElse("Shapes::StructureShape.new(struct_class: Aws::EmptyStructure)"));

                    o.getErrors().forEach((e) -> {
                        writer.write("o.errors << Shapes::ShapeRef.new(shape: $L)", e.getName());
                    });

//                    o.getTrait(PaginatedTrait.class).ifPresent((p) -> {
//                        writer.openBlock("o[:pager] = Aws::Pager.new(")
//                                .write("limit_key: '$L',", RubyFormatter.toSnakeCase(p.getPageSize().get()))
//                                .openBlock("tokens: {")
//                                .write("'$L' => '$L'", RubyFormatter.toSnakeCase(p.getOutputToken().get()),
//                                        RubyFormatter.toSnakeCase(p.getInputToken().get()))
//                                .closeBlock("}")
//                                .closeBlock(")");
//                    });


                    writer.closeBlock("end)");
                });

        writer.closeBlock("end");
    }

    private String getRubyShapeFrom(Shape s) {
        return SMITHY_TO_RUBY_SHAPE.getOrDefault(s.getClass().getSimpleName(), s.getClass().getSimpleName());
    }

}
