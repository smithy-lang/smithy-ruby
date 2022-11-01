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

import java.util.Stack;
import java.util.function.BiFunction;
import java.util.function.Consumer;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import software.amazon.smithy.codegen.core.CodegenException;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolReference;
import software.amazon.smithy.codegen.core.SymbolWriter;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * A helper class for generating well formatted Ruby code.
 */
@SmithyUnstableApi
public class RubyCodeWriter extends SymbolWriter<RubyCodeWriter, RubyImportContainer> {

    public static final String QUALIFIED_NAMESPACE = "qualifiedNamespace";
    private static final String PREAMBLE =
            """
                    # frozen_string_literal: true

                    # WARNING ABOUT GENERATED CODE
                    #
                    # This file was code generated using smithy-ruby.
                    # https://github.com/awslabs/smithy-ruby
                    #
                    # WARNING ABOUT GENERATED CODE
                    """;
    private final String namespace;
    private boolean includePreamble = false;
    private boolean includeRequires = false;
    private Stack<String> modules = new Stack<>();

    /**
     * @param namespace namespace to write in
     */
    public RubyCodeWriter(String namespace) {
        super(new RubyImportContainer(namespace));
        this.namespace = namespace;

        trimTrailingSpaces();
        trimBlankLines();
        setIndentText("  ");
        putFormatter('T', new RubySymbolFormatter());
    }

    public void addModule(String name) {
        modules.push(name);
        this.pushState(new ModuleBlockSection(name));
    }

    public void closeModule() {
        if (!modules.isEmpty()) {
            modules.pop();
            this.popState();
        }
    }

    public void closeAllModules() {
        while (!modules.isEmpty()) {
            modules.pop();
            this.popState();
        }
    }

    /**
     * Preamble comments will be included in the generated code.
     * This should be called for writers that are used to generate full files.
     *
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter includePreamble() {
        this.includePreamble = true;
        return this;
    }

    /**
     * Require statments for symbols/dependenices used
     * will be included in the generated code.
     * This should be called for writers that are used to generate full files.
     *
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter includeRequires() {
        this.includeRequires = true;
        return this;
    }

    /**
     * Sets formatting for writing Rdoc doc comments.
     *
     * @param consumer All lines written by the task will be prefixed with the comment string.
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeDocs(Consumer<RubyCodeWriter> consumer) {
        pushState();
        setNewlinePrefix("# ");
        consumer.accept(this);
        popState();
        return this;
    }

    /**
     * Writes a yard method tag.
     *
     * @param methodSignature method signature to document
     * @param task            lines written by the task are properly indented
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardMethod(String methodSignature, Runnable task) {
        writeDocs((w) -> {
            w.write("@!method $L", methodSignature);
            w.pushFilteredState(s -> s.replace("#", " "));
            task.run();
            w.popState();
        });
        return this;
    }

    /*
     * YARD convenience methods
     */

    /**
     * Writes a yard attribute tag.
     *
     * @param attribute name of the attribute
     * @param task      lines written by the task are properly indented
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardAttribute(String attribute, Runnable task) {
        writeDocs((w) -> {
            w.write("@!attribute $L", attribute);
            w.pushFilteredState(s -> s.replace("#", " "));
            task.run();
            w.popState();
        });
        return this;
    }

    /**
     * Write a docstring.
     *
     * @param docstring the docstring to write.
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeDocstring(String docstring) {
        writeDocs((w) -> {
            w.write("$L", docstring);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a yard param.
     *
     * @param returnType    the Ruby Type
     * @param param         name of the parameter
     * @param documentation documentation to write
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardParam(String returnType, String param, String documentation) {
        writeDocs((w) -> {
            w.write("@param [$L] $L", returnType, param);
            w.writeIndentedParts(documentation);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a Yard option.
     *
     * @param param         the name of the param
     * @param type          the Ruby type of the param
     * @param option        name of the option
     * @param defaultValue  default value for the param
     * @param documentation documentation to write
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardOption(String param, String type, String option, String defaultValue,
                                          String documentation) {
        writeDocs((w) -> {
            w.writeInline("@option $L [$L] $L", param, type, option);
            if (!defaultValue.isEmpty()) {
                w.write(" ($L)", defaultValue);
            } else {
                w.write("");
            }
            w.writeIndentedParts(documentation);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a Yard return.
     *
     * @param returnType    the Ruby type
     * @param documentation documentation to write
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardReturn(String returnType, String documentation) {
        writeDocs((w) -> {
            w.write("@return [$L]", returnType);
            w.writeIndentedParts(documentation);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a Yard example.
     *
     * @param title title for the example
     * @param block lines in the block will be properly indented
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardExample(String title, String block) {
        writeDocs((w) -> {
            w.write("@example $L", title);
            w.write("");
            w.writeIndentedParts(block);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a yard deprecated tag.
     *
     * @param message deprecation message
     * @param since   deprecated since
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardDeprecated(String message, String since) {
        writeDocs((w) -> {
            w.write("@deprecated");
            w.writeIndentedParts(message);
            if (!since.isEmpty()) {
                w.write("  Since: $L", since);
            }
            w.write("");
        });
        return this;
    }

    /**
     * Writes a yard see tag.
     *
     * @param url         url to see
     * @param description description of the url
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardSee(String url, String description) {
        writeDocs((w) -> {
            w.write("@see $L $L", url, description);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a yard note.
     *
     * @param note the note to write
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardNote(String note) {
        writeDocs((w) -> {
            w.write("@note");
            w.writeIndentedParts(note);
            w.write("");
        });
        return this;
    }

    /**
     * Writes a yard since tag.
     *
     * @param since since to write
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writeYardSince(String since) {
        writeDocs((w) -> {
            w.write("@since $L", since);
            w.write("");
        });
        return this;
    }

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder();
        if (includePreamble) {
            result.append(PREAMBLE).append("\n");
        }
        if (includeRequires) {
            String requires = getImportContainer().toString();
            if (!requires.isEmpty()) {
                result.append(requires).append("\n");
            }
        }
        result.append(super.toString());
        return result.toString();
    }

    // Writes a documentation indented newline separated string
    private void writeIndentedParts(String documentation) {
        if (!documentation.isEmpty()) {
            String[] docstringParts = documentation.split("\n");
            for (int i = 0; i < docstringParts.length; i++) {
                write("  $L", docstringParts[i]);
            }
        }
    }

    public RubyCodeWriter withQualifiedNamespace(String qualifiedNamespace, Runnable task) {
        pushState(qualifiedNamespace)
                .putContext(QUALIFIED_NAMESPACE, qualifiedNamespace)
                .call(task)
                .popState();
        return this;
    }

    public void addUseImports(RubyDependency dependency) {
        dependency.getDependencies().forEach(d -> getImportContainer().importDependency(d));
    }

    public String getNamespace() {
        return namespace;
    }

    /**
     * RubyCodeWriter factory.
     */
    public static final class Factory implements SymbolWriter.Factory<RubyCodeWriter> {
        @Override
        public RubyCodeWriter apply(String filename, String namespace) {
            return new RubyCodeWriter(namespace);
        }
    }

    /**
     * Adds TypeScript symbols for the "$T" formatter.
     */
    private final class RubySymbolFormatter implements BiFunction<Object, String, String> {
        @Override
        public String apply(Object type, String indent) {
            if (type instanceof Symbol) {
                Symbol typeSymbol = (Symbol) type;
                addUseImports(typeSymbol);
                return relativizeName(typeSymbol);
            } else if (type instanceof SymbolReference) {
                SymbolReference typeSymbol = (SymbolReference) type;
                addImport(typeSymbol.getSymbol(), typeSymbol.getAlias(), SymbolReference.ContextOption.USE);
                return typeSymbol.getAlias();
            } else {
                throw new CodegenException(
                        "Invalid type provided to $T. Expected a Symbol or SymbolReference, but found `" + type + "`");
            }
        }

        private String relativizeName(Symbol symbol) {
            if (symbol.getNamespace().isEmpty()) {
                return "::" + symbol.getName(); // force root namespace
            } else {
                String[] symbolNamespace = symbol.getNamespace().split("::");
                String[] moduleNamespace = namespace.split("::");
                String qualifiedNamespace = getContext(QUALIFIED_NAMESPACE, String.class);
                int i = 0;
                while (i < symbolNamespace.length && i < moduleNamespace.length) {
                    if (!symbolNamespace[i].equals(moduleNamespace[i])
                            || symbolNamespace[i].equals(qualifiedNamespace)) {
                        break;
                    }
                    i++;
                }
                String relativeNamespace = IntStream.range(i, symbolNamespace.length)
                        .mapToObj(j -> symbolNamespace[j])
                        .collect(Collectors.joining("::"));
                if (relativeNamespace.isBlank()) {
                    return symbol.getName();
                } else {
                    return relativeNamespace + "::" + symbol.getName();
                }
            }
        }
    }
}
