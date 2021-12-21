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

import java.util.Map;
import java.util.Optional;
import software.amazon.smithy.model.SourceLocation;
import software.amazon.smithy.model.traits.DeprecatedTrait;
import software.amazon.smithy.model.traits.DocumentationTrait;
import software.amazon.smithy.model.traits.ExternalDocumentationTrait;
import software.amazon.smithy.model.traits.InternalTrait;
import software.amazon.smithy.model.traits.RecommendedTrait;
import software.amazon.smithy.model.traits.SinceTrait;
import software.amazon.smithy.model.traits.UnstableTrait;
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
     * YARD convenience methods
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

    public RubyCodeWriter writeYardAttribute(String attribute, String documentation, Boolean deprecated,
                                             String deprecatedMessage, String deprecatedSince, String returnType) {
        rdoc(() -> {
            write("@!attribute $L", attribute);
            writeIndentedParts(documentation);
            writeYardDeprecated(deprecated, deprecatedMessage, deprecatedSince);
            write("  @return [$L]", returnType);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardAttribute(String attribute, Optional<DocumentationTrait> optionalDocumentationTrait,
                                             Optional<DeprecatedTrait> optionalDeprecatedTrait, String returnType) {
        String docstring = "";
        if (optionalDocumentationTrait.isPresent()) {
            docstring = optionalDocumentationTrait.get().getValue();
        }
        String deprecatedMessage = "";
        String deprecatedSince = "";
        Boolean deprecated = false;
        if (optionalDeprecatedTrait.isPresent()) {
            deprecated = true;
            deprecatedMessage = optionalDeprecatedTrait.get().getMessage().orElse("");
            deprecatedSince = optionalDeprecatedTrait.get().getSince().orElse("");
        }
        writeYardAttribute(attribute, docstring, deprecated, deprecatedMessage, deprecatedSince, returnType);
        return this;
    }

    public RubyCodeWriter writeYardParam(String returnType, String param, String documentation) {
        rdoc(() -> {
            write("@param [$L] $L", returnType, param);
            writeIndentedParts(documentation);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardOption(String param, String type, String option, String defaultValue,
                                          String documentation) {
        rdoc(() -> {
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

    public RubyCodeWriter writeYardOption(String param, String type, String option, String defaultValue,
                                          Optional<DocumentationTrait> optionalDocumentationTrait) {
        String docstring = "";
        if (optionalDocumentationTrait.isPresent()) {
            docstring = optionalDocumentationTrait.get().getValue();
        }
        writeYardOption(param, type, option, defaultValue, docstring);
        return this;
    }

    public RubyCodeWriter writeYardReturn(String returnType, String documentation) {
        rdoc(() -> {
            write("@return [$L]", returnType);
            writeIndentedParts(documentation);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardExample(String title, String block) {
        rdoc(() -> {
            write("@example $L", title);
            write("");
            writeIndentedParts(block);
            write("");
        });
        return this;
    }

    public RubyCodeWriter writeYardDeprecated(Optional<DeprecatedTrait> optionalDeprecatedTrait) {
        if (optionalDeprecatedTrait.isPresent()) {
            DeprecatedTrait deprecatedTrait = optionalDeprecatedTrait.get();
            String message = deprecatedTrait.getMessage().orElse("");
            String since = deprecatedTrait.getSince().orElse("");
            writeYardDeprecated(true, message, since);
        }
        return this;
    }

    public RubyCodeWriter writeYardDeprecated(Boolean deprecated, String message, String since) {
        if (deprecated) {
            rdoc(() -> {
                write("@deprecated");
                writeIndentedParts(message);
                if (!since.isEmpty()) {
                    write("  Since: $L", since);
                }
                write("");
            });
        }
        return this;
    }

    public RubyCodeWriter writeYardSee(Optional<ExternalDocumentationTrait> optionalExternalDocumentationTrait) {
        if (optionalExternalDocumentationTrait.isPresent()) {
            ExternalDocumentationTrait externalDocumentationTrait = optionalExternalDocumentationTrait.get();
            Map<String, String> urls = externalDocumentationTrait.getUrls();
            writeYardSee(urls);
        }
        return this;
    }

    public RubyCodeWriter writeYardSee(Map<String, String> urls) {
        if (!urls.isEmpty()) {
            rdoc(() -> {
                for (Map.Entry<String, String> entry : urls.entrySet()) {
                    write("@see $L $L", entry.getValue(), entry.getKey());
                }
                write("");
            });
        }
        return this;
    }

    public RubyCodeWriter writeYardNote(String note) {
        if (!note.isEmpty()) {
            rdoc(() -> {
                write("@note");
                writeIndentedParts(note);
                write("");
            });
        }
        return this;
    }

    public RubyCodeWriter writeInternalTrait(Optional<InternalTrait> optionalInternalTrait) {
        if (optionalInternalTrait.isPresent()) {
            writeYardNote("This shape is meant for internal use only.");
        }
        return this;
    }

    public RubyCodeWriter writeRecommendedTrait(Optional<RecommendedTrait> optionalRecommendedTrait) {
        if (optionalRecommendedTrait.isPresent()) {
            Optional<String> optionalReason = optionalRecommendedTrait.get().getReason();
            if (optionalReason.isPresent()) {
                String documentation = "This shape is recommended.\nReason: " + optionalReason.get();
                writeYardNote(documentation);
            }
        }
        return this;
    }

    public RubyCodeWriter writeSinceTrait(String since) {
        if (!since.isEmpty()) {
            rdoc(() -> {
                write("@since $L", since);
                write("");
            });
        }
        return this;
    }

    public RubyCodeWriter writeSinceTrait(Optional<SinceTrait> optionalSinceTrait) {
        if (optionalSinceTrait.isPresent()) {
            String since = optionalSinceTrait.get().getValue();
            writeSinceTrait(since);
        }
        return this;
    }

    public RubyCodeWriter writeUnstableTrait(Optional<UnstableTrait> optionalUnstableTrait) {
        if (optionalUnstableTrait.isPresent()) {
            writeYardNote("This shape is unstable and may change in the future.");
        }
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
