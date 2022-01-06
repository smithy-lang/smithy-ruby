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

package software.amazon.smithy.ruby.codegen;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import software.amazon.smithy.codegen.core.SymbolDependency;
import software.amazon.smithy.codegen.core.SymbolDependencyContainer;
import software.amazon.smithy.utils.SetUtils;
import software.amazon.smithy.utils.SmithyBuilder;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Describes a dependency in Ruby.
 */
@SmithyUnstableApi
public final class RubyDependency
        implements SymbolDependencyContainer, Comparable<RubyDependency> {

    public static final RubyDependency TIME = new Builder()
            .type(Type.STANDARD_LIBRARY)
            .importPath("time")
            .version(">= 0")
            .build();

    public static final RubyDependency BIG_DECIMAL = new Builder()
            .type(Type.STANDARD_LIBRARY)
            .importPath("bigdecimal")
            .version(">= 0")
            .build();


    private final Type type;
    private final String importPath;
    private final String version;
    private final Set<RubyDependency> dependencies;
    private final SymbolDependency symbolDependency;

    private RubyDependency(Builder builder) {
        this.type = SmithyBuilder.requiredState("type", builder.type);
        this.importPath =
                SmithyBuilder.requiredState("importPath", builder.importPath);
        this.version = SmithyBuilder.requiredState("version", builder.version);
        this.dependencies = SmithyBuilder
                .requiredState("dependencies", builder.dependencies);

        this.symbolDependency = SymbolDependency.builder()
                .dependencyType(this.type.toString())
                .packageName(this.importPath)
                .version(this.version)
                .build();
    }

    public static Builder builder() {
        return new Builder();
    }

    /**
     * Get the symbol dependency representing the dependency.
     *
     * @return the symbol dependency
     */
    public SymbolDependency getSymbolDependency() {
        return symbolDependency;
    }

    /**
     * Get the type of dependency.
     *
     * @return the dependency type
     */
    public Type getType() {
        return type;
    }

    /**
     * Get the import path of the dependency.
     *
     * @return the import path of the dependency
     */
    public String getImportPath() {
        return importPath;
    }

    /**
     * Get the version of the dependency.
     *
     * @return the version
     */
    public String getVersion() {
        return version;
    }

    @Override
    public List<SymbolDependency> getDependencies() {
        Set<SymbolDependency> symbolDependencySet =
                new TreeSet<>(SetUtils.of(getSymbolDependency()));
        dependencies
                .forEach(d -> symbolDependencySet.add(d.getSymbolDependency()));
        return new ArrayList<>(symbolDependencySet);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof RubyDependency)) {
            return false;
        }

        RubyDependency other = (RubyDependency) o;

        return this.type.equals(other.type)
                && this.importPath.equals(other.importPath)
                && this.version.equals(other.version);
    }

    @Override
    public int hashCode() {
        return Objects.hash(type, importPath, version);
    }

    @Override
    public int compareTo(RubyDependency o) {
        if (equals(o)) {
            return 0;
        }

        int importPathCompare = importPath.compareTo(o.importPath);
        if (importPathCompare != 0) {
            return importPathCompare;
        }

        return version.compareTo(o.version);
    }

    /**
     * Represents a dependency type.
     */
    public enum Type {
        STANDARD_LIBRARY, DEPENDENCY;

        @Override
        public String toString() {
            switch (this) {
                case STANDARD_LIBRARY:
                    return "stdlib";
                case DEPENDENCY:
                    return "dependency";
                default:
                    return "unknown";
            }
        }
    }

    /**
     * Builder for {@link RubyDependency}.
     */
    public static final class Builder implements SmithyBuilder<RubyDependency> {
        private final Set<RubyDependency> dependencies = new TreeSet<>();
        private Type type;
        private String importPath;
        private String version;

        private Builder() {
        }

        /**
         * Set the dependency type.
         *
         * @param type dependency type
         * @return the builder
         */
        public Builder type(Type type) {
            this.type = type;
            return this;
        }

        /**
         * Set the import path.
         *
         * @param importPath the import path
         * @return the builder
         */
        public Builder importPath(String importPath) {
            this.importPath = importPath;
            return this;
        }

        /**
         * Set the dependency version.
         *
         * @param version the version
         * @return the builder
         */
        public Builder version(String version) {
            this.version = version;
            return this;
        }

        /**
         * Set the collection of {@link RubyDependency} required by this dependency.
         *
         * @param dependencies a collection of dependencies
         * @return the builder
         */
        public Builder dependencies(Collection<RubyDependency> dependencies) {
            this.dependencies.clear();
            this.dependencies.addAll(dependencies);
            return this;
        }

        /**
         * Add a dependency on another {@link RubyDependency}.
         *
         * @param dependency the dependency
         * @return the builder
         */
        public Builder addDependency(RubyDependency dependency) {
            this.dependencies.add(dependency);
            return this;
        }

        /**
         * Remove a dependency on another {@link RubyDependency}.
         *
         * @param dependency the dependency
         * @return the builder
         */
        public Builder removeDependency(RubyDependency dependency) {
            this.dependencies.remove(dependency);
            return this;
        }

        @Override
        public RubyDependency build() {
            return new RubyDependency(this);
        }
    }
}
