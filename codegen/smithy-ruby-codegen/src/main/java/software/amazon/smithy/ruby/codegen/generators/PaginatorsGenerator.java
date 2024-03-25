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

import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.knowledge.PaginatedIndex;
import software.amazon.smithy.model.knowledge.PaginationInfo;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.Shape;
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
                .preamble()
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
                .preamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Paginators")
                .call(() -> renderRbsPaginators(writer))
                .write("")
                .closeBlock("end")
                .closeBlock("end");
        });
        LOGGER.fine("Wrote paginators rbs to " + rbsFile());
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
                .write("@client = client")
                .write("@params = params")
                .write("@options = options")
                .closeBlock("end")
                .write("")
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
        String outputType = symbolProvider.toSymbol(paginationInfo.getOutput()).getName();
        writer
                .write("")
                .openBlock("class $L", operationName)
                .write("def initialize: (Client, ?::Hash[::Symbol, untyped] params, "
                        + "?::Hash[::Symbol, untyped] options) -> void\n")
                .write("def pages: () -> ::Enumerator[Hearth::Output[Types::$L], void]", outputType)
                .call(() -> {
                    List<MemberShape> itemMembers = paginationInfo.getItemsMemberPath();
                    if (!itemMembers.isEmpty()) {
                        MemberShape last = itemMembers.get(itemMembers.size() - 1);
                        Shape shape = model.expectShape(last.getTarget());
                        String type = "untyped";
                        if (shape.isMapShape()) {
                            String subType = symbolProvider.toSymbol(
                                    model.expectShape(((MapShape) shape).getValue().getTarget())).toString();
                            type = "Hash[::Symbol, " + subType + "]";
                        } else if (shape.isListShape()) {
                            MemberShape member = shape.members().stream().findFirst().get();
                            String subType = symbolProvider.toSymbol(model.expectShape(member.getTarget())).toString();
                            type = "Array[" + subType + "]";
                        }
                        writer.write("def items: () -> Enumerator[$L, void]", type);
                    }
                })
                .closeBlock("end");
    }

    private void renderPaginatorInitializeDocumentation(RubyCodeWriter writer, String operationName) {
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);

        writer
                .writeYardParam("Client", "client", "")
                .writeYardReference("param", "Client#" + snakeOperationName);
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
                .write("output = @client.$L(params, @options)", snakeOperationName)
                .write("e.yield(output)")
                .write("output_token = output.data.$L", outputToken)
                .write("")
                .openBlock("until output_token.nil? || @prev_token == output_token")
                .write("params = params.merge($L: output_token)", inputToken)
                .write("output = @client.$L(params, @options)", snakeOperationName)
                .write("e.yield(output)")
                .write("output_token = output.data.$L", outputToken)
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderPaginatorPagesDocumentation(RubyCodeWriter writer, String snakeOperationName) {
        writer
                .writeDocstring("Iterate all response pages of the " + snakeOperationName + " operation.")
                .writeYardReturn("Enumerator", "");
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
                .openBlock("page.data.$L.each do |item|", items)
                .write("e.yield(item)")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderPaginatorItemsDocumentation(RubyCodeWriter writer, String operationName) {
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);
        writer
                .writeDocstring("Iterate all items from pages in the " + snakeOperationName + " operation.")
                .writeYardReturn("Enumerator", "");
    }
}
