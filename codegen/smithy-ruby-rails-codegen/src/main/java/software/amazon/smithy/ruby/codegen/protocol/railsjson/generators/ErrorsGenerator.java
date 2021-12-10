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

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.generators.ErrorsGeneratorBase;
import software.amazon.smithy.ruby.codegen.traits.RailsJsonTrait;

public class ErrorsGenerator extends ErrorsGeneratorBase {

    public ErrorsGenerator(GenerationContext context) {
        super(context);
    }

    public void renderErrorCode() {
        RailsJsonTrait railsJsonTrait = context.getService().getTrait(RailsJsonTrait.class).get();
        String errorLocation = railsJsonTrait.getErrorLocation().orElse("status_code");

        writer.openBlock("def self.error_code(http_resp)");

        if (errorLocation.equals("header")) {
            renderErrorCodeFromHeader();
        } else if (errorLocation.equals("status_code")) {
            renderErrorCodeFromStatusCode();
        }

        writer.closeBlock("end");
    }

    private void renderErrorCodeFromHeader() {
        writer.write("http_resp.headers['x-smithy-rails-error']");
    }

    // See https://github.com/rails/rails/blob/2dfd4fcd73ae7c4b40114f2447c7ef9d4c0790b4/guides/source/layouts_and_rendering.md?plain=1#L363-L408
    private void renderErrorCodeFromStatusCode() {
        writer
                .write("case http_resp.status")
                // 3xx errors
                .write("when 300 then 'MultipleChoicesError'")
                .write("when 301 then 'MovedPermanentlyError'")
                .write("when 302 then 'FoundError'")
                .write("when 303 then 'SeeOtherError'")
                .write("when 304 then 'NotModifiedError'")
                .write("when 305 then 'UseProxyError'")
                .write("when 307 then 'TemporaryRedirectError'")
                .write("when 308 then 'PermanentRedirectError'")
                // 4xx errors
                .write("when 400 then 'BadRequestError'")
                .write("when 401 then 'UnauthorizedError'")
                .write("when 402 then 'PaymentRequiredError'")
                .write("when 403 then 'ForbiddenError'")
                .write("when 404 then 'NotFoundError'")
                .write("when 405 then 'MethodNotAllowedError'")
                .write("when 406 then 'NotAcceptableError'")
                .write("when 407 then 'ProxyAuthenticationRequiredError'")
                .write("when 408 then 'RequestTimeoutError'")
                .write("when 409 then 'ConflictError'")
                .write("when 410 then 'GoneError'")
                .write("when 411 then 'LengthRequiredError'")
                .write("when 412 then 'PreconditionFailedError'")
                .write("when 413 then 'PayloadTooLargeError'")
                .write("when 414 then 'UriTooLongError'")
                .write("when 415 then 'UnsupportedMediaTypeError'")
                .write("when 416 then 'RangeNotSatisfiableError'")
                .write("when 417 then 'ExpectationFailedError'")
                .write("when 421 then 'MisdirectedRequestError'")
                .write("when 422 then 'UnprocessableEntityError'")
                .write("when 423 then 'LockedError'")
                .write("when 424 then 'FailedDependencyError'")
                .write("when 426 then 'UpgradeRequiredError'")
                .write("when 428 then 'PreconditionRequiredError'")
                .write("when 429 then 'TooManyRequestsError'")
                .write("when 431 then 'RequestHeaderFieldsTooLargeError'")
                .write("when 451 then 'UnavailableForLegalReasonsError'")
                // 5xx errors
                .write("when 500 then 'InternalServerErrorError'")
                .write("when 501 then 'NotImplementedError'")
                .write("when 502 then 'BadGatewayError'")
                .write("when 503 then 'ServiceUnavailableError'")
                .write("when 504 then 'GatewayTimeoutError'")
                .write("when 505 then 'HttpVersionNotSupportedError'")
                .write("when 506 then 'VariantAlsoNegotiatesError'")
                .write("when 507 then 'InsufficientStorageError'")
                .write("when 508 then 'LoopDetectedError'")
                .write("when 510 then 'NotExtendedError'")
                .write("when 511 then 'NetworkAuthenticationRequiredError'")
                // end
                .write("end");
    }
}
