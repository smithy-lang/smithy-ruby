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

import java.util.ArrayList;
import java.util.HashMap;

import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.utils.CodeWriter;

public class MiddlewareBuilder {
    private ArrayList<Middleware> middlewares;

    public MiddlewareBuilder(String operationName) {
        this.middlewares = new ArrayList<Middleware>();
        for (Middleware defaultMiddleware : defaultMiddlewares(operationName)) {
            add(defaultMiddleware);
        }
    }

    public void add(Middleware middleware) {
        middlewares.add(middleware);
    }

    public ArrayList<Middleware> getMiddlewares() {
        return middlewares;
    }

    // Default middleware includes build, retry, parse, signing, and sending
    public ArrayList<Middleware> defaultMiddlewares(String operationName) {
        ArrayList<Middleware> defaultMiddleware = new ArrayList<Middleware>();
        HashMap<String, String> params;

        params = new HashMap<>();
        params.put("builder", "Builders::" + operationName + "Operation");
        params.put("params", "params");
        defaultMiddleware.add(
                new Middleware("Seahorse::Middleware::Build", params)
        );

        params = new HashMap<>();
        params.put("max_attempts", "@max_attempts");
        params.put("max_delay", "@max_delay");
        defaultMiddleware.add(
                new Middleware("Seahorse::Middleware::Retry", params)
        );

        params = new HashMap<>();
        params.put("error_parser", "Seahorse::JSON::ErrorParser.new(errors_module: Errors)");
        params.put("data_parser", "Parsers::" + operationName + "Operation");
        defaultMiddleware.add(
                new Middleware("Seahorse::Middleware::Parse", params)
        );

        params = new HashMap<>();
        params.put("signer", "@signer");
        defaultMiddleware.add(
                new Middleware("Seahorse::Middleware::Sign", params)
        );

        params = new HashMap<>();
        params.put("client", "Seahorse::HTTP::Xfer.new");
        defaultMiddleware.add(
                new Middleware("Seahorse::Middleware::Send", params)
        );

        return defaultMiddleware;
    }

    public void render(RubyCodeWriter writer) {
        for (Middleware middleware : middlewares) {
            middleware.render(writer);
        }
    }
}
