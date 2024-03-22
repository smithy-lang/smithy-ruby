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

import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.RequiredTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;

public class OperationKeywordArgRbsVisitor extends ShapeVisitor.Default<Void> {

    private final GenerationContext context;

    private final RubyCodeWriter writer;

    public OperationKeywordArgRbsVisitor(GenerationContext context, RubyCodeWriter writer) {
        this.context = context;
        this.writer = writer;
    }

    @Override
    protected Void getDefault(Shape shape) {
        Symbol symbol = context.symbolProvider().toSymbol(shape);
        // TODO: This does not always return types in the correct namespace
        writer.writeInline(symbol.getProperty("rbsType").orElse("untyped"));
        return null;
    }

    @Override
    public Void operationShape(OperationShape operationShape) {
        Shape inputShape = context.model().expectShape(operationShape.getInputShape());
        for (MemberShape memberShape : inputShape.members()) {
            String required = memberShape.hasTrait(RequiredTrait.class) ? "" : "?";
            writer.writeInline("$L$L: ",
                    required,
                    context.symbolProvider().toMemberName(memberShape));
            context.model().expectShape(memberShape.getTarget()).accept(this);
            writer.write(",");
        }
        writer.unwrite(",\n");

        return null;
    }


    @Override
    public Void structureShape(StructureShape shape) {
        writer.write("{").indent();
        for (MemberShape memberShape : shape.members()) {

            writer.write("$L: untyped,", context.symbolProvider().toMemberName(memberShape));
            // TODO: fix stack over flow on this - caused by use of writeInline
//            writer.writeInline("$L: ", context.symbolProvider().toMemberName(memberShape));
//            context.model().expectShape(memberShape.getTarget()).accept(this);
//            writer.write(",");
        }
        writer.unwrite(",\n");
        writer.dedent().writeInline("\n}");
        return null;
    }
}
