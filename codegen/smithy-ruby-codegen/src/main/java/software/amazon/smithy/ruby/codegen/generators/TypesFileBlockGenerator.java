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

import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class TypesFileBlockGenerator extends RubyGeneratorBase {

    public TypesFileBlockGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
    }

    @Override
    String getModule() {
        return "Types";
    }

    public void openBlocks() {
        context.writerDelegator().useFileWriter(rbFile(), nameSpace(), writer -> {
            writer.includePreamble().includeRequires();
            writer.addModule(settings.getModule());
            writer.addModule("Types");
        });
        context.writerDelegator().useFileWriter(rbsFile(), nameSpace(), writer -> {
            writer.includePreamble();
            writer.addModule(settings.getModule());
            writer.addModule("Types");
        });
    }

    public void closeAllBlocks() {
        context.writerDelegator().useFileWriter(rbFile(), nameSpace(), RubyCodeWriter::closeAllModules);
        context.writerDelegator().useFileWriter(rbsFile(), nameSpace(), RubyCodeWriter::closeAllModules);
    }
}
