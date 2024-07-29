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

import java.util.Optional;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.traits.TitleTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;

public class YardOptsGenerator {

    private final GenerationContext context;

    public YardOptsGenerator(GenerationContext context) {
        this.context = context;
    }

    public void render() {
        Optional<TitleTrait> title = context.service().getTrait(TitleTrait.class);
        if (title.isPresent()) {
            FileManifest fileManifest = context.fileManifest();
            RubyCodeWriter writer = new RubyCodeWriter(context.settings().getModule());
            writer
                    .write("--title \"$L\"", title.get().getValue())
                    .write("--hide-api private")
                    .write("--markup markdown")
                    .write("--markup-provider rdiscount");
            String fileName = context.settings().getGemName() + "/.yardopts";
            fileManifest.writeFile(fileName, writer.toString());
        }
    }
}
