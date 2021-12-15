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
import software.amazon.smithy.utils.StringUtils;

public class YardDocumentationBuilder {
    // TODO: determine this from indent context from codewriter?
    // hardcode wrapping to 72 characters, to fit 80 character limit
    // accounts for:
    //   three namespace levels (service::module::class_or_method) (4 characters)
    //   leading "# " (2 characters)
    //   indent one extra time for docstring continuations (2 characters)
    private static final int WRAP_LENGTH = 72;

    private final CodeWriter writer;

    public YardDocumentationBuilder() {
        this.writer = new CodeWriter();
    }

    public YardDocumentationBuilder withDocstring(String docstring) {
        String[] docstringParts = getDocumentationParts(docstring);
        if (!docstring.isEmpty()) {
            for (int i = 0; i < docstringParts.length; i++) {
                writer.write("# $L", docstringParts[i]);
            }
            writer.write("#");
        }
        return this;
    }

    public YardDocumentationBuilder withAttribute(String attribute, String attributeDocumentation, String returnValue) {
        writer.write("# @!attribute $L", attribute);
        if (!attributeDocumentation.isEmpty()) {
            String[] attributeParts = getDocumentationParts(attributeDocumentation);
            for (int i = 0; i < attributeParts.length; i++) {
                writer.write("#   $L", attributeParts[i]);
            }
        }
        writer.write("#   @return [$L]", returnValue);
        writer.write("#");
        return this;
    }

    public String build() {
        return writer.toString();
    }

    private String[] getDocumentationParts(String documentation) {
        return StringUtils.wrap(documentation, WRAP_LENGTH).split("\n");
    }
}
