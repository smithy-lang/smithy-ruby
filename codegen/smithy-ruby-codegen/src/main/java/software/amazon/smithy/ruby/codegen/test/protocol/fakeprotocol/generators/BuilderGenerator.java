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

package software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.generators;

import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.generators.RestBuilderGeneratorBase;

public class BuilderGenerator extends RestBuilderGeneratorBase {
    public BuilderGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    protected void renderBuildersForOperation(OperationShape operation, Shape inputShape) {
        Symbol symbol = symbolProvider.toSymbol(operation);
        writer
                .write("")
                .write("# Operation Builder for $L", operation.getId().getName())
                .openBlock("class $L", symbol.getName())
                .openBlock("def self.build(http_req, input:)")
                .closeBlock("end")
                .closeBlock("end");
    }

    @Override
    protected void renderPayloadBodyBuilder(OperationShape operation, Shape inputShape, MemberShape payloadMember,
                                            Shape target) {

    }

    @Override
    protected void renderBodyBuilder(OperationShape operation, Shape inputShape) {

    }

    @Override
    protected void renderStructureBuildMethod(StructureShape shape) {

    }

    @Override
    protected void renderListBuildMethod(ListShape shape) {

    }

    @Override
    protected void renderSetBuildMethod(SetShape shape) {

    }

    @Override
    protected void renderUnionBuildMethod(UnionShape shape) {

    }

    @Override
    protected void renderMapBuildMethod(MapShape shape) {

    }

}


