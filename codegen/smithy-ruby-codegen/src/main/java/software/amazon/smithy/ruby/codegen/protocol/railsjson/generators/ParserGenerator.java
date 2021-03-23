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

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.*;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

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

        //TODO: An optional check on the Output Type being present
        if (!operation.getOutput().isPresent()) {
            System.out.println("\tSKIPPING.  No Output type.");
            return;
        }
        ShapeId outputShapeId = operation.getOutput().get();

        writer
                .openBlock("class $LOperation", operation.getId().getName())
                .openBlock("def self.parse(http_resp:, resp:)")
                .write("data = JSON.parse(http_resp.body.read)")
                .write("resp.data = Parsers::$L.parse(data)", outputShapeId.getName())
                .call(() -> renderHeaderParsers(writer, operation))
                .closeBlock("end")
                .closeBlock("end");

        generatedParsers.add(operation.toShapeId());

        Shape outputShape = model.expectShape(outputShapeId);
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

    private void renderHeaderParsers(RubyCodeWriter writer, OperationShape operation) {
        Shape outputShape = model.expectShape(operation.getOutput().get());
        List<MemberShape> headerMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());

        for(MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding headers for: " + headerTrait.getValue() + " -> " + target.getId());
            String symbolName =  RubyFormatter.toSnakeCase(m.getMemberName());
            writer.write("resp.data.$L = http_resp.headers['$L']", symbolName, headerTrait.getValue());
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

    private void renderMemberParsers(RubyCodeWriter writer, StructureShape s) {
        for(MemberShape member : s.members()) {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER PARSER FOR: " + member.getId() + " target type: " + target.getType());
            String dataName = RubyFormatter.toSnakeCase(member.getMemberName());
            String jsonName = dataName;
            if (member.hasTrait(JsonNameTrait.class)) {
                jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
            }
            // TODO: This may be where a vistor pattern is useful?
            if (target.isListShape() || target.isStructureShape()) {
                writer.write("data.$1L = Parsers::$2L.parse(json['$3L']) if json.key?('$3L')", dataName, target.getId().getName(), jsonName);
            } else if(!target.hasTrait(HttpHeaderTrait.class)) {
                // TODO: This is incomplete, many types need conversion...
                writer.write("data.$L = json['$L']", dataName, jsonName);
            }
        }
    }
}
