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
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.directed.GenerateEnumDirective;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.traits.EnumDefinition;
import software.amazon.smithy.model.traits.EnumTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public final class EnumGenerator extends RubyGeneratorBase {

    private final Shape shape;

    public EnumGenerator(GenerateEnumDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.shape = directive.shape();
    }

    @Override
    String getModule() {
        return "Types";
    }

    public void render() {
        write(writer -> {
            final EnumTrait enumTrait = shape.expectTrait(EnumTrait.class);

            List<EnumDefinition> enumDefinitions = enumTrait.getValues().stream()
                    .filter(value -> value.getName().isPresent())
                    .collect(Collectors.toList());

            // only write out a module if there is at least one enum constant
            if (enumDefinitions.size() > 0) {
                String shapeName = symbolProvider.toSymbol(shape).getName();

                writer
                        .writeDocstring("Includes enum constants for " + shapeName)
                        .openBlock("module $L", shapeName);

                enumDefinitions.forEach(enumDefinition -> {
                    String enumName = enumDefinition.getName().get();
                    String enumValue = enumDefinition.getValue();
                    String enumDocumentation = enumDefinition.getDocumentation()
                            .orElse("No documentation available.");
                    writer.writeDocstring(enumDocumentation);
                    if (enumDefinition.isDeprecated()) {
                        writer.writeYardDeprecated("This enum value is deprecated.", "");
                    }
                    if (!enumDefinition.getTags().isEmpty()) {
                        String enumTags = enumDefinition.getTags().stream()
                                .map((tag) -> "\"" + tag + "\"")
                                .collect(Collectors.joining(", "));
                        writer.writeDocstring("Tags: [" + enumTags + "]");
                    }
                    writer.write("$L = $S\n", enumName, enumValue);
                });

                writer
                        .unwrite("\n")
                        .closeBlock("end\n");
            }
        });

        writeRbs(writer -> {
            // Only write out string shapes for enums
            EnumTrait enumTrait = shape.expectTrait(EnumTrait.class);
            List<EnumDefinition> enumDefinitions = enumTrait.getValues().stream()
                    .filter(value -> value.getName().isPresent())
                    .collect(Collectors.toList());

            // only write out a module if there is at least one enum constant
            if (enumDefinitions.size() > 0) {
                String shapeName = symbolProvider.toSymbol(shape).getName();
                writer.openBlock("module $L", shapeName);
                enumDefinitions.forEach(enumDefinition -> {
                    String enumName = enumDefinition.getName().get();
                    writer.write("$L: ::String\n", enumName);
                });
                writer
                    .unwrite("\n")
                    .closeBlock("end\n");
            }
        });
    }
}
