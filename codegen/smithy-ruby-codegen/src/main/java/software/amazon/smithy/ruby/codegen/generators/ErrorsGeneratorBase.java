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

    protected final boolean outputEventStreams;

    protected final List<StructureShape> eventErrorShapes;

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
        this.eventErrorShapes = getEventErrorShapes();
        this.outputEventStreams = TopDownIndex.of(model).getContainedOperations(context.service()).stream()
                .anyMatch(o -> Streaming.isEventStreaming(model, model.expectShape(o.getOutputShape())));
    }

    /**
     * @return list of all applicable (connected) error shapes.
     */
    protected List<StructureShape> getErrorShapes() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        return topDownIndex.getContainedOperations(context.service()).stream()
                .map(OperationShape::getErrors)
                .flatMap(Collection::stream)
                .map(shapeId -> model.expectShape(shapeId, StructureShape.class))
                .collect(Collectors.toSet()).stream() // for uniqueness
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .toList();
    }

    /**
     * @return list of all error shapes from connected operations w/ output event streams.
     */
    protected List<StructureShape> getEventErrorShapes() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        return topDownIndex.getContainedOperations(context.service()).stream()
                .map(o -> Streaming.getEventStreamMember(model, model.expectShape(o.getOutputShape())))
                .filter(Optional::isPresent)
                .map(Optional::get)
                .map(m -> model.expectShape(m.getTarget()))
                .map(eventUnion -> Streaming.getEventStreamErrors(model, eventUnion).values())
                .flatMap(Collection::stream)
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
                .call(() -> {
                    if (outputEventStreams) {
                        renderEventErrors();
                    }
                })
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
                .call(() -> renderRbsServiceErrors())
                .call(() -> {
                    if (outputEventStreams) {
                        renderRbsEventErrors();
                    }
                })
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName =
                settings.getGemName() + "/sig/" + settings.getGemName() + "/errors.rbs";
        fileManifest.writeFile(fileName, rbsWriter.toString());
        LOGGER.fine("Wrote errors rbs to " + fileName);
    }

    // TODO: the error module is currently protocol (http) specific
    private void renderBaseErrors() {
        writer
                .write("\n# Base class for all errors returned by this service")
                .write("class ApiError < $T; end", Hearth.HTTP_API_ERROR)
                .write("\n# Base class for all errors returned where the client is at fault.")
                .write("# These are generally errors with 4XX HTTP status codes.")
                .write("class ApiClientError < ApiError; end")
                .write("\n# Base class for all errors returned where the server is at fault.")
                .write("# These are generally errors with 5XX HTTP status codes.")
                .write("class ApiServerError < ApiError; end")
                .write("\n# Base class for all errors returned where the service returned")
                .write("# a 3XX redirection.")
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
                .write("\nclass ApiError < $T", Hearth.HTTP_API_ERROR)
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
        rbsWriter.write("def self.error_code: (Hearth::HTTP::Response) -> ::String?");
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
                .openBlock("def initialize(http_resp:, **kwargs)")
                .write("@data = Parsers::$L.parse(http_resp)", symbolProvider.toSymbol(errorShape).getName())
                .write("kwargs[:message] = @data.message if @data.respond_to?(:message)\n")
                .write("super(http_resp: http_resp, **kwargs)")
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

    private void renderEventErrors() {
        // event errors may be also be used as operation errors so must be in their own namespace.
        writer
                .write("")
                .openBlock("module EventStream")
                .write("\n# Base class for all event errors returned by this service")
                .write("class Error < $T; end", Hearth.API_ERROR)
                .write("\n# Base class for event errors where the client is at fault.")
                .write("class ClientError < Error; end")
                .write("\n# Base class for event errors where the server is at fault.")
                .write("class ServerError < Error; end")
                .write("")
                .call(() -> {
                    for (StructureShape errorShape : eventErrorShapes) {
                        renderEventError(errorShape);
                    }
                })
                .closeBlock("end");
    }

    private void renderEventError(StructureShape errorShape) {
        String errorName = symbolProvider.toSymbol(errorShape).getName();
        String errorType = getEventErrorType(errorShape.expectTrait(ErrorTrait.class));

        writer
                .write("")
                .openBlock("class $L < $L", errorName, errorType)
                .openBlock("def initialize(event:, **kwargs)")
                .write("@data = event")
                .write("kwargs[:message] = @data.message if @data.respond_to?(:message)\n")
                .write("super(error_code: '$L', **kwargs)", errorName)
                .closeBlock("end")
                .write("")
                .writeYardReturn("Types::" + errorName, "")
                .write("attr_reader :data")
                .closeBlock("end");
    }

    private void renderRbsEventErrors() {
        rbsWriter
                .openBlock("module EventStream")
                .write("\nclass Error < $T", Hearth.API_ERROR)
                .write("end")
                .write("\nclass ClientError < Error")
                .write("end")
                .write("\nclass ServerError < Error")
                .write("end")
                .call(() -> {
                    for (StructureShape errorShape : eventErrorShapes) {
                        renderRbsEventError(errorShape);
                    }
                })
                .closeBlock("end");
    }

    private void renderRbsEventError(StructureShape errorShape) {
        String errorName = symbolProvider.toSymbol(errorShape).getName();
        String errorType = getEventErrorType(errorShape.expectTrait(ErrorTrait.class));

        rbsWriter
                .write("")
                .openBlock("class $L < $L", errorName, errorType)
                .openBlock("def initialize: (event: Types::$L, **untyped kwargs) -> void\n", errorName)
                .writeYardReturn("Types::" + errorName, "")
                .write("attr_reader data: Types::$L", errorName)
                .closeBlock("end");
    }

    private String getEventErrorType(ErrorTrait errorTrait) {
        if (errorTrait.isClientError()) {
            return "ClientError";
        } else {
            return "ServerError";
        }
    }

    private void renderRbsServiceErrors() {
        for (StructureShape errorShape : errorShapes) {
            renderRbsServerError(errorShape);
        }
    }

    private void renderRbsServerError(StructureShape errorShape) {
        String apiErrorType = getApiErrorType(errorShape.expectTrait(ErrorTrait.class));
        String shapeName = symbolProvider.toSymbol(errorShape).getName();
        boolean retryable = errorShape.hasTrait(RetryableTrait.class);
        boolean throttling = retryable && errorShape.expectTrait(RetryableTrait.class).getThrottling();

        rbsWriter
                .write("")
                .openBlock("class $L < $L", shapeName, apiErrorType)
                .write("def initialize: (http_resp: Hearth::HTTP::Response, **untyped kwargs) -> void\n")
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
            apiErrorType = "Hearth::HTTP::ApiError";
        }

        return apiErrorType;
    }
}

