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

package software.amazon.smithy.ruby.codegen;

import java.util.Set;
import java.util.TreeSet;
import software.amazon.smithy.codegen.core.ImportContainer;
import software.amazon.smithy.codegen.core.SmithyIntegration;
import software.amazon.smithy.codegen.core.Symbol;

public class RubyImportContainer
        implements ImportContainer, SmithyIntegration<RubySettings, RubyCodeWriter, GenerationContext> {

    public static final Symbol SECURE_RANDOM = Symbol.builder()
            .name("SecureRandom")
            .addDependency(RubyDependency.SECURE_RANDOM)
            .build();

    private final String namespace;
    private final Set<String> requires = new TreeSet<>();


    public RubyImportContainer(String namespace) {
        this.namespace = namespace;
    }

    @Override
    public void importSymbol(Symbol symbol, String alias) {
        // We currently don't need to require_relative any symbols defined by the SDK
        // they are all required in the module definition already
        // So, add requires only for symbols that have external (including stdlib like time/stringio) dependencies
        symbol.getDependencies().forEach(d -> {
            if (shouldRequire(d.getDependencyType())) {
                requires.add(d.getPackageName());
            }
        });
    }

    private boolean shouldRequire(String dependencyType) {
        return dependencyType.equals(RubyDependency.Type.DEPENDENCY.toString())
                || dependencyType.equals(RubyDependency.Type.STANDARD_LIBRARY.toString());
    }

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder();
        requires.forEach(r -> {
            result.append(String.format("require '%s'%n", r));
        });

        return result.toString();
    }
}
