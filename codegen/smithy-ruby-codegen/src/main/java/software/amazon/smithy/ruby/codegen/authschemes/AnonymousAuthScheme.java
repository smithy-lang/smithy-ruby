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

package software.amazon.smithy.ruby.codegen.authschemes;

import java.util.ArrayList;
import java.util.List;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.traits.synthetic.NoAuthTrait;
import software.amazon.smithy.ruby.codegen.Hearth;

public class AnonymousAuthScheme implements AuthScheme {
    public ShapeId getShapeId() {
        return NoAuthTrait.ID;
    }

    public String rubyAuthScheme() {
        return Hearth.AUTH_SCHEMES + "::Anonymous.new";
    }

    public String rubyIdentityClass() {
        return null;
    }

    public String rubyIdentityResolverConfigName() {
        return null;
    }

    public String rubyStubbedIdentity() {
        return null;
    }

    public List<String> additionalAuthParams() {
        return new ArrayList<>();
    }
}
