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

package software.amazon.smithy.ruby.codegen;

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
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntEnumShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ResourceShape;
import software.amazon.smithy.model.shapes.ServiceShape;
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

/**
 * Ruby implementation of SymbolProvider.
 */
@SmithyUnstableApi
public class RubySymbolProvider implements SymbolProvider,
        ShapeVisitor<Symbol> {
    public static final ReservedWordSymbolProvider.Escaper ESCAPER = ReservedWordSymbolProvider.builder()
            .nameReservedWords(rubyReservedNames())
            .memberReservedWords(memberReservedNames())
            .buildEscaper();

    private static final String DEFAULT_DEFINITION_FILE = "types.rb";

    private final Model model;
    private final RubySettings settings;
    private final String rootModuleName;
    private final String moduleName;

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
        this.moduleName = this.rootModuleName + "::Types";
    }

    // Taken from https://docs.ruby-lang.org/en/3.1/doc/keywords_rdoc.html
    // Some of these will never occur (like defined?) but define the entire list anyway for safety.
    private static ReservedWords rubyReservedNames() {
        ReservedWordsBuilder reservedNames = new ReservedWordsBuilder();
        String[] reserved =
                {"__ENCODING__", "__LINE__", "__FILE__", "BEGIN", "END", "alias", "and", "begin", "break", "case",
                        "class", "def", "defined?", "do", "else", "elsif", "end", "ensure", "false", "for",
                        "if", "in", "module", "next", "nil", "not", "or", "redo", "rescue", "retry", "return",
                        "self", "super", "then", "true", "undef", "unless", "until", "when", "while", "yield"};

        for (String w : reserved) {
            reservedNames.put(w, w + "_");
        }

        // Reserved base Error classes
        reservedNames.put("ApiError", "ApiError_");
        reservedNames.put("ApiClientError", "ApiClientError_");
        reservedNames.put("ApiServerError", "ApiServerError_");
        // TODO: should be protocol specific from ProtocolGenerator
        reservedNames.put("ApiRedirectError", "ApiRedirectError_");

        return reservedNames.build();
    }

    // Mark all instances methods of a class as reserved. Shape members are accessors of a class.
    // Taken from "class Foo; end; Foo.new.methods.sort".
    // Additionally add "each_pair" as we leverage this methods for Type's to_h of Struct.
    private static ReservedWords memberReservedNames() {
        ReservedWordsBuilder reservedNames = new ReservedWordsBuilder();
        String[] reserved =
                {"!", "!=", "!~", "<=>", "==", "===", "=~", "__id__", "__send__", "class", "clone",
                        "define_singleton_method", "display", "dup", "enum_for", "eql?", "equal?", "extend", "freeze",
                        "frozen?", "hash", "inspect", "instance_eval", "instance_exec", "instance_of?",
                        "instance_variable_defined?", "instance_variable_get", "instance_variable_set",
                        "instance_variables", "is_a?", "itself", "kind_of?", "method", "methods", "nil?", "object_id",
                        "pretty_inspect", "pretty_print", "pretty_print_cycle", "pretty_print_inspect",
                        "pretty_print_instance_variables", "private_methods", "protected_methods", "public_method",
                        "public_methods", "public_send", "remove_instance_variable", "respond_to?", "send",
                        "singleton_class", "singleton_method", "singleton_methods", "taint", "tainted?", "tap", "then",
                        "to_enum", "to_s", "trust", "untaint", "untrust", "untrusted?", "yield_self",
                        "each_pair" };

        for (String w : reserved) {
            reservedNames.put(w, "member_" + w);
        }
        return reservedNames.build();
    }

    @Override
    public Symbol toSymbol(Shape shape) {
        return ESCAPER.escapeSymbol(shape, shape.accept(this));
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
    public static String toMemberName(String shapeName) {
        return RubyFormatter.prefixLeadingInvalidIdentCharacters(
            ESCAPER.escapeMemberName(RubyFormatter.toSnakeCase(shapeName)), "member_");
    }

    // Member names (Except for union members) are snake_case.
    // The member names MAY start with underscores but MUST NOT start with a number.
    // If they are a reserved word or start with a number they will be prefixed with “member_”.
    private String getDefaultMemberName(MemberShape shape) {
        return RubyFormatter.prefixLeadingInvalidIdentCharacters(
            ESCAPER.escapeMemberName(RubyFormatter.toSnakeCase(shape.getMemberName())), "member_");
    }

    // Shape Names (generated Class names) should be PascalCase
    // they MUST start with a letter (no underscore or digit)
    // if they are a reserved word or start with an invalid character, they will be prefixed
    // the prefix should be based on the type (eg Struct or Union, ect).
    private String getDefaultShapeName(Shape shape, String prefix) {
        ServiceShape serviceShape =
                model.expectShape(settings.getService(), ServiceShape.class);
        return StringUtils.capitalize(
                RubyFormatter.prefixLeadingInvalidIdentCharacters(
                        shape.getId().getName(serviceShape), prefix)
        );
    }

    /**
     * Creates a symbol builder for the shape with the given type name in the root namespace.
     */
    private Symbol.Builder createSymbolBuilder(Shape shape, String type, String rbsType, String docType) {
        return Symbol.builder()
                .putProperty("shape", shape)
                .putProperty("rbsType", rbsType)
                .putProperty("docType", docType)
                .name(type);
    }

    /**
     * Creates a symbol builder for the shape with the given type name in a child namespace relative
     * to the root namespace e.g. `relativeNamespace = bar` with a root namespace of `foo` would set
     * the namespace (and ultimately the package name) to `foo.bar` for the symbol.
     */
    private Symbol.Builder createSymbolBuilder(Shape shape, String type, String rbsType,
                                               String docType, String namespace) {
        return createSymbolBuilder(shape, type, rbsType, docType).namespace(namespace, "::");
    }

    @Override
    public Symbol stringShape(StringShape shape) {
        return createSymbolBuilder(shape, getDefaultShapeName(shape, "String__"), "::String", "String").build();
    }

    @Override
    public Symbol intEnumShape(IntEnumShape shape) {
        return createSymbolBuilder(shape, getDefaultShapeName(shape, ""), "::Integer", "Integer").build();
    }

    @Override
    public Symbol enumShape(EnumShape shape) {
        return createSymbolBuilder(shape, getDefaultShapeName(shape, ""), "::String", "String").build();
    }

    @Override
    public Symbol blobShape(BlobShape shape) {
        return createSymbolBuilder(shape, "", "::String", "String").build();
    }

    @Override
    public Symbol booleanShape(BooleanShape shape) {
        return createSymbolBuilder(shape, "", "bool", "Boolean").build();
    }

    @Override
    public Symbol byteShape(ByteShape shape) {
        return createSymbolBuilder(shape, "", "::Integer", "Integer").build();
    }

    @Override
    public Symbol shortShape(ShortShape shape) {
        return createSymbolBuilder(shape, "", "::Integer", "Integer").build();
    }

    @Override
    public Symbol integerShape(IntegerShape shape) {
        return createSymbolBuilder(shape, "", "::Integer", "Integer").build();
    }

    @Override
    public Symbol longShape(LongShape shape) {
        return createSymbolBuilder(shape, "", "::Integer", "Integer").build();
    }

    @Override
    public Symbol floatShape(FloatShape shape) {
        return createSymbolBuilder(shape, "", "::Float", "Float").build();
    }

    @Override
    public Symbol doubleShape(DoubleShape shape) {
        return createSymbolBuilder(shape, "", "::Float", "Float").build();
    }

    @Override
    public Symbol bigIntegerShape(BigIntegerShape shape) {
        return createSymbolBuilder(shape, "", "::Integer", "Integer").build();
    }

    @Override
    public Symbol bigDecimalShape(BigDecimalShape shape) {
        return createSymbolBuilder(shape, "", "::BigDecimal", "BigDecimal")
                .addDependency(RubyDependency.BIG_DECIMAL).build();
    }

    @Override
    public Symbol timestampShape(TimestampShape shape) {
        RubyDependency d = RubyDependency.TIME;
        return createSymbolBuilder(shape, "", "::Time", "Time")
                .addDependency(d).build();
    }

    @Override
    public Symbol listShape(ListShape shape) {
        Symbol member = toSymbol(model.expectShape(shape.getMember().getTarget()));
        String rbsType = "::Array[" + member.getProperty("rbsType").get() + "]";
        String docType = "Array<" + member.getProperty("docType").get() + ">";
        return createSymbolBuilder(shape, getDefaultShapeName(shape, "List__"), rbsType, docType, moduleName)
                .definitionFile(DEFAULT_DEFINITION_FILE)
                .build();
    }

    @Override
    public Symbol mapShape(MapShape shape) {
        Symbol key = toSymbol(model.expectShape(shape.getKey().getTarget()));
        Symbol value = toSymbol(model.expectShape(shape.getValue().getTarget()));
        String rbsType
                = "::Hash[" + key.getProperty("rbsType").get() + ", " + value.getProperty("rbsType").get() + "]";
        String docType
                = "Hash<" + key.getProperty("docType").get() + ", " + value.getProperty("docType").get() + ">";
        return createSymbolBuilder(shape, getDefaultShapeName(shape, "Map__"), rbsType, docType, moduleName)
                .definitionFile(DEFAULT_DEFINITION_FILE)
                .build();
    }

    @Override
    public Symbol documentShape(DocumentShape shape) {
        String rbsType = "Hearth::document"; // alias defined in Hearth
        String docType = "Hash, Array, String, Boolean, Numeric";
        return createSymbolBuilder(shape, getDefaultShapeName(shape, "Document__"), rbsType, docType, moduleName)
                .definitionFile(DEFAULT_DEFINITION_FILE)
                .build();
    }

    @Override
    public Symbol serviceShape(ServiceShape shape) {
        return createSymbolBuilder(shape, "Client", "::Client", "Client")
                .namespace(rootModuleName, "::")
                .definitionFile("client.rb").build();
    }

    @Override
    public Symbol structureShape(StructureShape shape) {
        String name = getDefaultShapeName(shape, "Struct__");
        return createSymbolBuilder(shape, name, "Types::" + name, name, moduleName)
                .definitionFile(DEFAULT_DEFINITION_FILE).build();
    }

    @Override
    public Symbol unionShape(UnionShape shape) {
        String name = getDefaultShapeName(shape, "Union__");
        return createSymbolBuilder(shape, name, "Types::" + name, name, moduleName)
                .definitionFile(DEFAULT_DEFINITION_FILE).build();
    }

    @Override
    public Symbol memberShape(MemberShape shape) {
        Shape targetShape = model.expectShape(shape.getTarget());
        Shape containerShape = model.expectShape(shape.getContainer());
        if (containerShape.isUnionShape()) {
            String name = getDefaultShapeName(containerShape, "Union__") + "::" + toMemberName(shape);
            return createSymbolBuilder(shape, name, name, name, moduleName)
                    .definitionFile(DEFAULT_DEFINITION_FILE).build();
        } else {
            return toSymbol(targetShape);
        }
    }

    @Override
    public Symbol operationShape(OperationShape shape) {
        return createSymbolBuilder(shape, getDefaultShapeName(shape, "Operation__"), "", "", moduleName)
                .definitionFile(DEFAULT_DEFINITION_FILE).build();
    }

    @Override
    public Symbol resourceShape(ResourceShape shape) {
        // TODO: handle ResourceShape code generation and define Symbol definitionFile
        return Symbol.builder()
            .name(getDefaultShapeName(shape, "Resources__"))
            .namespace(moduleName, "::")
            .build();
    }
}
