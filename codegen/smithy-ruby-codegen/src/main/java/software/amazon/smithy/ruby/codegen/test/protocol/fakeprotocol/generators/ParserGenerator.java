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

import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.generators.RestParserGeneratorBase;

public class ParserGenerator extends RestParserGeneratorBase {

    public ParserGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    protected void renderPayloadBodyParser(Shape outputShape, MemberShape payloadMember, Shape target) {

    }

    @Override
    protected void renderBodyParser(Shape outputShape) {

    }

    @Override
    protected void renderUnionParseMethod(UnionShape s) {

    }

    @Override
    protected void renderMapParseMethod(MapShape s) {

    }

    @Override
    protected void renderSetParseMethod(SetShape s) {

    }

    @Override
    protected void renderListParseMethod(ListShape s) {

    }

    @Override
    protected void renderStructureParseMethod(StructureShape s) {

    }
}

