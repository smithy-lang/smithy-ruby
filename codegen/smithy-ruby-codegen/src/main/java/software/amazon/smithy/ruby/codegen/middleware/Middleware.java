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

package software.amazon.smithy.ruby.codegen.middleware;

import java.util.HashMap;
import java.util.stream.Collectors;

import software.amazon.smithy.utils.CodeWriter;

public class Middleware {
    private final String klass;
    private final HashMap<String, String> params;

    // params could include any Ruby code
    public Middleware(String klass, HashMap<String, String> params) {
       this.klass = klass;
       this.params = params;
    }

    public void render(CodeWriter writer) {
        if (params.isEmpty()) {
            writer.write("stack.use($L)", klass);
        }
        else {
            writer.write("stack.use($L,", klass);
            writer.indent();
            String paramsBlock = params
                    .entrySet()
                    .stream()
                    .map(entry -> entry.getKey() + ": " + entry.getValue())
                    .collect(Collectors.joining(",\n"));
            writer.writeInline(paramsBlock);
            writer.dedent();
            writer.write("\n)");
        }
    }
}
