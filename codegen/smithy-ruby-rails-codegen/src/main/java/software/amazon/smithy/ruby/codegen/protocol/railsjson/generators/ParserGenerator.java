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

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

//TODO: Clean this class up to match the Visitor pattern used in BuidlerGenerator
public class ParserGenerator {

    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedParsers;

    public ParserGenerator(RubySettings settings, Model model) {
        this.settings = settings;
        this.model = model;
        this.generatedParsers = new HashSet<>();
    }

    public void render(FileManifest fileManifest) {
        RubyCodeWriter writer = new RubyCodeWriter();

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Parsers")
                .call(() -> renderParsers(writer))
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/parsers.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderParsers(RubyCodeWriter writer) {
        Stream<OperationShape> operations = model.shapes(OperationShape.class);
        operations.forEach(o -> renderParsersForOperation(writer, o));
    }

    private void renderParsersForOperation(RubyCodeWriter writer, OperationShape operation) {
        System.out.println("Generating parsers for Operation: " + operation.getId());

        // Operations MUST have an Output type, even if it is empty
        if (!operation.getOutput().isPresent()) {
            throw new RuntimeException("Missing Output Shape for: " + operation.getId());
        }

        ShapeId outputShapeId = operation.getOutput().get();
        Shape outputShape = model.expectShape(outputShapeId);


        writer
                .write("\n# Operation Parser for $L", operation.getId().getName())
                .openBlock("class $L", operation.getId().getName())
                .openBlock("def self.parse(http_resp, output:)")
                .write("json = Seahorse::JSON.load(http_resp.body)")
                .write("data = Types::$L.new", outputShapeId.getName())
                .call(() -> renderHeaderParsers(writer, operation, outputShape))
                .call(() -> renderOperationBodyParser(writer, operation, outputShape))
                .write("output.data = data")
                .closeBlock("end")
                .closeBlock("end");

        generatedParsers.add(operation.toShapeId());
        generatedParsers.add(outputShapeId);

        for (Iterator<Shape> it = new Walker(model).iterateShapes(outputShape); it.hasNext(); ) {
            Shape s = it.next();
            if (!generatedParsers.contains(s.getId())) {
                if (s.isStructureShape()) {
                    renderParserForStructure(writer, s.asStructureShape().get());
                } else if (s.isListShape()) {
                    renderParserForList(writer, s.asListShape().get());
                } else {
                    System.out.println("\tSkipping " + s.getId() + " it is not a structure.  Type = " + s.getType());
                }
            } else {
                System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
            }

        }
    }

    private void renderHeaderParsers(RubyCodeWriter writer, OperationShape operation, Shape outputShape) {
        List<MemberShape> headerMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding headers for: " + headerTrait.getValue() + " -> " + target.getId());
            String symbolName = RubyFormatter.toSnakeCase(m.getMemberName());
            writer.write("resp.data.$L = http_resp.headers['$L']", symbolName, headerTrait.getValue());
        }
    }

    // The Output shape is combined with the Operation Parser
    // This generates the parsing of the body as if it was the Parser for the Out[put
    private void renderOperationBodyParser(RubyCodeWriter writer, OperationShape operation, Shape outputShape) {
        //determine if there is an httpPayload member
        List<MemberShape> httpPayloadMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpPayloadTrait.class))
                .collect(Collectors.toList());

        if (httpPayloadMembers.size() == 0) {
            renderMemberParsers(writer, outputShape);
        } else if (httpPayloadMembers.size() == 1) {
            MemberShape payloadMember = httpPayloadMembers.get(0);
            Shape target = model.expectShape(payloadMember.getTarget());
            String dataName = RubyFormatter.toSnakeCase(payloadMember.getMemberName());
            writer.write("data.$1L = Parsers::$2L.parse(json)", dataName, target.getId().getName());

        }
    }

    private void renderParserForStructure(RubyCodeWriter writer, StructureShape s) {
        System.out.println("\tRENDER parser for STRUCTURE: " + s.getId());
        generatedParsers.add(s.getId());
        writer
                .openBlock("\nclass $L", s.getId().getName())
                .openBlock("def self.parse(json)")
                .write("data = Types::$L.new", s.getId().getName())
                .call(() -> renderMemberParsers(writer, s))
                .write("return data")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderParserForList(RubyCodeWriter writer, ListShape s) {
        System.out.println("\tRENDER parser for LIST: " + s.getId());
        generatedParsers.add(s.getId());
        writer
                .openBlock("\nclass $L", s.getId().getName())
                .openBlock("def self.parse(json)")
                .openBlock("json.map do |entry|")
                .write("$L.parse(entry)", s.getMember().getTarget().getName())
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
    }

    // TODO: Apply the same pattern as MemberBuilders (in BuilderGenerator)
    private void renderMemberParsers(RubyCodeWriter writer, Shape s) {
        for (MemberShape member : s.members()) {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER PARSER FOR: " + member.getId() + " target type: " + target.getType());
            String dataName = RubyFormatter.toSnakeCase(member.getMemberName());
            String jsonName = dataName;
            if (member.hasTrait(JsonNameTrait.class)) {
                jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
            }
            if (target.isListShape() || target.isStructureShape()) {
                writer.write("data.$1L = Parsers::$2L.parse(json['$3L']) if json.key?('$3L')", dataName,
                        target.getId().getName(), jsonName);
            } else if (!target.hasTrait(HttpHeaderTrait.class)) {
                writer.write("data.$L = json['$L']", dataName, jsonName);
            }
        }
    }
}
