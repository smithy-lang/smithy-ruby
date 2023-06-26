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

import java.util.Optional;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.knowledge.PaginatedIndex;
import software.amazon.smithy.model.knowledge.PaginationInfo;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class PaginatorsGenerator extends RubyGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(PaginatorsGenerator.class.getName());

    public PaginatorsGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
    }

    @Override
    String getModule() {
        return "Paginators";
    }

    public void render() {
        write(writer -> {
            writer
                .includePreamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Paginators")
                .call(() -> renderPaginators(writer))
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        });
        LOGGER.fine("Wrote paginators to " + rbFile());
    }

    public void renderRbs() {
        writeRbs(writer -> {
            writer
                .includePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Paginators")
                .call(() -> renderRbsPaginators(writer))
                .write("")
                .closeBlock("end")
                .closeBlock("end");
        });
        LOGGER.fine("Wrote paginators types to " + rbsFile());
    }

    private void renderPaginators(RubyCodeWriter writer) {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        PaginatedIndex paginatedIndex = PaginatedIndex.of(model);

        topDownIndex.getContainedOperations(context.service()).stream().forEach((operation) -> {
            Optional<PaginationInfo> paginationInfoOptional =
                    paginatedIndex.getPaginationInfo(context.service(), operation);
            if (paginationInfoOptional.isPresent()) {
                PaginationInfo paginationInfo = paginationInfoOptional.get();
                String operationName = symbolProvider.toSymbol(operation).getName();
                renderPaginator(writer, operationName, paginationInfo);
            }
        });
    }

    private void renderRbsPaginators(RubyCodeWriter writer) {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        PaginatedIndex paginatedIndex = PaginatedIndex.of(model);

        topDownIndex.getContainedOperations(context.service()).stream().forEach((operation) -> {
            Optional<PaginationInfo> paginationInfoOptional =
                    paginatedIndex.getPaginationInfo(context.service(), operation);
            if (paginationInfoOptional.isPresent()) {
                PaginationInfo paginationInfo = paginationInfoOptional.get();
                String operationName = symbolProvider.toSymbol(operation).getName();
                renderRbsPaginator(writer, operationName, paginationInfo);
            }
        });
    }

    private void renderPaginator(RubyCodeWriter writer, String operationName, PaginationInfo paginationInfo) {
        writer
                .write("")
                .openBlock("class $L", operationName)
                .call(() -> renderPaginatorInitializeDocumentation(writer, operationName))
                .openBlock("def initialize(client, params = {}, options = {})")
                .write("@params = params")
                .write("@options = options")
                .write("@client = client")
                .closeBlock("end")
                .call(() -> renderPaginatorPages(writer, operationName, paginationInfo))
                .call(() -> {
                    if (!paginationInfo.getItemsMemberPath().isEmpty()) {
                        renderPaginatorItems(writer, paginationInfo, operationName);
                    }
                })
                .closeBlock("end");
        LOGGER.finer("Generated paginator for " + operationName);
    }

    private void renderRbsPaginator(RubyCodeWriter writer, String operationName, PaginationInfo paginationInfo) {
        writer
                .write("")
                .openBlock("class $L", operationName)
                .write("def initialize: (untyped client, ?::Hash[untyped, untyped] params, "
                        + "?::Hash[untyped, untyped] options) -> void\n")
                .write("def pages: () -> untyped")
                .call(() -> {
                    if (!paginationInfo.getItemsMemberPath().isEmpty()) {
                        writer.write("def items: () -> untyped");
                    }
                })
                .closeBlock("end");
    }

    private void renderPaginatorInitializeDocumentation(RubyCodeWriter writer, String operationName) {
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);

        writer.writeDocs((w) -> w
                .write("@param [Client] client")
                .write("@param [Hash] params (see Client#$L)", snakeOperationName)
                .write("@param [Hash] options (see Client#$L)", snakeOperationName));
    }

    private void renderPaginatorPages(RubyCodeWriter writer, String operationName, PaginationInfo paginationInfo) {
        String inputToken = symbolProvider.toMemberName(paginationInfo.getInputTokenMember());
        String outputToken = paginationInfo.getOutputTokenMemberPath().stream()
                .map((member) -> symbolProvider.toMemberName(member))
                .collect(Collectors.joining("&."));
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);

        writer
                .call(() -> renderPaginatorPagesDocumentation(writer, snakeOperationName))
                .openBlock("def pages")
                .write("params = @params")
                .openBlock("Enumerator.new do |e|")
                .write("@prev_token = params[:$L]", inputToken)
                .write("response = @client.$L(params, @options)", snakeOperationName)
                .write("e.yield(response)")
                .write("output_token = response.$L", outputToken)
                .write("")
                .openBlock("until output_token.nil? || @prev_token == output_token")
                .write("params = params.merge($L: output_token)", inputToken)
                .write("response = @client.$L(params, @options)", snakeOperationName)
                .write("e.yield(response)")
                .write("output_token = response.$L", outputToken)
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderPaginatorPagesDocumentation(RubyCodeWriter writer, String snakeOperationName) {
        writer.writeDocs((w) -> w
                .write("Iterate all response pages of the $L operation.", snakeOperationName)
                .write("@return [Enumerator]"));
    }

    private void renderPaginatorItems(RubyCodeWriter writer, PaginationInfo paginationInfo, String operationName) {
        String items = paginationInfo.getItemsMemberPath().stream()
                .map((member) -> symbolProvider.toMemberName(member))
                .collect(Collectors.joining("&."));

        writer
                .write("")
                .call(() -> renderPaginatorItemsDocumentation(writer, operationName))
                .openBlock("def items")
                .openBlock("Enumerator.new do |e|")
                .openBlock("pages.each do |page|")
                .openBlock("page.$L.each do |item|", items)
                .write("e.yield(item)")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderPaginatorItemsDocumentation(RubyCodeWriter writer, String operationName) {
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);
        writer.writeDocs((w) -> w
                .write("Iterate all items from pages in the $L operation.", snakeOperationName)
                .write("@return [Enumerator]"));
    }
}
