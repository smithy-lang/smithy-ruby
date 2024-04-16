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

package software.amazon.smithy.ruby.codegen.auth;

import java.util.Objects;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.utils.SmithyBuilder;

public final class AuthParam {

    public static final AuthParam OPERATION_NAME = AuthParam.builder()
            .name("operation_name")
            .rbsType("::Symbol")
            .paramValue((_p, context, operation) -> {
                return RubyFormatter.asSymbol(context.symbolProvider().toSymbol(operation).getName());
            })
            .build();
    private final String name;
    private final String rbsType;
    private final ParamValue paramValue;

    private AuthParam(Builder builder) {
        this.name = Objects.requireNonNull(builder.name);
        this.rbsType = Objects.requireNonNull(builder.rbsType);
        this.paramValue = Objects.requireNonNull(builder.paramValue);
    }

    public static AuthParam.Builder builder() {
        return new AuthParam.Builder();
    }

    public String getName() {
        return name;
    }

    public String getRbsType() {
        return rbsType;
    }

    public String renderParamValue(GenerationContext context, OperationShape operation) {
        return this.paramValue.paramValue(this, context, operation);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AuthParam authParam = (AuthParam) o;
        return Objects.equals(name, authParam.name) && Objects.equals(rbsType, authParam.rbsType)
                && Objects.equals(paramValue, authParam.paramValue);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, rbsType, paramValue);
    }

    @FunctionalInterface
    /**
     * Called to render setting the value of this AuthParam in generated Auth middleware.
     * Has access to the resolved service Config through `config`.
     */
    public interface ParamValue {
        /**
         * Called to render setting the value of this AuthParam in generated Auth middleware.
         * Has access to the resolved service Config through `config`.
         *
         * @param param     - auth param to set value for.
         * @param context   - generation context
         * @param operation - operation being rendered
         */
        String paramValue(AuthParam param, GenerationContext context, OperationShape operation);
    }

    public static class Builder implements SmithyBuilder<AuthParam> {

        private String name;
        private String rbsType;
        private ParamValue paramValue;

        /**
         * @param name the name of the parameter.
         * @return this builder.
         */
        public Builder name(String name) {
            this.name = name;
            return this;
        }

        /**
         * @param rbsType rbsType to use for this parameter.
         * @return this builder.
         */
        public Builder rbsType(String rbsType) {
            this.rbsType = rbsType;
            return this;
        }

        /**
         * A static ruby code fragment that is used to set the parameter value.
         *
         * @param valueSetter - Ruby code fragment that sets the value.
         * @return this builder.
         */
        public Builder paramValue(String valueSetter) {
            this.paramValue = (_p, _context, _operation) -> {
                return valueSetter;
            };
            return this;
        }

        public Builder paramValue(ParamValue paramValue) {
            this.paramValue = paramValue;
            return this;
        }

        @Override
        public AuthParam build() {
            return new AuthParam(this);
        }
    }

}
