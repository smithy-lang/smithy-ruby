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

package software.amazon.smithy.ruby.codegen.generators.rbs;

import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.RequiredTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;

public class OperationKeywordArgRbsVisitor extends ShapeVisitor.Default<Void> {

    private static final int MAX_LEVEL = 2;

    private final GenerationContext context;

    private final RubyCodeWriter writer;

    private final int level;

    public OperationKeywordArgRbsVisitor(GenerationContext context, RubyCodeWriter writer) {
        this.context = context;
        this.writer = writer;
        this.level = 0;
    }

    public OperationKeywordArgRbsVisitor(GenerationContext context, RubyCodeWriter writer, int level) {
        this.context = context;
        this.writer = writer;
        this.level = level;
    }

    @Override
    protected Void getDefault(Shape shape) {
        Symbol symbol = context.symbolProvider().toSymbol(shape);
        writer.writeInline(symbol.getProperty("rbsType", String.class).orElse("untyped"));
        return null;
    }

    @Override
    public Void enumShape(EnumShape shape) {
        String values = shape.getEnumValues().values().stream()
                .map(v -> "\"" + v + "\"")
                .collect(Collectors.joining(" | "));
        writer.write("($L)", values);
        return null;
    }

    @Override
    public Void listShape(ListShape shape) {
        Shape target = context.model().expectShape(shape.getMember().getTarget());
        writer.write("::Array[$L]", targetSubType(target));
        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        Shape target = context.model().expectShape(shape.getValue().getTarget());
        writer.write("::Hash[::String, $L]", targetSubType(target));

        return null;
    }

    @Override
    public Void operationShape(OperationShape operationShape) {
        Shape inputShape = context.model().expectShape(operationShape.getInputShape());
        for (MemberShape memberShape : inputShape.members()) {
            if (!StreamingTrait.isEventStream(context.model(), memberShape)) {
                String required = memberShape.hasTrait(RequiredTrait.class) ? "" : "?";
                RubyCodeWriter subWriter = new RubyCodeWriter("");
                context.model().expectShape(memberShape.getTarget())
                        .accept(new OperationKeywordArgRbsVisitor(context, subWriter, level + 1));

                String subType = subWriter.toString().trim();
                writer.write("$L$L: $L,",
                        required,
                        context.symbolProvider().toMemberName(memberShape),
                        subType);
            }
        }
        writer.unwrite(",\n");

        return null;
    }

    @Override
    public Void structureShape(StructureShape shape) {
        writer.write("{").indent();
        for (MemberShape memberShape : shape.members()) {
            if (!StreamingTrait.isEventStream(context.model(), memberShape)) {
                Shape target = context.model().expectShape(memberShape.getTarget());
                writer.write("$L: $L,",
                        context.symbolProvider().toMemberName(memberShape),
                        targetSubType(target));
            }
        }
        writer.unwrite(",\n");
        writer.dedent().write("\n}");
        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        writer.write("{").indent();
        for (MemberShape memberShape : shape.members()) {
            Shape target = context.model().expectShape(memberShape.getTarget());
            writer.write("$L: $L,",
                    context.symbolProvider().toMemberName(memberShape),
                    targetSubType(target));
        }
        writer.unwrite(",\n");
        writer.dedent().write("\n}");
        return null;
    }

    private String targetSubType(Shape target) {
        String subType;
        if (level < MAX_LEVEL) {
            RubyCodeWriter subWriter = new RubyCodeWriter("");
            target.accept(new OperationKeywordArgRbsVisitor(context, subWriter, level + 1));
            subType = subWriter.toString().trim();
        } else {
            Symbol symbol = context.symbolProvider().toSymbol(target);
            subType = symbol.getProperty("rbsType", String.class).orElse("untyped");
        }
        return subType;
    }
}
