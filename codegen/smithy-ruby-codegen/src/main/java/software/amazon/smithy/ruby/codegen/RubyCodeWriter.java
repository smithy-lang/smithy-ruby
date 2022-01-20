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

import software.amazon.smithy.utils.CodeWriter;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * A helper class for generating well formatted Ruby code.
 */
@SmithyUnstableApi
public class RubyCodeWriter extends CodeWriter {
    public RubyCodeWriter() {
        trimTrailingSpaces();
        trimBlankLines();
        setIndentText("  ");
    }

    /**
     * Writes preamble comments.
     * For writers that are used to generate full files, this should
     * be called before any other write methods.
     *
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter writePreamble() {
        write("# frozen_string_literal: true\n");
        write("# WARNING ABOUT GENERATED CODE");
        write("#");
        write("# This file was code generated using smithy-ruby.");
        write("# https://github.com/awslabs/smithy-ruby");
        write("#");
        write("# WARNING ABOUT GENERATED CODE\n");
        return this;
    }

    /**
     * Sets formatting for writing Rdoc doc comments.
     *
     * @param task All lines written by the task will be prefixed with the comment string.
     * @return Returns the CodeWriter
     */
    public RubyCodeWriter doc(Runnable task) {
        pushState();
        setNewlinePrefix("# ");
        task.run();
        popState();
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
        doc(() -> {
            write("@!attribute $L", attribute);
            pushFilteredState(s -> s.replace("#", " "));
            task.run();
            popState();
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
        doc(() -> {
            write("$L", docstring);
            write("");
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
        doc(() -> {
            write("@param [$L] $L", returnType, param);
            writeIndentedParts(documentation);
            write("");
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
        doc(() -> {
            writeInline("@option $L [$L] $L", param, type, option);
            if (!defaultValue.isEmpty()) {
                write(" ($L)", defaultValue);
            } else {
                write("");
            }
            writeIndentedParts(documentation);
            write("");
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
        doc(() -> {
            write("@return [$L]", returnType);
            writeIndentedParts(documentation);
            write("");
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
        doc(() -> {
            write("@example $L", title);
            write("");
            writeIndentedParts(block);
            write("");
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
        doc(() -> {
            write("@deprecated");
            writeIndentedParts(message);
            if (!since.isEmpty()) {
                write("  Since: $L", since);
            }
            write("");
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
        doc(() -> {
            write("@see $L $L", url, description);
            write("");
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
        doc(() -> {
            write("@note");
            writeIndentedParts(note);
            write("");
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
        doc(() -> {
            write("@since $L", since);
            write("");
        });
        return this;
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
}
