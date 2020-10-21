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
    public static CodeWriter createDefault() {
        CodeWriter writer =
                new CodeWriter().trimTrailingSpaces().setIndentText("  ");
        writer.write("# frozen_string_literal: true\n");

        writer.write("# WARNING ABOUT GENERATED CODE")
                .write("#")
                .write("# This file was code generated using smithy-ruby.")
                .write("# https://github.com/awslabs/smithy-ruby")
                .write("#")
                .write("# WARNING ABOUT GENERATED CODE\n");

        return writer;
    }
//
//    public CodeWriter rdoc(Runnable runnable) {
//        pushState();
//        setNewlinePrefix("# ");
//        runnable.run();
//        popState();
//        return this;
//    }
}
