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

import java.util.function.Consumer;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.codegen.core.directed.GenerateIntEnumDirective;
import software.amazon.smithy.model.shapes.IntEnumShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubySettings;

public final class IntEnumGenerator extends TypesFileGenerator
    implements Consumer<GenerateIntEnumDirective<GenerationContext, RubySettings>> {

    public IntEnumGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
    }

    @Override
    public void accept(GenerateIntEnumDirective<GenerationContext, RubySettings> directive) {
        var shape = (IntEnumShape) directive.shape();

        directive.context().writerDelegator().useFileWriter(rbFile(), nameSpace(), writer -> {
            // only write out a module if there is at least one enum constant
            if (shape.getEnumValues().size() > 0) {
                String shapeName = symbolProvider.toSymbol(shape).getName();

                writer.writeDocstring("Includes enum constants for " + shapeName)
                        .addModule(shapeName);

                shape.getEnumValues()
                        .forEach((enumName, enumValue) -> writer.write("$L = $L\n", enumName, enumValue));

                writer.unwrite("\n").closeModule();
            }
        });
    }
}
