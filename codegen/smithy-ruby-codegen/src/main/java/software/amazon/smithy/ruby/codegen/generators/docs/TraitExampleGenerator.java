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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.Optional;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.ExamplesTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.util.ParamsToHash;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class TraitExampleGenerator {

    private final OperationShape operation;
    private final SymbolProvider symbolProvider;
    private final Model model;
    private final RubyCodeWriter writer;
    private final Optional<String> documentation;
    private final ObjectNode input;
    private final ObjectNode output;
    private final Optional<ExamplesTrait.ErrorExample> error;
    private final String operationName;
    private final Shape operationInput;
    private final Shape operationOutput;

    public TraitExampleGenerator(OperationShape operation, SymbolProvider symbolProvider,
                                 Model model, ExamplesTrait.Example example) {
        this.operation = operation;
        this.symbolProvider = symbolProvider;
        this.model = model;
        this.writer = new RubyCodeWriter();
        this.documentation = example.getDocumentation();
        this.input = example.getInput();
        this.output = example.getOutput();
        this.error = example.getError();

        this.operationName =
                RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());
        this.operationInput = model.expectShape(operation.getInputShape());
        this.operationOutput = model.expectShape(operation.getOutputShape());
    }

    public String generate() {
        if (error.isPresent()) {
            generateExampleWithError(error.get());
        } else {
            generateExample();
        }

        return writer.toString();
    }

    private void generateExample() {
        generateExampleInput();
        writer
                .write("")
                .write("# resp.to_h outputs the following:")
                .write(operationOutput.accept(new ParamsToHash(model, output, symbolProvider)));
    }

    private void generateExampleWithError(ExamplesTrait.ErrorExample errorExample) {

        Shape errorShape = model.expectShape(errorExample.getShapeId());
        writer.openBlock("begin");
        generateExampleInput();

        writer
                .dedent()
                .write("rescue ApiError => e")
                .indent()
                .write("puts e.class # $L", symbolProvider.toSymbol(errorShape).getName())
                .write("puts e.data.to_h")
                .closeBlock("end")
                .write("")
                .write("# e.data.to_h outputs the following:")
                .write(errorShape
                        .accept(new ParamsToHash(model, errorExample.getContent(), symbolProvider)));
    }

    private void generateExampleInput() {
        if (input.isEmpty()) {
            writer.write("resp = client.$L()", operationName);
        } else {
            if (documentation.isPresent()) {
                writer.writeDocstring(documentation.get());
            }
            writer
                    .writeInline("resp = client.$L(", operationName)
                    .writeInline(operationInput.accept(new ParamsToHash(model, input, symbolProvider)))
                    .write(")");
        }
    }
}
