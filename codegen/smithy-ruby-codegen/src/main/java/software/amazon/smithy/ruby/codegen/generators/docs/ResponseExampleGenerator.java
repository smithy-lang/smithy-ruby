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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ResponseExampleGenerator {

    private final StructureShape response;
    private final String initialGetter;
    private final RubyCodeWriter writer;
    private final Set<ShapeId> visited;
    private final SymbolProvider symbolProvider;
    private final Model model;

    public ResponseExampleGenerator(OperationShape operation,
                                    SymbolProvider symbolProvider, Model model) {
        this.response = model.expectShape(operation.getOutputShape(), StructureShape.class);
        this.initialGetter = "resp.data";
        this.symbolProvider = symbolProvider;
        this.model = model;
        this.writer = new RubyCodeWriter("");
        this.visited = new HashSet<>();
    }

    public ResponseExampleGenerator(StructureShape response, String initialGetter,
                                    SymbolProvider symbolProvider, Model model) {
        this.response = response;
        this.initialGetter = initialGetter;
        this.symbolProvider = symbolProvider;
        this.model = model;
        this.writer = new RubyCodeWriter("");
        this.visited = new HashSet<>();
    }

    public String generate() {
        response.accept(new ResponseMember(initialGetter, visited));

        return writer.toString();
    }

    private final class ResponseMember extends ShapeVisitor.Default<Void> {
        private final String dataGetter;
        private final Set<ShapeId> visited;

        private ResponseMember(String dataGetter, Set<ShapeId> visited) {
            this.dataGetter = dataGetter;
            this.visited = visited;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("docType").orElse(""));
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("$L #=> String", dataGetter);
            return null;
        }

        @Override
        public Void enumShape(EnumShape shape) {
            String values = shape.getEnumValues().values()
                    .stream()
                    .map((value) -> "\"" + value + "\"")
                    .collect(Collectors.joining(", "));
            writer.write("$L #=> String, one of [$L]", dataGetter, values);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            writer.write("$L #=> Types::$L", dataGetter,
                    symbolProvider.toSymbol(shape).getProperty("docType").orElse(""));

            if (!visited.add(shape.getId())) {
                return null;
            }

            shape.members().forEach((member) -> {
                Shape target = model.expectShape(member.getTarget());
                if (!StreamingTrait.isEventStream(target)) {
                    String memberGetter = dataGetter + "." + symbolProvider.toMemberName(member);
                    target.accept(new ResponseMember(memberGetter, visited));
                }
            });
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("docType").orElse(""));

            if (!visited.add(shape.getId())) {
                return null;
            }

            Shape target = model.expectShape(shape.getMember().getTarget());
            if (!visited.contains(target.getId())) {
                String memberGetter = dataGetter + "[0]";
                target.accept(new ResponseMember(memberGetter, visited));
            }
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("docType").orElse(""));

            if (!visited.add(shape.getId())) {
                return null;
            }

            Shape target = model.expectShape(shape.getValue().getTarget());
            if (!visited.contains(target.getId())) {
                String memberGetter = dataGetter + "['key']";
                target.accept(new ResponseMember(memberGetter, visited));
            }
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            String values = shape.getAllMembers().values().stream()
                    .map(symbolProvider::toMemberName)
                    .collect(Collectors.joining(", "));
            writer.write("$L #=> Types::$L, one of [$L]", dataGetter,
                    symbolProvider.toSymbol(shape).getProperty("docType").orElse("").toString(), values);

            if (!visited.add(shape.getId())) {
                return null;
            }

            shape.members().forEach((member) -> {
                Shape target = model.expectShape(member.getTarget());
                String memberGetter = dataGetter + "." + RubyFormatter.toSnakeCase(symbolProvider.toMemberName(member));
                target.accept(new ResponseMember(memberGetter, visited));
            });
            return null;
        }
    }
}
