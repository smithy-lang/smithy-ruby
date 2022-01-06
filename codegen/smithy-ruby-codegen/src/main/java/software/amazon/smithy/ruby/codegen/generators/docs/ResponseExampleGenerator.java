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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.EnumTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ResponseExampleGenerator {

    private final OperationShape operation;
    private final RubyCodeWriter writer;
    private final Set<ShapeId> visited;
    private final SymbolProvider symbolProvider;
    private final Model model;

    public ResponseExampleGenerator(OperationShape operation,
                                    SymbolProvider symbolProvider, Model model) {
        this.operation = operation;
        this.symbolProvider = symbolProvider;
        this.model = model;
        this.writer = new RubyCodeWriter();
        this.visited = new HashSet<>();
    }

    public String generate() {
        Shape operationOutput = model.expectShape(operation.getOutputShape());

        operationOutput.accept(new ResponseMember("resp", visited));

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
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("yardType").orElse(""));
            return null;
        }


        @Override
        public Void stringShape(StringShape shape) {
            if (shape.hasTrait(EnumTrait.class)) {
                EnumTrait enumTrait = shape.expectTrait(EnumTrait.class);
                String values =
                        enumTrait.getValues().stream().map((v) -> v.getValue()).collect(Collectors.joining(", "));
                writer.write("$L #=> String, one of $L", dataGetter, values);
            } else {
                writer.write("$L #=> String", dataGetter);
            }
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            writer.write("$L #=> Types::$L", dataGetter,
                    symbolProvider.toSymbol(shape).getProperty("yardType").orElse(""));

            if (!visited.add(shape.getId())) {
                return null;
            }

            if (shape.members().size() > 0) {
                shape.members().forEach((member) -> {
                    Shape target = model.expectShape(member.getTarget());
                    String memberGetter = dataGetter + "." + symbolProvider.toMemberName(member);
                    target.accept(new ResponseMember(memberGetter, visited));
                });
            }
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("yardType").orElse(""));

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
        public Void setShape(SetShape shape) {
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("yardType").orElse(""));

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
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("yardType").orElse(""));

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
            writer.write("$L #=> $L", dataGetter, symbolProvider.toSymbol(shape).getProperty("yardType").orElse(""));

            if (!visited.add(shape.getId())) {
                return null;
            }

            // TODO: What do we do for unions??
            return null;
        }
    }
}
