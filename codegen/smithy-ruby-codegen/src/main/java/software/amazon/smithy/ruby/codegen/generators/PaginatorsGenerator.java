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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.Optional;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.PaginatedIndex;
import software.amazon.smithy.model.knowledge.PaginationInfo;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class PaginatorsGenerator {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;

    public PaginatorsGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Paginators")
                .call(() -> renderPaginators())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/paginators.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderPaginators() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        PaginatedIndex paginatedIndex = PaginatedIndex.of(model);

        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            Optional<PaginationInfo> paginationInfoOptional =
                    paginatedIndex.getPaginationInfo(context.getService(), operation);
            if (paginationInfoOptional.isPresent()) {
                PaginationInfo paginationInfo = paginationInfoOptional.get();
                String operationName = operation.getId().getName();
                renderPaginator(operationName, paginationInfo);
            }
        });
    }

    private void renderPaginator(String operationName, PaginationInfo paginationInfo) {
        writer
                .openBlock("class $L", operationName)
                .call(() -> renderPaginatorInitializeDocumentation(operationName))
                .openBlock("def initialize(client, params = {}, options = {})")
                .write("@params = params")
                .write("@options = options")
                .write("@client = client")
                .closeBlock("end")
                .write("")
                .call(() -> renderPaginatorPages(operationName, paginationInfo))
                .write("")
                .call(() -> {
                    if (!paginationInfo.getItemsMemberPath().isEmpty()) {
                        renderPaginatorItems(paginationInfo);
                    }
                })
                .closeBlock("end");
    }

    private void renderPaginatorInitializeDocumentation(String operationName) {
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);

        writer.rdoc(() -> writer
                .write("@param [Client] client")
                .write("@param [Hash] params (see Client#$L)", snakeOperationName)
                .write("@param [Hash] options (see Client#$L)", snakeOperationName));
    }

    private void renderPaginatorPages(String operationName, PaginationInfo paginationInfo) {
        String inputToken = RubyFormatter.toSnakeCase(paginationInfo.getInputTokenMember().getMemberName());
        String outputToken = paginationInfo.getOutputTokenMemberPath().stream()
                .map((member) -> RubyFormatter.toSnakeCase(member.getMemberName()))
                .collect(Collectors.joining("."));
        String snakeOperationName = RubyFormatter.toSnakeCase(operationName);

        writer
                .openBlock("def pages")
                .write("params = @params")
                .openBlock("Enumerator.new do |e|")
                .write("@prev_token = params[:$L]", inputToken)
                .write("response = @client.$L(params, @options)", snakeOperationName)
                .write("e.yield(response)")
                .write("output_token = response.$L", outputToken)
                .openBlock("until output_token.nil? || @prev_token == output_token")
                .write("params = params.merge($L: output_token)", inputToken)
                .write("response = @client.$L(params, @options)", snakeOperationName)
                .write("e.yield(response)")
                .write("output_token = response.$L", outputToken)
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderPaginatorItems(PaginationInfo paginationInfo) {
        String items = paginationInfo.getItemsMemberPath().stream()
                .map((member) -> RubyFormatter.toSnakeCase(member.getMemberName()))
                .collect(Collectors.joining("."));

        writer
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
}