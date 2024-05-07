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

package software.amazon.smithy.ruby.codegen.generators.types;

import java.util.Map;
import software.amazon.smithy.codegen.core.directed.GenerateIntEnumDirective;
import software.amazon.smithy.model.shapes.IntEnumShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.RubyGeneratorBase;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;
import software.amazon.smithy.utils.StringUtils;

@SmithyInternalApi
public final class IntEnumGenerator extends RubyGeneratorBase {

    private final IntEnumShape shape;

    public IntEnumGenerator(GenerateIntEnumDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.shape = directive.expectIntEnumShape();
    }

    @Override
    protected String getModule() {
        return "Types";
    }

    public void render() {
        String shapeName = symbolProvider.toSymbol(shape).getName();
        Map<String, Integer> enumValues = shape.getEnumValues();

        write(writer -> {
            writer
                    .writeDocstring("Enum constants for " + shapeName)
                    .call(() -> new ShapeDocumentationGenerator(model, writer, symbolProvider, shape).render())
                    .addModule(shapeName);

            enumValues.entrySet().forEach(entry -> {
                String enumName = StringUtils.upperCase(RubyFormatter.toSnakeCase(entry.getKey()));
                Integer enumValue = entry.getValue();
                writer.write("$L = $L\n", enumName, enumValue);
            });

            writer
                    .unwrite("\n")
                    .closeModule()
                    .write("");
        });

        writeRbs(writer -> {
            writer.addModule(shapeName);

            enumValues.entrySet().forEach(entry -> {
                String enumName = StringUtils.upperCase(RubyFormatter.toSnakeCase(entry.getKey()));
                writer.write("$L: ::Numeric\n", enumName);
            });

            writer
                    .unwrite("\n")
                    .closeModule()
                    .write("");
        });
    }
}
