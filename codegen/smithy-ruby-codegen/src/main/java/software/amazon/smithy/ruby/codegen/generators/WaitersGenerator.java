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

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.CustomizeDirective;
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
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
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
public class WaitersGenerator extends RubyGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(WaitersGenerator.class.getName());

    private final Set<OperationShape> operations;

    public WaitersGenerator(CustomizeDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.operations = directive.operations();
    }

    @Override
    String getModule() {
        return "Waiters";
    }

    public void render() {
        write(writer -> {
            writer
                .preamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderWaiters(writer, false))
                .write("")
                .closeBlock("end")
                .closeBlock("end");
        });
        LOGGER.fine("Wrote waiters to " + rbFile());
    }

    public void renderRbs() {
        writeRbs(writer -> {
            writer
                .preamble()
                .openBlock("module $L", settings.getModule())
                .openBlock("module Waiters")
                .call(() -> renderWaiters(writer, true))
                .write("")
                .closeBlock("end")
                .closeBlock("end");
            });
        LOGGER.fine("Wrote waiters rbs to " + rbsFile());
    }

    private void renderWaiters(RubyCodeWriter writer, Boolean rbs) {
        operations.forEach((operation) -> {
            if (operation.hasTrait(WaitableTrait.class)) {
                Map<String, Waiter> waiters = operation.getTrait(WaitableTrait.class).get().getWaiters();
                Iterator<Map.Entry<String, Waiter>> iterator = waiters.entrySet().iterator();

                while (iterator.hasNext()) {
                    Map.Entry<String, Waiter> entry = iterator.next();
                    String waiterName = entry.getKey();
                    Waiter waiter = entry.getValue();
                    if (rbs) {
                        renderRbsWaiter(writer, waiterName);
                    } else {
                        renderWaiter(writer, waiterName, waiter, operation);
                    }
                    if (iterator.hasNext()) {
                        writer.write("");
                    }
                }
            }
        });
    }

    private void renderWaiter(RubyCodeWriter writer, String waiterName, Waiter waiter, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        writer
                .write("")
                .call(() -> renderWaiterDocumentation(writer, waiter))
                .openBlock("class $L", waiterName)
                .call(() -> renderWaiterInitializeDocumentation(writer, waiter))
                .openBlock("def initialize(client, options = {})")
                .write("@client = client")
                .openBlock("@waiter = $T.new({", Hearth.WAITER)
                .write("max_wait_time: options[:max_wait_time],")
                .write("min_delay: options[:min_delay] || $L,", waiter.getMinDelay())
                .write("max_delay: options[:max_delay] || $L,", waiter.getMaxDelay())
                .openBlock("poller: $T.new(", Hearth.POLLER)
                .write("operation_name: :$L,", operationName)
                .call(() -> renderAcceptors(writer, waiter))
                .closeBlock(")")
                .closeBlock("}.merge(options))")
                .call(() -> renderWaiterTags(writer, waiter))
                .closeBlock("end")
                .write("")
                .writeYardReturn("Array<String>", "")
                .write("attr_reader :tags")
                .write("")
                .call(() -> renderWaiterWaitDocumentation(writer, operationName))
                .openBlock("def wait(params = {}, options = {})")
                .write("@waiter.wait(@client, params, options)")
                .closeBlock("end")
                .closeBlock("end");

        LOGGER.finer("Generated waiter " + waiterName + " for operation: " + operationName);
    }

    private void renderRbsWaiter(RubyCodeWriter writer, String waiterName) {
        writer
                .write("")
                .openBlock("class $L", waiterName)
                .write("def initialize: (Client, ?::Hash[::Symbol, untyped] options) -> void\n")
                .write("attr_reader tags: Array[::String]\n")
                .write("def wait: (?::Hash[::Symbol, untyped] params, ?::Hash[::Symbol, untyped] options) -> true")
                .closeBlock("end");
    }

    private void renderWaiterDocumentation(RubyCodeWriter writer, Waiter waiter) {
        if (waiter.getDocumentation().isPresent()) {
            writer.writeDocstring(waiter.getDocumentation().get());
        }
        if (waiter.isDeprecated()) {
            writer.writeYardDeprecated("This waiter is deprecated.", "");
        }
    }

    private void renderWaiterTags(RubyCodeWriter writer, Waiter waiter) {
        String tags = waiter.getTags().stream()
                .map((tag) -> "\"" + tag + "\"")
                .collect(Collectors.joining(", "));
        writer.write("@tags = [$L]", tags);
    }

    private void renderAcceptors(RubyCodeWriter writer, Waiter waiter) {
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
                            matcher.accept(new AcceptorVisitor(writer));
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

    private void renderWaiterWaitDocumentation(RubyCodeWriter writer, String operationName) {
        writer
                .writeYardReference("param", "Client#" + operationName)
                .writeYardReturn("true", "")
                .writeYardRaise("Hearth::Waiters::FailureStateError", "")
                .writeYardRaise("Hearth::Waiters::MaxWaitTimeExceededError", "")
                .writeYardRaise("Hearth::Waiters::UnexpectedError", "");
    }

    private void renderWaiterInitializeDocumentation(RubyCodeWriter writer, Waiter waiter) {
        writer
                .writeYardParam("Client", "client", "")
                .writeYardParam("Hash", "options", "Waiter options")
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

    private final class AcceptorVisitor implements Matcher.Visitor<Void> {

        private final RubyCodeWriter writer;

        private AcceptorVisitor(RubyCodeWriter writer) {
            this.writer = writer;
        }

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

    private static class JmespathTranslator implements ExpressionVisitor<JmespathExpression> {

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
                    RubySymbolProvider.toMemberName(expression.getName()),
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
