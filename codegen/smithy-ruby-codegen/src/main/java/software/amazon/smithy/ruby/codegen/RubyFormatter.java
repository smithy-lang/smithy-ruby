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

import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Utilities for formatting strings for Ruby.
 */
@SmithyUnstableApi
public final class RubyFormatter {

    private RubyFormatter() {

    }

    /**
     * Formats a string as a snake case symbol.
     *
     * @param s Symbol Name to format
     * @return String formatted as a ruby symbol
     */
    public static String asSymbol(String s) {
        return ":" + toSnakeCase(s);
    }

    /**
     * Formats a string in snake_case.
     *
     * @param s Symbol Name to format
     * @return String formatted in snake_case
     */
    public static String toSnakeCase(String s) {
        return s
                .replaceAll("([A-Z\\d]+)([A-Z][a-z])", "$1_$2")
                .replaceAll("([a-z\\d])([A-Z])", "$1_$2")
                .replace('-', '_')
                .toLowerCase();
    }
}
