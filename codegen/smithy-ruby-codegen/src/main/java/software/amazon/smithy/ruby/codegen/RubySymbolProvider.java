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
import software.amazon.smithy.utils.CaseUtils;
import software.amazon.smithy.utils.SmithyUnstableApi;
import software.amazon.smithy.utils.StringUtils;

@SmithyUnstableApi
public class RubySymbolProvider implements SymbolProvider,
        ShapeVisitor<Symbol> {
    private final Model model;
    private final RubySettings settings;
    private final String rootModuleName;
    private final String moduleName;
    private final boolean complexTypes;
    private final ReservedWordSymbolProvider.Escaper escaper;

    /**
     * Create a new RubySymbolProvider.
     *
     * @param model    The smithy model to generate for
     * @param settings [RubySettings] settings associated with this codegen
     * @param moduleName The module name
     * @param complexTypes Boolean if type is complex
     */
    public RubySymbolProvider(Model model, RubySettings settings, String moduleName, boolean complexTypes) {
        this.model = model;
        this.settings = settings;
        this.rootModuleName = settings.getModule();
        this.moduleName = this.rootModuleName + "::" + moduleName;
        this.complexTypes = complexTypes;

        escaper = ReservedWordSymbolProvider.builder()
                .nameReservedWords(rubyReservedNames())
                .memberReservedWords(memberReservedNames())
                .buildEscaper();
    }

    private ReservedWords rubyReservedNames() {
        ReservedWordsBuilder reservedNames = new ReservedWordsBuilder();
        String[] reserved =
                {"alias", "break", "BEGIN", "case", "class", "def", "do", "else", "elsif", "end", "ensure", "for",
                        "if", "in", "next", "nil", "module"};

        for (String w : reserved) {
            reservedNames.put(w, w + "_");
        }
        return reservedNames.build();
    }

    private ReservedWords memberReservedNames() {
        ReservedWordsBuilder reservedNames = new ReservedWordsBuilder();
        String[] reserved =
                {"allocate", "superclass", "new", "included_modules", "name", "ancestors", "attr", "attr_reader",
                        "attr_writer", "attr_accessor", "instance_methods", "public_instance_methods",
                        "protected_instance_methods", "private_instance_methods", "constants", "const_get", "const_set",
                        "class_variables", "remove_class_variable", "class_variable_get", "class_variable_set",
                        "freeze", "inspect", "private_constant", "public_constant", "const_missing",
                        "deprecate_constant", "include", "prepend", "module_exec", "module_eval", "class_eval",
                        "remove_method", "undef_method", "class_exec", "alias_method", "to_s", "private_class_method",
                        "public_class_method", "autoload", "instance_method", "public_instance_method", "define_method",
                        "remove_instance_variable", "tap", "instance_variable_set", "protected_methods",
                        "instance_variables", "instance_variable_get", "public_methods", "private_methods", "method",
                        "public_method", "public_send", "singleton_method", "define_singleton_method", "extend",
                        "to_enum", "enum_for", "object_id", "send", "display", "hash", "class", "singleton_class",
                        "clone", "dup", "itself", "yield_self", "then", "taint", "untaint", "untrust", "trust",
                        "methods", "singleton_methods", "instance_exec", "instance_eval", "__id__", "__send__"};
        for (String w : reserved) {
            reservedNames.put(w, "member_" + w);
        }
        return reservedNames.build();
    }

    @Override
    public Symbol toSymbol(Shape shape) {
        Symbol symbol = shape.accept(this);
        return escaper.escapeSymbol(shape, symbol);
    }

    @Override
    public String toMemberName(MemberShape shape) {
        Shape container = model.expectShape(shape.getContainer());
        if (container.isUnionShape()) {
            String memberName = CaseUtils.toPascalCase(getDefaultMemberName(shape));
            if (memberName.equals("Unknown")) {
                return "MemberUnknown";
            } else {
                return memberName;
            }
        } else {
            // Note: we do not need to escape words that are only reserved for error members
            // error classes have parsed data accessible through a `data` member only so there are no conflicts.
            return getDefaultMemberName(shape);
        }
    }

    /**
     * Convert a String shape name into a snake_cased member. Also checks reserved wording.
     * @param shapeName The shape's name as a string
     * @return A snake cased string for the member.
     */
    public String toMemberName(String shapeName) {
        return prefixLeadingInvalidIdentCharacters(
                escaper.escapeMemberName(RubyFormatter.toSnakeCase(shapeName)), "member_");
    }

    // Member names (Except for union members) are snake_case.
    // The member names MAY start with underscores but MUST NOT start with a number.
    // If they are a reserved word or start with a number they will be prefixed with “member_”.
    private String getDefaultMemberName(MemberShape shape) {
        return prefixLeadingInvalidIdentCharacters(
                escaper.escapeMemberName(RubyFormatter.toSnakeCase(shape.getMemberName())), "member__");
    }

    // Shape Names (generated Class names) should be PascalCase
    // they MUST start with a letter (no underscore or digit)
    // if they are a reserved word or start with an invalid character, they will be prefixed
    // the prefix should be based on the type (eg Struct or Union, ect).
    private String getDefaultShapeName(Shape shape, String prefix) {
        ServiceShape serviceShape =
                model.expectShape(settings.getService(), ServiceShape.class);
        return StringUtils.capitalize(
                prefixLeadingInvalidIdentCharacters(
                        shape.getId().getName(serviceShape), prefix)
        );
    }

    private String prefixLeadingInvalidIdentCharacters(String value, String prefix) {
        if (!Character.isLetter(value.charAt(0))) {
            return prefix + value;
        } else {
            return value;
        }
    }

    /**
     * Creates a symbol builder for the shape with the given type name in the root namespace.
     */
    private Symbol.Builder createSymbolBuilder(Shape shape, String type, String rbsType, String yardType) {
        return Symbol.builder()
                .putProperty("shape", shape)
                .putProperty("rbsType", rbsType)
                .putProperty("yardType", yardType)
                .name(type);
    }

    /**
     * Creates a symbol builder for the shape with the given type name in a child namespace relative
     * to the root namespace e.g. `relativeNamespace = bar` with a root namespace of `foo` would set
     * the namespace (and ultimately the package name) to `foo.bar` for the symbol.
     */
    private Symbol.Builder createSymbolBuilder(Shape shape, String type, String rbsType,
                                               String yardType, String namespace) {
        return createSymbolBuilder(shape, type, rbsType, yardType).namespace(namespace, "::");
    }

    @Override
    public Symbol stringShape(StringShape shape) {
        return createSymbolBuilder(shape, "", "String", "String").build();
    }

    @Override
    public Symbol blobShape(BlobShape shape) {
        return createSymbolBuilder(shape, "", "String", "String").build();
    }

    @Override
    public Symbol booleanShape(BooleanShape shape) {
        return createSymbolBuilder(shape, "", "bool", "Boolean").build();
    }

    @Override
    public Symbol byteShape(ByteShape shape) {
        return createSymbolBuilder(shape, "", "Integer", "Integer").build();
    }

    @Override
    public Symbol shortShape(ShortShape shape) {
        return createSymbolBuilder(shape, "", "Integer", "Integer").build();
    }

    @Override
    public Symbol integerShape(IntegerShape shape) {
        return createSymbolBuilder(shape, "", "Integer", "Integer").build();
    }

    @Override
    public Symbol longShape(LongShape shape) {
        return createSymbolBuilder(shape, "", "Integer", "Integer").build();
    }

    @Override
    public Symbol floatShape(FloatShape shape) {
        return createSymbolBuilder(shape, "", "Float", "Float").build();
    }

    @Override
    public Symbol doubleShape(DoubleShape shape) {
        return createSymbolBuilder(shape, "", "Float", "Float").build();
    }

    @Override
    public Symbol bigIntegerShape(BigIntegerShape shape) {
        return createSymbolBuilder(shape, "", "Integer", "Integer").build();
    }

    @Override
    public Symbol bigDecimalShape(BigDecimalShape shape) {
        return createSymbolBuilder(shape, "", "BigDecimal", "BigDecimal")
                .addDependency(RubyDependency.BIG_DECIMAL).build();
    }

    @Override
    public Symbol timestampShape(TimestampShape shape) {
        RubyDependency d = RubyDependency.TIME;
        return createSymbolBuilder(shape, "", "Time", "Time")
                .addDependency(d).build();
    }

    @Override
    public Symbol listShape(ListShape shape) {
        if (complexTypes) {
            return createSymbolBuilder(shape, getDefaultShapeName(shape, "List__"), "", "", moduleName)
                    .definitionFile("types.rb").build();
        } else {
            Symbol member = toSymbol(model.expectShape(shape.getMember().getTarget()));
            String rbsType = "Array[" + member.getProperty("rbsType").get() + "]";
            String yardType = "Array<" + member.getProperty("yardType").get() + ">";
            return createSymbolBuilder(shape, "", rbsType, yardType).build();
        }
    }

    @Override
    public Symbol setShape(SetShape shape) {
        if (complexTypes) {
            return createSymbolBuilder(shape, getDefaultShapeName(shape, "Set__"), "", "", moduleName)
                    .definitionFile("types.rb").build();
        } else {
            Symbol member = toSymbol(model.expectShape(shape.getMember().getTarget()));
            String rbsType = "Set[" + member.getProperty("rbsType").get() + "]";
            String yardType = "Set<" + member.getProperty("yardType").get() + ">";
            return createSymbolBuilder(shape, "", rbsType, yardType).build();
        }
    }

    @Override
    public Symbol mapShape(MapShape shape) {
        if (complexTypes) {
            return createSymbolBuilder(shape, getDefaultShapeName(shape, "Map__"), "", "", moduleName)
                    .definitionFile("types.rb").build();
        } else {
            Symbol key = toSymbol(model.expectShape(shape.getKey().getTarget()));
            Symbol value = toSymbol(model.expectShape(shape.getValue().getTarget()));
            String rbsType
                    = "Hash[" + key.getProperty("rbsType").get() + ", " + value.getProperty("rbsType").get() + "]";
            String yardType
                    = "Hash<" + key.getProperty("yardType").get() + ", " + value.getProperty("yardType").get() + ">";
            return createSymbolBuilder(shape, "", rbsType, yardType).build();
        }
    }

    @Override
    public Symbol documentShape(DocumentShape shape) {
        if (complexTypes) {
            return createSymbolBuilder(shape, getDefaultShapeName(shape, "Document__"), "", "", moduleName)
                    .definitionFile("types.rb").build();
        } else {
            String rbsType = "document"; // alias defined in Hearth
            String yardType = "Hash,Array,String,Boolean,Numeric";
            return createSymbolBuilder(shape, "", rbsType, yardType).build();
        }
    }

    @Override
    public Symbol serviceShape(ServiceShape shape) {
        return createSymbolBuilder(shape, "Client", "", "")
                .namespace(rootModuleName, "::")
                .definitionFile("client.rb").build();
    }

    @Override
    public Symbol structureShape(StructureShape shape) {
        String name = getDefaultShapeName(shape, "Struct__");
        return createSymbolBuilder(shape, name, name, name, moduleName)
                .definitionFile("types.rb").build();
    }

    @Override
    public Symbol unionShape(UnionShape shape) {
        String name = getDefaultShapeName(shape, "Union__");
        return createSymbolBuilder(shape, name, name, name, moduleName)
                .definitionFile("types.rb").build();
    }

    @Override
    public Symbol memberShape(MemberShape shape) {
        Shape targetShape = model.expectShape(shape.getTarget());
        return toSymbol(targetShape);
    }

    @Override
    public Symbol operationShape(OperationShape shape) {
        return createSymbolBuilder(shape, getDefaultShapeName(shape, "Operation__"), "", "", moduleName)
                .definitionFile("types.rb").build();
    }

    @Override
    public Symbol resourceShape(ResourceShape shape) {
        throw new CodegenException("Resources are not currently supported");
    }
}
