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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.model.traits.RetryableTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * ErrorGeneratorBase that protocol generators can extend to get
 * common functionality.
 * <p>
 * Generates the framework and non-protocol specific parts of the
 * errors.rb.
 */
@SmithyUnstableApi
public abstract class ErrorsGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(ErrorsGeneratorBase.class.getName());

    /**
     * generation context.
     */
    protected final GenerationContext context;
    /**
     * Ruby settings.
     */
    protected final RubySettings settings;
    /**
     * Model to generate for.
     */
    protected final Model model;

    /**
     * CodeWriter to write with.
     */
    protected final RubyCodeWriter writer;
    /**
     * CodeWriter to write RBS with.
     */
    protected final RubyCodeWriter rbsWriter;
    /**
     * SymbolProvider scoped to the errors module.
     */
    protected final SymbolProvider symbolProvider;

    /**
     * List of all errorShapes.
     */
    protected final List<StructureShape> errorShapes;

    /**
     * @param context generation context
     */
    public ErrorsGeneratorBase(GenerationContext context) {
        this.context = context;
        this.settings = context.settings();
        this.model = context.model();
        this.writer = new RubyCodeWriter(context.settings().getModule() + "::Errors");
        this.rbsWriter = new RubyCodeWriter(context.settings().getModule() + "::Errors");
        this.symbolProvider = context.symbolProvider();
        this.errorShapes = getErrorShapes();
    }

    /**
     * @return list of all applicable (connected) error shapes from operations and from event streams.
     */
    protected List<StructureShape> getErrorShapes() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        Stream<StructureShape> operationErrors = topDownIndex.getContainedOperations(context.service()).stream()
                .map(OperationShape::getErrors)
                .flatMap(Collection::stream)
                .map(s -> model.expectShape(s, StructureShape.class));

        Stream<StructureShape> eventErrors = topDownIndex.getContainedOperations(context.service()).stream()
                .map(o -> Streaming.getEventStreamMember(model, model.expectShape(o.getOutputShape())))
                .filter(Optional::isPresent)
                .map(Optional::get)
                .map(m -> model.expectShape(m.getTarget()))
                .map(eventUnion -> Streaming.getEventStreamErrors(model, eventUnion).values())
                .flatMap(Collection::stream);

        return Stream.concat(operationErrors, eventErrors)
                .collect(Collectors.toSet()).stream() // for uniqueness
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .toList();
    }


    /**
     * @param fileManifest fileManifest to use for writing.
     */
    public void render(FileManifest fileManifest) {
        writer
                .preamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .openBlock("def self.error_code(resp)")
                .call(() -> renderErrorCodeBody())
                .closeBlock("end")
                .call(() -> renderBaseErrors())
                .call(() -> renderModeledErrors())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/errors.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote errors to " + fileName);
    }

    /**
     * @param fileManifest fileManifest to use for writing.
     */
    public void renderRbs(FileManifest fileManifest) {
        rbsWriter
                .preamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Errors")
                .write("")
                .call(() -> renderRbsErrorCode())
                .call(() -> renderRbsBaseErrors())
                .call(() -> renderRbsModeledErrors())
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/sig/" + settings.getGemName() + "/errors.rbs";
        fileManifest.writeFile(fileName, rbsWriter.toString());
        LOGGER.fine("Wrote errors rbs to " + fileName);
    }

    private void renderBaseErrors() {
        writer
                .write("\n# Base class for all errors returned by this service")
                .write("class ApiError < $T; end", Hearth.API_ERROR)
                .write("\n# Base class for all errors returned where the client is at fault.")
                .write("class ApiClientError < ApiError; end")
                .write("\n# Base class for all errors returned where the server is at fault.")
                .write("class ApiServerError < ApiError; end")
                .write("\n# Base class for all errors returned where the service returned")
                .write("# a redirection.")
                .openBlock("class ApiRedirectError < ApiError")
                .openBlock("def initialize(location:, **kwargs)")
                .write("@location = location")
                .write("super(**kwargs)")
                .closeBlock("end")
                .write("")
                .write("# @return [String] location")
                .write("attr_reader :location")
                .closeBlock("end");
    }

    private void renderRbsBaseErrors() {
        rbsWriter
                .write("\nclass ApiError < $T", Hearth.API_ERROR)
                .write("end")
                .write("\nclass ApiClientError < ApiError")
                .write("end")
                .write("\nclass ApiServerError < ApiError")
                .write("end")
                .openBlock("\nclass ApiRedirectError < ApiError")
                .write("def initialize: (location: String, **untyped kwargs) -> void\n")
                .write("attr_reader location: String")
                .closeBlock("end");
    }

    /**
     * Called to render the error_code method body.
     * <p>
     * errors.rb defines a self.error_code(resp) method that should
     * return the protocol specific error code (as a string) from the
     * response, or nil if no error code is found. The error code is
     * used to find and raise a generated error with the same name.
     * <p>
     * For example, an error code of 'FooError' will attempt to raise
     * the Service::Errors::FooError error.
     */
    public abstract void renderErrorCodeBody();

    /**
     * Render RBS signature for error code.
     */
    public void renderRbsErrorCode() {
        rbsWriter.write("def self.error_code: (Hearth::Response) -> ::String?");
    }

    private void renderModeledErrors() {
        for (StructureShape errorShape : errorShapes) {
            renderModeledError(errorShape);
        }
    }

    private void renderModeledError(StructureShape errorShape) {
        String errorName = symbolProvider.toSymbol(errorShape).getName();
        String apiErrorType = getApiErrorType(errorShape.expectTrait(ErrorTrait.class));
        boolean retryable = errorShape.hasTrait(RetryableTrait.class);
        boolean throttling = retryable && errorShape.expectTrait(RetryableTrait.class).getThrottling();

        writer
                .write("")
                .openBlock("class $L < $L", symbolProvider.toSymbol(errorShape).getName(), apiErrorType)
                .openBlock("def initialize(data:, **kwargs)")
                .write("@data = data")
                .write("kwargs[:message] = @data.message if @data.respond_to?(:message)\n")
                .write("super(**kwargs)")
                .closeBlock("end")
                .write("")

                .writeYardReturn("Types::" + errorName, "")
                .write("attr_reader :data")
                .call(() -> {
                    if (retryable) {
                        writer
                                .write("")
                                .openBlock("def retryable?")
                                .write("true")
                                .closeBlock("end");
                    }
                })
                .call(() -> {
                    if (throttling) {
                        writer
                                .write("")
                                .openBlock("def throttling?")
                                .write("true")
                                .closeBlock("end");
                    }
                })
                .closeBlock("end");
    }

    private void renderRbsModeledErrors() {
        for (StructureShape errorShape : errorShapes) {
            renderRbsModeledError(errorShape);
        }
    }

    private void renderRbsModeledError(StructureShape errorShape) {
        String apiErrorType = getApiErrorType(errorShape.expectTrait(ErrorTrait.class));
        String shapeName = symbolProvider.toSymbol(errorShape).getName();
        boolean retryable = errorShape.hasTrait(RetryableTrait.class);
        boolean throttling = retryable && errorShape.expectTrait(RetryableTrait.class).getThrottling();

        rbsWriter
                .write("")
                .openBlock("class $L < $L", shapeName, apiErrorType)
                .write("def initialize: (data: Types::$L, **untyped kwargs) -> void\n", shapeName)
                .write("attr_reader data: Types::$L", shapeName)
                .call(() -> {
                    if (retryable) {
                        rbsWriter.write("def retryable?: () -> true");
                    }
                })
                .call(() -> {
                    if (throttling) {
                        rbsWriter.write("def throttling?: () -> true");
                    }
                })
                .closeBlock("end");
    }

    private String getApiErrorType(ErrorTrait errorTrait) {
        String apiErrorType;

        if (errorTrait.isClientError()) {
            apiErrorType = "ApiClientError";
        } else if (errorTrait.isServerError()) {
            apiErrorType = "ApiServerError";
        } else {
            // This should not happen but it's a safe fallback
            apiErrorType = "ApiError";
        }

        return apiErrorType;
    }
}

