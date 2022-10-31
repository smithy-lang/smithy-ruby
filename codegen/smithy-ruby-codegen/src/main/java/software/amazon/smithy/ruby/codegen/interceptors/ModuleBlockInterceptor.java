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

package software.amazon.smithy.ruby.codegen.interceptors;

import software.amazon.smithy.ruby.codegen.ModuleBlockSection;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.utils.CodeInterceptor;

public class ModuleBlockInterceptor implements CodeInterceptor<ModuleBlockSection, RubyCodeWriter> {

    @Override
    public Class<ModuleBlockSection> sectionType() {
        return ModuleBlockSection.class;
    }

    @Override
    public boolean isIntercepted(ModuleBlockSection section) {
        return true;
    }

    @Override
    public void write(RubyCodeWriter writer, String previous, ModuleBlockSection section) {
        writer
            .includePreamble()
            .includeRequires()
            .openBlock("module $L", section.getModule())
            .write("$L", previous)
            .closeBlock("end");
    }
}
