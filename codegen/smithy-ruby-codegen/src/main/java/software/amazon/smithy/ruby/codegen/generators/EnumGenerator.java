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

import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.GenerateEnumDirective;
import software.amazon.smithy.model.loader.Prelude;
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.docs.ShapeDocumentationGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;
import software.amazon.smithy.utils.StringUtils;

@SmithyInternalApi
public final class EnumGenerator extends RubyGeneratorBase {

    private final Set<EnumShape> enumShapes;

    public EnumGenerator(GenerateEnumDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.enumShapes = directive.model().getEnumShapes();
    }

    @Override
    String getModule() {
        return "Types";
    }

    public void render() {
        write(writer -> {
            if (enumShapes.size() > 0) {
                enumShapes.forEach(enumShape -> writeEnumShape(writer, enumShape));
            }
        });

//        writeRbs(writer -> {
//            // Only write out string shapes for enums
//            EnumTrait enumTrait = shape.expectTrait(EnumTrait.class);
//            List<EnumDefinition> enumDefinitions = enumTrait.getValues().stream()
//                    .filter(value -> value.getName().isPresent())
//                    .collect(Collectors.toList());
//
//            // only write out a module if there is at least one enum constant
//            if (enumDefinitions.size() > 0) {
//                String shapeName = symbolProvider.toSymbol(shape).getName();
//                writer.openBlock("module $L", shapeName);
//                enumDefinitions.forEach(enumDefinition -> {
//                    String enumName = StringUtils.upperCase(
//                            RubyFormatter.toSnakeCase(enumDefinition.getName().get()));
//                    writer.write("$L: ::String\n", enumName);
//                });
//                writer
//                        .unwrite("\n")
//                        .closeBlock("end\n");
//            }
//        });
    }

    private void writeEnumShape(RubyCodeWriter writer, EnumShape shape) {
        String shapeName = symbolProvider.toSymbol(shape).getName();

        writer
                .writeDocstring("Enum constants for " + shapeName)
                .openBlock("module $L", shapeName);

        enumShapes.forEach(enumShape -> {
            Map<String, String> enums = enumShape.getEnumValues();

            enums.entrySet().forEach(entry -> {
                String enumName = StringUtils.upperCase(RubyFormatter.toSnakeCase(entry.getKey()));
                String enumValue = entry.getValue();
                writer
                        .call(() -> new ShapeDocumentationGenerator(model, writer, symbolProvider, shape).render())
                        .write("$L = $S\n", enumName, enumValue);
            });
        });

        writer
                .unwrite("\n")
                .closeBlock("end\n");
    }
}
