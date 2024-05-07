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

import java.nio.file.Paths;
import java.util.function.Consumer;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public abstract class RubyGeneratorBase {

    protected final Model model;
    protected final SymbolProvider symbolProvider;
    protected final RubySettings settings;
    protected final GenerationContext context;

    public RubyGeneratorBase(ContextualDirective<GenerationContext, RubySettings> directive) {
        this.symbolProvider = directive.symbolProvider();
        this.settings = directive.settings();
        this.context = directive.context();
        this.model = directive.model();
    }

    protected abstract String getModule();

    public final void write(Consumer<RubyCodeWriter> writerConsumer) {
        write(rbFile(), nameSpace(), writerConsumer);
    }

    public final void writeRbs(Consumer<RubyCodeWriter> writerConsumer) {
        write(rbsFile(), nameSpace(), writerConsumer);
    }

    public final void write(String file, String namespace, Consumer<RubyCodeWriter> writerConsumer) {
        context.writerDelegator().useFileWriter(file, namespace, writerConsumer);
    }

    public String nameSpace() {
        return settings.getModule() + "::" + getModule();
    }

    public String rbFile() {
        return Paths.get(settings.getGemName(), "lib", settings.getGemName(),
                RubyFormatter.toSnakeCase(getModule()) + ".rb").toString();
    }

    public String rbsFile() {
        return Paths.get(settings.getGemName(), "sig", settings.getGemName(),
                RubyFormatter.toSnakeCase(getModule()) + ".rbs").toString();
    }
}
