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

import java.util.Optional;
import software.amazon.smithy.model.traits.DocumentationTrait;
import software.amazon.smithy.utils.CodeWriter;

public class RubyCodeWriter extends CodeWriter {
    public RubyCodeWriter() {
        trimTrailingSpaces();
        trimBlankLines();
        setIndentText("  ");

        write("# frozen_string_literal: true\n");
        write("# WARNING ABOUT GENERATED CODE");
        write("#");
        write("# This file was code generated using smithy-ruby.");
        write("# https://github.com/awslabs/smithy-ruby");
        write("#");
        write("# WARNING ABOUT GENERATED CODE\n");
    }

    public RubyCodeWriter rdoc(Runnable task) {
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
     * YARD
     */

    public RubyCodeWriter writeYardDocstring(String docstring) {
        if (!docstring.isEmpty()) {
            rdoc(() -> {
                write(docstring);
                write("");
            });
        }
        return this;
    }

    public RubyCodeWriter writeYardDocstring(Optional<DocumentationTrait> optionalDocumentationTrait) {
        if (optionalDocumentationTrait.isPresent()) {
            String docstring = optionalDocumentationTrait.get().getValue();
            writeYardDocstring(docstring);
        }
        return this;
    }

    public RubyCodeWriter writeYardAttribute(String attribute, String attributeDocumentation, String returnType) {
        rdoc(() -> {
            write("@!attribute $L", attribute);
            if (!attributeDocumentation.isEmpty()) {
                String[] docstringParts = attributeDocumentation.split("\n");
                for (int i = 0; i < docstringParts.length; i++) {
                    write("  $L", docstringParts[i]);
                }
            }
            write("  @return [$L]", returnType);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardAttribute(String attribute, Optional<DocumentationTrait> optionalDocumentationTrait,
                                     String returnType) {
        if (optionalDocumentationTrait.isPresent()) {
            String docstring = optionalDocumentationTrait.get().getValue();
            writeYardAttribute(attribute, docstring, returnType);
        }
        return this;
    }
}
