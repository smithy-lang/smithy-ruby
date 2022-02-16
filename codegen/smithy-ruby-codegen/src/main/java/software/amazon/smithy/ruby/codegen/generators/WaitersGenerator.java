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

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.jmespath.ExpressionSerializer;
import software.amazon.smithy.jmespath.ExpressionVisitor;
import software.amazon.smithy.jmespath.JmespathExpression;
import software.amazon.smithy.jmespath.ast.AndExpression;
import software.amazon.smithy.jmespath.ast.ComparatorExpression;
import software.amazon.smithy.jmespath.ast.CurrentExpression;
import software.amazon.smithy.jmespath.ast.ExpressionTypeExpression;
import software.amazon.smithy.jmespath.ast.FieldExpression;
import software.amazon.smithy.jmespath.ast.FilterProjectionExpression;
import software.amazon.smithy.jmespath.ast.FlattenExpression;
import software.amazon.smithy.jmespath.ast.FunctionExpression;
import software.amazon.smithy.jmespath.ast.IndexExpression;
import software.amazon.smithy.jmespath.ast.LiteralExpression;
import software.amazon.smithy.jmespath.ast.MultiSelectHashExpression;
import software.amazon.smithy.jmespath.ast.MultiSelectListExpression;
import software.amazon.smithy.jmespath.ast.NotExpression;
import software.amazon.smithy.jmespath.ast.ObjectProjectionExpression;
import software.amazon.smithy.jmespath.ast.OrExpression;
import software.amazon.smithy.jmespath.ast.ProjectionExpression;
import software.amazon.smithy.jmespath.ast.SliceExpression;
import software.amazon.smithy.jmespath.ast.Subexpression;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.RubySymbolProvider;
import software.amazon.smithy.utils.SmithyInternalApi;
import software.amazon.smithy.waiters.Acceptor;
import software.amazon.smithy.waiters.AcceptorState;
import software.amazon.smithy.waiters.Matcher;
import software.amazon.smithy.waiters.WaitableTrait;
import software.amazon.smithy.waiters.Waiter;

@SmithyInternalApi
public class WaitersGenerator {

    private static final Logger LOGGER =
            Logger.getLogger(WaitersGenerator.class.getName());

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final RubyCodeWriter writer;
    private final RubyCodeWriter rbsWriter;
    private final RubySymbolProvider symbolProvider;

    public WaitersGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.writer = new RubyCodeWriter();
        this.rbsWriter = new RubyCodeWriter();
        this.symbolProvider = new RubySymbolProvider(context.getModel(), settings, "Waiters", false);
    }

    public void render() {
        FileManifest fileManifest = context.getFileManifest();

        writer
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderWaiters(false))
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/waiters.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote waiters to " + fileName);
    }

    public void renderRbs() {
        FileManifest fileManifest = context.getFileManifest();

        rbsWriter
                .writePreamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderWaiters(true))
                .write("")
                .closeBlock("end")
                .closeBlock("end");

        String typesFile =
                settings.getGemName() + "/sig/" + settings.getGemName()
                        + "/waiters.rbs";
        fileManifest.writeFile(typesFile, rbsWriter.toString());
        LOGGER.fine("Wrote waiters rbs to " + typesFile);
    }

    private void renderWaiters(Boolean rbs) {
        TopDownIndex topDownIndex = TopDownIndex.of(model);

        topDownIndex.getContainedOperations(context.getService()).stream().forEach((operation) -> {
            if (operation.hasTrait(WaitableTrait.class)) {
                Map<String, Waiter> waiters = operation.getTrait(WaitableTrait.class).get().getWaiters();
                Iterator<Map.Entry<String, Waiter>> iterator = waiters.entrySet().iterator();

                while (iterator.hasNext()) {
                    Map.Entry<String, Waiter> entry = iterator.next();
                    String waiterName = entry.getKey();
                    Waiter waiter = entry.getValue();
                    if (rbs) {
                        renderRbsWaiter(waiterName);
                    } else {
                        renderWaiter(waiterName, waiter, operation);
                    }
                    if (iterator.hasNext()) {
                        writer.write("");
                    }
                }
            }
        });
    }

    private void renderWaiter(String waiterName, Waiter waiter, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        writer
                .write("")
                .call(() -> renderWaiterDocumentation(waiter))
                .openBlock("class $L", waiterName)
                .call(() -> renderWaiterInitializeDocumentation(waiter))
                .openBlock("def initialize(client, options = {})")
                .write("@client = client")
                .openBlock("@waiter = Hearth::Waiters::Waiter.new({")
                .write("max_wait_time: options[:max_wait_time],")
                .write("min_delay: $L || options[:min_delay],", waiter.getMinDelay())
                .write("max_delay: $L || options[:max_delay],", waiter.getMaxDelay())
                .openBlock("poller: Hearth::Waiters::Poller.new(")
                .write("operation_name: :$L,", operationName)
                .call(() -> renderAcceptors(waiter))
                .closeBlock(")")
                .closeBlock("}.merge(options))")
                .call(() -> renderWaiterTags(waiter))
                .closeBlock("end")
                .write("")
                .write("attr_reader :tags")
                .write("")
                .call(() -> renderWaiterWaitDocumentation(operation, operationName))
                .openBlock("def wait(params = {}, options = {})")
                .write("@waiter.wait(@client, params, options)")
                .closeBlock("end")
                .closeBlock("end");

        LOGGER.finer("Generated waiter " + waiterName + " for operation: " + operationName);
    }

    private void renderRbsWaiter(String waiterName) {
        rbsWriter
                .write("")
                .openBlock("class $L", waiterName)
                .write("def initialize: (untyped client, ?::Hash[untyped, untyped] options) -> void\n")
                .write("attr_reader tags: untyped\n")
                .write("def wait: (?::Hash[untyped, untyped] params, ?::Hash[untyped, untyped] options) -> untyped")
                .closeBlock("end");
    }

    private void renderWaiterDocumentation(Waiter waiter) {
        if (waiter.getDocumentation().isPresent()) {
            writer.writeDocstring(waiter.getDocumentation().get());
        }
        if (waiter.isDeprecated()) {
            writer.writeYardDeprecated("This waiter is deprecated.", "");
        }
    }

    private void renderWaiterTags(Waiter waiter) {
        String tags = waiter.getTags().stream()
                .map((tag) -> "\"" + tag + "\"")
                .collect(Collectors.joining(", "));
        writer.write("@tags = [$L]", tags);
    }

    private void renderAcceptors(Waiter waiter) {
        List<Acceptor> acceptorsList = waiter.getAcceptors();

        if (acceptorsList.isEmpty()) {
            writer.write("acceptors: []");
        } else {
            writer.openBlock("acceptors: [");
            Iterator<Acceptor> iterator = acceptorsList.iterator();

            while (iterator.hasNext()) {
                Acceptor acceptor = iterator.next();
                Matcher<?> matcher = acceptor.getMatcher();
                AcceptorState state = acceptor.getState();
                writer
                        .openBlock("{")
                        .write("state: '$L',", state)
                        .openBlock("matcher: {")
                        .call(() -> {
                            matcher.accept(new AcceptorVisitor());
                        })
                        .closeBlock("}");

                if (iterator.hasNext()) {
                    writer.closeBlock("},");
                } else {
                    writer.closeBlock("}");
                }
            }
            writer.closeBlock("]");
        }
    }

    private String translatePath(String path) {
        JmespathExpression transformedExpression = JmespathExpression.parse(path).accept(new JmespathTranslator());
        String transformedPath = (new ExpressionSerializer()).serialize(transformedExpression);
        return transformedPath;
    }

    private void renderWaiterWaitDocumentation(OperationShape operation, String operationName) {
        String operationReturnType = "Types::" + symbolProvider.toSymbol(operation).getName();

        String operationReference = "(see Client#" + operationName + ")";
        writer
                .writeYardParam("Hash", "params", operationReference)
                .writeYardParam("Hash", "options", operationReference)
                .writeYardReturn(operationReturnType, operationReference);
    }

    private void renderWaiterInitializeDocumentation(Waiter waiter) {
        writer
                .writeYardParam("Client", "client", "")
                .writeYardParam("Hash", "options", "")
                .writeYardOption(
                        "options",
                        "required, Integer",
                        ":max_wait_time",
                        "",
                        "The maximum time in seconds to wait before the waiter gives up.")
                .writeYardOption(
                        "options",
                        "Integer",
                        ":min_delay",
                        "" + waiter.getMinDelay(),
                        "The minimum time in seconds to delay polling attempts.")
                .writeYardOption(
                        "options",
                        "Integer",
                        ":max_delay",
                        "" + waiter.getMaxDelay(),
                        "The maximum time in seconds to delay polling attempts.");
    }

    private class AcceptorVisitor implements Matcher.Visitor<Void> {

        private void renderPathMatcher(String memberName, String path, String comparator, String expected) {
            writer
                    .openBlock("$L: {", memberName)
                    .write("path: $S,", translatePath(path))
                    .write("comparator: \"$L\",", comparator)
                    .write("expected: '$L'", expected)
                    .closeBlock("}");
        }

        @Override
        public Void visitOutput(Matcher.OutputMember outputPath) {
            renderPathMatcher(
                    outputPath.getMemberName(),
                    outputPath.getValue().getPath(),
                    outputPath.getValue().getComparator().toString(),
                    outputPath.getValue().getExpected());
            return null;
        }

        @Override
        public Void visitInputOutput(Matcher.InputOutputMember inputOutputPath) {
            renderPathMatcher(
                    inputOutputPath.getMemberName(),
                    inputOutputPath.getValue().getPath(),
                    inputOutputPath.getValue().getComparator().toString(),
                    inputOutputPath.getValue().getExpected());
            return null;
        }

        @Override
        public Void visitSuccess(Matcher.SuccessMember success) {
            writer.write("$L: $L", success.getMemberName(), success.getValue() ? "true" : "false");
            return null;
        }

        @Override
        public Void visitErrorType(Matcher.ErrorTypeMember errorType) {
            writer.write("$L: '$L'", errorType.getMemberName(), errorType.getValue());
            return null;
        }

        @Override
        public Void visitUnknown(Matcher.UnknownMember unknown) {
            return null;
        }
    }

    private class JmespathTranslator implements ExpressionVisitor<JmespathExpression> {

        @Override
        public JmespathExpression visitComparator(ComparatorExpression expression) {
            return new ComparatorExpression(
                    expression.getComparator(),
                    expression.getLeft().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitCurrentNode(CurrentExpression expression) {
            return new CurrentExpression(expression.getLine(), expression.getColumn());
        }

        @Override
        public JmespathExpression visitExpressionType(ExpressionTypeExpression expression) {
            return new ExpressionTypeExpression(
                    expression.getExpression().accept(this),
                    expression.getLine(),
                    expression.getColumn());
        }

        @Override
        public JmespathExpression visitFlatten(FlattenExpression expression) {
            return new FlattenExpression(
                    expression.getExpression().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitFunction(FunctionExpression expression) {

            return new FunctionExpression(
                    expression.getName(),
                    expression.getArguments().stream()
                            .map((e) -> e.accept(this)).collect(Collectors.toList()),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitField(FieldExpression expression) {
            return new FieldExpression(
                    symbolProvider.toMemberName(expression.getName()),
                    expression.getLine(), expression.getColumn());
        }

        @Override
        public JmespathExpression visitIndex(IndexExpression expression) {
            return new IndexExpression(
                    expression.getIndex(),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitLiteral(LiteralExpression expression) {
            return new LiteralExpression(
                    expression.getValue(),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitMultiSelectList(MultiSelectListExpression expression) {
            return new MultiSelectListExpression(
                    expression.getExpressions().stream()
                            .map((e) -> e.accept(this)).collect(Collectors.toList()),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitMultiSelectHash(MultiSelectHashExpression expression) {
            Map<String, JmespathExpression> newExpression = new HashMap<>();
            for (Map.Entry<String, JmespathExpression> entry : expression.getExpressions().entrySet()) {
                newExpression.put(entry.getKey(), entry.getValue().accept(this));
            }

            return new MultiSelectHashExpression(
                    newExpression,
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitAnd(AndExpression expression) {
            return new AndExpression(
                    expression.getLeft().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitOr(OrExpression expression) {
            return new OrExpression(
                    expression.getLeft().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitNot(NotExpression expression) {
            return new NotExpression(
                    expression.getExpression().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitProjection(ProjectionExpression expression) {
            return new ProjectionExpression(
                    expression.getLeft().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitFilterProjection(FilterProjectionExpression expression) {
            return new FilterProjectionExpression(
                    expression.getLeft().accept(this),
                    expression.getComparison().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitObjectProjection(ObjectProjectionExpression expression) {
            return new ObjectProjectionExpression(
                    expression.getLeft().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitSlice(SliceExpression expression) {
            return new SliceExpression(
                    expression.getStart().isPresent() ? expression.getStart().getAsInt() : null,
                    expression.getStop().isPresent() ? expression.getStop().getAsInt() : null,
                    expression.getStep(),
                    expression.getLine(),
                    expression.getColumn()
            );
        }

        @Override
        public JmespathExpression visitSubexpression(Subexpression expression) {
            return new Subexpression(
                    expression.getLeft().accept(this),
                    expression.getRight().accept(this),
                    expression.getLine(),
                    expression.getColumn(),
                    expression.isPipe()
            );
        }
    }
}
