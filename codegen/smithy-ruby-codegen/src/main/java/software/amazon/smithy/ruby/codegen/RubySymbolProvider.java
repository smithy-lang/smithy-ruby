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

package software.amazon.smithy.ruby.codegen;

import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.codegen.core.ReservedWordSymbolProvider;
import software.amazon.smithy.codegen.core.ReservedWords;
import software.amazon.smithy.codegen.core.ReservedWordsBuilder;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.BooleanShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ResourceShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.utils.StringUtils;

public class RubySymbolProvider implements SymbolProvider,
        ShapeVisitor<Symbol> {
    private final Model model;
    private final RubySettings settings;
    private final String rootModuleName;
    private final String shapesPackageName;
    private final ReservedWordSymbolProvider.Escaper escaper;


    /**
     * Create a new RubySymbolProvider.
     *
     * @param model    The smithy model to generate for
     * @param settings [RubySettings] settings associated with this codegen
     */
    public RubySymbolProvider(Model model, RubySettings settings) {
        this.model = model;
        this.settings = settings;
        this.rootModuleName = settings.getModule();
        this.shapesPackageName = this.rootModuleName + "::Shapes";

        ReservedWords reservedWords = rubyReservedNames();

        escaper = ReservedWordSymbolProvider.builder()
                .nameReservedWords(reservedWords)
                .memberReservedWords(reservedWords)
                .buildEscaper();
    }

    private ReservedWords rubyReservedNames() {
        ReservedWordsBuilder reservedNames = new ReservedWordsBuilder();
        reservedNames
                .put("alias", "_alias")
                .put("break", "_break")
                .put("begin", "_begin")
                .put("case", "_case")
                .put("class", "_class")
                .put("def", "_def")
                .put("do", "_do")
                .put("else", "_else")
                .put("elsif", "_elsif")
                .put("end", "_end")
                .put("ensure", "_ensure")
                .put("for", "_for")
                .put("if", "_if")
                .put("in", "_in")
                .put("next", "_next")
                .put("nil", "_nil")
                .put("module", "_module");
        return reservedNames.build();
    }

    @Override
    public Symbol toSymbol(Shape shape) {
        Symbol symbol = shape.accept(this);
        return escaper.escapeSymbol(shape, symbol);
    }

    @Override
    public String toMemberName(MemberShape shape) {
        // Shape container = model.expectShape(shape.getContainer());
        // TODO: handle container.isUnionShape() if required

        String memberName = getDefaultMemberName(shape);
        memberName = escaper.escapeMemberName(memberName);

        // TODO: Escape words reserved for the specific container.
        // TODO: Escape words that are only reserved for error members.
        return memberName;
    }

    private String getDefaultMemberName(MemberShape shape) {
        return RubyFormatter.toSnakeCase(
                removeLeadingInvalidIdentCharacters(shape.getMemberName())
        );
    }

    private String getDefaultShapeName(Shape shape) {
        ServiceShape serviceShape =
                model.expectShape(settings.getService(), ServiceShape.class);
        return StringUtils.capitalize(
                removeLeadingInvalidIdentCharacters(
                        shape.getId().getName(serviceShape))
        );
    }

    private String removeLeadingInvalidIdentCharacters(String value) {
        if (Character.isAlphabetic(value.charAt(0))) {
            return value;
        }
        int i;
        for (i = 0; i < value.length(); i++) {
            if (Character.isAlphabetic(value.charAt(i))) {
                break;
            }
        }

        String remaining = value.substring(i);
        if (remaining.length() == 0) {
            throw new CodegenException("tried to clean name " + value
                    + ", but resulted in empty string");
        }

        return remaining;
    }

    /**
     * Creates a symbol builder for the shape with the given type name in the root namespace.
     */
    private Symbol.Builder createSymbolBuilder(Shape shape, String typeName) {
        return Symbol.builder()
                .putProperty("shape", shape)
                .name(typeName);
    }

    /**
     * Creates a symbol builder for the shape with the given type name in a child namespace relative
     * to the root namespace e.g. `relativeNamespace = bar` with a root namespace of `foo` would set
     * the namespace (and ultimately the package name) to `foo.bar` for the symbol.
     */
    private Symbol.Builder createSymbolBuilder(
            Shape shape,
            String typeName,
            String namespace) {
        return createSymbolBuilder(shape, typeName).namespace(namespace, "::");
    }

    @Override
    public Symbol stringShape(StringShape shape) {
        return createSymbolBuilder(shape, "String").build();
    }

    @Override
    public Symbol blobShape(BlobShape shape) {
        return createSymbolBuilder(shape, "String").build();
    }

    @Override
    public Symbol booleanShape(BooleanShape shape) {
        return createSymbolBuilder(shape, "bool").build();
    }

    @Override
    public Symbol byteShape(ByteShape shape) {
        return createSymbolBuilder(shape, "Integer").build();
    }

    @Override
    public Symbol shortShape(ShortShape shape) {
        return createSymbolBuilder(shape, "Integer").build();
    }

    @Override
    public Symbol integerShape(IntegerShape shape) {
        return createSymbolBuilder(shape, "Integer").build();
    }

    @Override
    public Symbol longShape(LongShape shape) {
        return createSymbolBuilder(shape, "Integer").build();
    }

    @Override
    public Symbol floatShape(FloatShape shape) {
        return createSymbolBuilder(shape, "Float").build();
    }

    @Override
    public Symbol doubleShape(DoubleShape shape) {
        return createSymbolBuilder(shape, "Float").build();
    }

    @Override
    public Symbol bigIntegerShape(BigIntegerShape shape) {
        return createSymbolBuilder(shape, "Integer").build();
    }

    @Override
    public Symbol bigDecimalShape(BigDecimalShape shape) {
        return createSymbolBuilder(shape, "BigDecimal")
                .addDependency(RubyDependency.BIG_DECIMAL).build();
    }

    @Override
    public Symbol timestampShape(TimestampShape shape) {
        RubyDependency d = RubyDependency.TIME;
        System.out.println("TIME: " + d);
        return createSymbolBuilder(shape, "Time")
                .addDependency(d).build();
    }


    @Override
    public Symbol listShape(ListShape shape) {
        Symbol member = toSymbol(
                model.expectShape(shape.getMember().getTarget()));
        String type = "Array[" + member.getName() + "]";
        return createSymbolBuilder(shape, type).build();
    }

    @Override
    public Symbol setShape(SetShape shape) {
        Symbol member = toSymbol(
                model.expectShape(shape.getMember().getTarget()));
        String type = "Set[" + member.getName() + "]";
        return createSymbolBuilder(shape, type).build();
    }

    @Override
    public Symbol mapShape(MapShape shape) {
        Symbol key = toSymbol(
                model.expectShape(shape.getKey().getTarget()));
        Symbol value = toSymbol(
                model.expectShape(shape.getValue().getTarget()));
        String type = "Hash[" + key.getName() + ", " + value.getName() + "]";
        return createSymbolBuilder(shape, type).build();
    }

    @Override
    public Symbol documentShape(DocumentShape shape) {
        // TODO
        return createSymbolBuilder(shape, "Document").build();
    }

    @Override
    public Symbol serviceShape(ServiceShape shape) {
        return createSymbolBuilder(shape, "Client")
                .namespace(rootModuleName, "::")
                .definitionFile("client.rb").build();
    }

    @Override
    public Symbol structureShape(StructureShape shape) {
        String name = getDefaultShapeName(shape);
        Symbol.Builder builder = createSymbolBuilder(shape, name, shapesPackageName)
                .definitionFile("types.rb");
        return builder.build();
    }

    @Override
    public Symbol unionShape(UnionShape shape) {
        // TODO: Confirm this implementation is correct after impl of Unions
        String name = getDefaultShapeName(shape);
        Symbol.Builder builder = createSymbolBuilder(shape, name, shapesPackageName)
                .definitionFile("types.rb");
        return builder.build();
    }

    @Override
    public Symbol memberShape(MemberShape shape) {
        Shape targetShape = model.expectShape(shape.getTarget());
        return toSymbol(targetShape);
    }

    @Override
    public Symbol operationShape(OperationShape shape) {
        // We do not currently generate shapes for operations
        throw new CodegenException("Unexpected codegen path");
    }

    @Override
    public Symbol resourceShape(ResourceShape shape) {
        throw new CodegenException("Resources are not currently supported");
    }
}
