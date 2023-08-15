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

package software.amazon.smithy.ruby.codegen.middleware.factories;

import java.util.HashMap;
import java.util.Map;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class BuildMiddlewareFactory implements MiddlewareFactory {
    private BuildMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        SymbolProvider symbolProvider = context.symbolProvider();

        return Middleware.builder()
                .klass(Hearth.BUILD_MIDDLEWARE)
                .step(MiddlewareStackStep.BUILD)
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("builder",
                            "Builders::" + symbolProvider.toSymbol(operation).getName());
                    return params;
                })
                .build();
    }
}
