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

public class RubyCodeWriter extends CodeWriter {
    public RubyCodeWriter() {
        trimTrailingSpaces();
        trimBlankLines();
        setIndentText("  ");
    }

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

    public RubyCodeWriter doc(Runnable task) {
        pushState();
        setNewlinePrefix("# ");
        task.run();
        popState();
        return this;
    }

    public void writeWithNoFormatting(String s) {
        pushState();
        setExpressionStart('*');
        write(s);
        popState();
    }

    /*
     * YARD convenience methods
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

    public RubyCodeWriter writeDocstring(String docstring) {
        doc(() -> {
            write(docstring);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardParam(String returnType, String param, String documentation) {
        doc(() -> {
            write("@param [$L] $L", returnType, param);
            writeIndentedParts(documentation);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardOption(String param, String type, String option, String defaultValue,
                                          String documentation) {
        doc(() -> {
            writeInline("@option $L [$L] $L", param, type, option);
            if (!defaultValue.isEmpty()) {
                write("($S)", defaultValue);
            } else {
                write("");
            }
            writeIndentedParts(documentation);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardReturn(String returnType, String documentation) {
        doc(() -> {
            write("@return [$L]", returnType);
            writeIndentedParts(documentation);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardExample(String title, String block) {
        doc(() -> {
            write("@example $L", title);
            write("");
            writeIndentedParts(block);
            write("");
        });
        return this;
    }

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

    public RubyCodeWriter writeYardSee(String url, String description) {
        doc(() -> {
            write("@see $L $L", url, description);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardNote(String note) {
        doc(() -> {
            write("@note");
            writeIndentedParts(note);
            write("");
        });
        return this;
    }

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
