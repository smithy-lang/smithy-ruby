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
import java.util.Optional;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class ParseMiddlewareFactory implements MiddlewareFactory {
    private ParseMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        SymbolProvider symbolProvider = context.symbolProvider();

        return Middleware.builder()
                .klass(Hearth.PARSE_MIDDLEWARE)
                .step(MiddlewareStackStep.PARSE)
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("data_parser", "Parsers::" + symbolProvider.toSymbol(operation).getName());
                    String successCode = "200";
                    Optional<HttpTrait> httpTrait = operation.getTrait(HttpTrait.class);
                    if (httpTrait.isPresent()) {
                        successCode = "" + httpTrait.get().getCode();
                    }
                    String errors = operation.getErrors()
                            .stream()
                            .map((error) -> "Errors::"
                                    + symbolProvider.toSymbol(ctx.model().expectShape(error)).getName())
                            .collect(Collectors.joining(", "));
                    String errorParser = """
                            Hearth::HTTP::ErrorParser.new(
                              error_module: Errors,
                              success_status: %s,
                              errors: [%s]
                            )""".formatted(successCode, errors);
                    params.put("error_parser", errorParser);
                    return params;
                })
                .build();
    }
}
