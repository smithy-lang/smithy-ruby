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

import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Interface that all ProtocolGenerators must implement.
 *
 * Each generate method will be called by the CodegenOrchestrator
 * and should generate and write out the appropriate file.
 */
@SmithyUnstableApi
public interface ProtocolGenerator {

    /**
     * @return The ShapeId of the protocol that this generator applies to.
     * This is used to match loaded ProtocolGenerators to the
     * services protocols.
     */
    ShapeId getProtocol();

    /**
     * @return The ApplicationTransport that should be used for this protocol.
     */
    ApplicationTransport getApplicationTransport();

    /**
     * Called to generate builders (data serializers).
     * Builders must be written to builders.rb and
     * each operation must have a class that implements the
     * `build(req, input:)` method.
     * @param context context to use for generation
     */
    void generateBuilders(GenerationContext context);

    /**
     * Called to generate parsers (data deserializers).
     * Parsers must be written to parsers.rb and
     * each operation must have a class that implements the
     * `parse(resp)` method.
     * @param context context to use for generation
     */
    void generateParsers(GenerationContext context);

    /**
     * Called to generate errors.
     * Errors must be written to errors.rb and
     * should define a class for each modeled error
     * as well as classes for ApiError, ApiServiceError,
     * and ApiClientError.
     * @param context context to use for generation
     */
    void generateErrors(GenerationContext context);

    /**
     * Called to generate stubs.
     * Stubs must be written to stubs.rb and
     * should define a class for each operation
     * that implements the `default` and `stub(resp, stub:)` method.
     * @param context context to use for generation
     */
    void generateStubs(GenerationContext context);
}
