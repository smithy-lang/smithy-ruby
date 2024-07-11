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

package software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators;


import java.util.stream.Stream;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.SparseTrait;
import software.amazon.smithy.model.traits.UnitTypeTrait;
import software.amazon.smithy.model.traits.synthetic.OriginalShapeIdTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyImportContainer;
import software.amazon.smithy.ruby.codegen.generators.BuilderGeneratorBase;
import software.amazon.smithy.ruby.codegen.traits.NoSerializeTrait;

public class BuilderGenerator extends BuilderGeneratorBase {

    public BuilderGenerator(GenerationContext context) {
        super(context);
    }

    private void renderMemberBuilders(Shape s) {
        Stream<MemberShape> serializeMembers = s.members().stream()
                .filter(NoSerializeTrait.excludeNoSerializeMembers());

        serializeMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());

            String symbolName = ":" + symbolProvider.toMemberName(member);
            String dataName = "'" + member.getMemberName() + "'";

            String dataSetter = "data[" + dataName + "] = ";
            String inputGetter = "input[" + symbolName + "]";
            target.accept(new MemberSerializer(member, dataSetter, inputGetter, true));
        });
    }

    @Override
    protected void renderOperationBuildMethod(OperationShape operation, Shape inputShape) {
        writer
                .openBlock("def self.build(http_req, input:)")
                .write("http_req.http_method = 'POST'")
                .write("http_req.append_path('/service/$L/operation/$L')",
                        context.service().getId().getName(), operation.getId().getName())
                .write("http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'")
                .call(() -> {
                    // if the modeled input has NO structure (Unit) skip content-type and set an empty body
                    if (!(inputShape.hasTrait(OriginalShapeIdTrait.class)
                            && inputShape.expectTrait(OriginalShapeIdTrait.class).getOriginalId()
                            .equals(UnitTypeTrait.UNIT))) {
                        writer
                                .write("data = {}")
                                .call(() -> renderMemberBuilders(inputShape))
                                .write("http_req.headers['Content-Type'] = 'application/cbor'")
                                .write("http_req.body = $T.new($T.encode(data))",
                                        RubyImportContainer.STRING_IO, Hearth.CBOR);
                    } else {
                        writer.write("data = {}");
                    }
                })
                .closeBlock("end");
    }

    @Override
    protected void renderStructureBuildMethod(StructureShape shape) {
        writer
                .openBlock("def self.build(input)")
                .write("data = {}")
                .call(() -> renderMemberBuilders(shape))
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderListBuildMethod(ListShape shape) {
        writer
                .openBlock("def self.build(input)")
                .write("data = []")
                .openBlock("input.each do |element|")
                .call(() -> {
                    Shape memberTarget = model.expectShape(shape.getMember().getTarget());
                    memberTarget.accept(new MemberSerializer(shape.getMember(), "data << ", "element",
                            !shape.hasTrait(SparseTrait.class)));
                })
                .closeBlock("end")
                .write("data")
                .closeBlock("end");
    }

    @Override
    protected void renderUnionBuildMethod(UnionShape shape) {
        writer
                .openBlock("def self.build(input)")
                .write("data = {}")
                .write("case input");

        shape.members().forEach((member) -> {
            writer
                    .write("when $T", context.symbolProvider().toSymbol(member))
                    .indent();
            renderUnionMemberBuilder(shape, member);
            writer.dedent();
        });
        writer.openBlock("else")
                .write("raise ArgumentError,\n\"Expected input to be one of the subclasses of $T\"",
                        context.symbolProvider().toSymbol(shape))
                .closeBlock("end")
                .write("")
                .write("data")
                .closeBlock("end");
    }

    private void renderUnionMemberBuilder(UnionShape shape, MemberShape member) {
        Shape target = model.expectShape(member.getTarget());
        String dataSetter = "data['" + member.getMemberName() + "'] = ";
        if (target.isUnionShape()) {
            writer.write("input = input.__getobj__"); // need to avoid infinite recursion
        }
        target.accept(new MemberSerializer(member, dataSetter, "input", false));
    }

    @Override
    protected void renderMapBuildMethod(MapShape shape) {
        writer
                .openBlock("def self.build(input)")
                .write("data = {}")
                .openBlock("input.each do |key, value|")
                .call(() -> {
                    Shape valueTarget = model.expectShape(shape.getValue().getTarget());
                    valueTarget.accept(new MemberSerializer(shape.getValue(), "data[key] = ", "value",
                            !shape.hasTrait(SparseTrait.class)));
                })
                .closeBlock("end")
                .write("data")
                .closeBlock("end");
    }

    private class MemberSerializer extends ShapeVisitor.Default<Void> {

        private final String inputGetter;
        private final String dataSetter;
        private final MemberShape memberShape;
        private final boolean checkRequired;

        MemberSerializer(MemberShape memberShape,
                         String dataSetter, String inputGetter, boolean checkRequired) {
            this.inputGetter = inputGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
            this.checkRequired = checkRequired;
        }

        private String checkRequired() {
            if (this.checkRequired) {
                return " unless " + inputGetter + ".nil?";
            } else {
                return "";
            }
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L$L", dataSetter, inputGetter, checkRequired());
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("$1L((String === $2L ? $2L : $2L.read).encode(Encoding::BINARY))$3L",
                    dataSetter, inputGetter, checkRequired());
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$L$L$L",
                    dataSetter, inputGetter, checkRequired());
            return null;
        }

        /**
         * For complex shapes, simply delegate to their builder.
         */
        private void defaultComplexSerializer(Shape shape) {
            if (checkRequired) {
                writer.write("$1L$2L.build($3L) unless $3L.nil?",
                        dataSetter, symbolProvider.toSymbol(shape).getName(),
                        inputGetter);
            } else {
                writer.write("$1L($2L.build($3L) unless $3L.nil?)",
                        dataSetter, symbolProvider.toSymbol(shape).getName(),
                        inputGetter);
            }
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }
    }

}
