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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.DeprecatedTrait;
import software.amazon.smithy.model.traits.DocumentationTrait;
import software.amazon.smithy.model.traits.ExamplesTrait;
import software.amazon.smithy.model.traits.ExternalDocumentationTrait;
import software.amazon.smithy.model.traits.InternalTrait;
import software.amazon.smithy.model.traits.RecommendedTrait;
import software.amazon.smithy.model.traits.SensitiveTrait;
import software.amazon.smithy.model.traits.SinceTrait;
import software.amazon.smithy.model.traits.TagsTrait;
import software.amazon.smithy.model.traits.UnstableTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class ShapeDocumentationGenerator {
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;
    private final Shape shape;

    public ShapeDocumentationGenerator(Model model, SymbolProvider symbolProvider, Shape shape) {
        this.writer = new RubyCodeWriter();
        this.model = model;
        this.symbolProvider = symbolProvider;
        this.shape = shape;
    }

    public String render() {
        shape.accept(new ShapeDocumentationVisitor());
        return writer.toString();
    }

    private void writeDocumentationTrait(Optional<DocumentationTrait> optionalDocumentationTrait) {
        if (optionalDocumentationTrait.isPresent()) {
            String documentation = optionalDocumentationTrait.get().getValue();
            writer.writeDocstring(documentation);
        }
    }

    private void writeSinceTrait(Optional<SinceTrait> optionalSinceTrait) {
        if (optionalSinceTrait.isPresent()) {
            String since = optionalSinceTrait.get().getValue();
            writer.writeYardSince(since);
        }
    }

    private void writeUnstableTrait(Optional<UnstableTrait> optionalUnstableTrait) {
        if (optionalUnstableTrait.isPresent()) {
            writer.writeYardNote("This shape is unstable and may change in the future.");
        }
    }

    private void writeInternalTrait(Optional<InternalTrait> optionalInternalTrait) {
        if (optionalInternalTrait.isPresent()) {
            writer.writeYardNote("This shape is meant for internal use only.");
        }
    }

    private void writeRecommendedTrait(Optional<RecommendedTrait> optionalRecommendedTrait) {
        if (optionalRecommendedTrait.isPresent()) {
            Optional<String> optionalReason = optionalRecommendedTrait.get().getReason();
            if (optionalReason.isPresent()) {
                String documentation = "This shape is recommended.\nReason: " + optionalReason.get();
                writer.writeYardNote(documentation);
            }
        }
    }

    private void writeExternalDocumentationTrait(
            Optional<ExternalDocumentationTrait> optionalExternalDocumentationTrait) {
        if (optionalExternalDocumentationTrait.isPresent()) {
            Map<String, String> urls = optionalExternalDocumentationTrait.get().getUrls();
            for (Map.Entry<String, String> entry : urls.entrySet()) {
                writer.writeYardSee(entry.getValue(), entry.getKey());
            }
        }
    }

    private void writeDeprecatedTrait(Optional<DeprecatedTrait> optionalDeprecatedTrait) {
        if (optionalDeprecatedTrait.isPresent()) {
            DeprecatedTrait deprecatedTrait = optionalDeprecatedTrait.get();
            String message = deprecatedTrait.getMessage().orElse("");
            String since = deprecatedTrait.getSince().orElse("");
            writer.writeYardDeprecated(message, since);
        }
    }

    private void writeTagsTrait(Optional<TagsTrait> optionalTagsTrait) {
        // does nothing right now
    }

    private void writeExamplesTrait(Optional<ExamplesTrait> optionalExamplesTrait) {
        if (optionalExamplesTrait.isPresent()) {
            List<ExamplesTrait.Example> examples = optionalExamplesTrait.get().getExamples();
            examples.forEach((example) -> {
                String title = example.getTitle();
                writer.writeYardExample(
                        title,
                        new TraitExampleGenerator((OperationShape) shape, symbolProvider, model, example).generate()
                );
            });
        }
    }

    private void writeSensitiveTrait(Optional<SensitiveTrait> optionalSensitiveTrait) {
        if (optionalSensitiveTrait.isPresent()) {
            writer.writeYardNote("This shape is sensitive and must be handled with care.");
        }
    }

    private void writeAllShapeTraits() {
        Optional<DocumentationTrait> optionalDocumentationTrait =
                shape.getTrait(DocumentationTrait.class);
        Optional<DeprecatedTrait> optionalDeprecatedTrait =
                shape.getTrait(DeprecatedTrait.class);
        Optional<ExternalDocumentationTrait> optionalExternalDocumentationTrait =
                shape.getTrait(ExternalDocumentationTrait.class);
        Optional<InternalTrait> optionalInternalTrait =
                shape.getTrait(InternalTrait.class);
        Optional<SinceTrait> optionalSinceTrait =
                shape.getTrait(SinceTrait.class);
        // TODO - implement tags trait
        // Optional<TagsTrait> optionalTagsTrait =
        //         shape.getTrait(TagsTrait.class);
        Optional<UnstableTrait> optionalUnstableTrait =
                shape.getTrait(UnstableTrait.class);
        Optional<SensitiveTrait> optionalSensitiveTrait =
                shape.getTrait(SensitiveTrait.class);

        writeDocumentationTrait(optionalDocumentationTrait);
        writeDeprecatedTrait(optionalDeprecatedTrait);
        writeUnstableTrait(optionalUnstableTrait);
        writeExternalDocumentationTrait(optionalExternalDocumentationTrait);
        writeInternalTrait(optionalInternalTrait);
        writeSinceTrait(optionalSinceTrait);
        writeSensitiveTrait(optionalSensitiveTrait);
    }

    private class ShapeDocumentationVisitor extends ShapeVisitor.Default<Void> {
        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            writeAllShapeTraits();
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            writeAllShapeTraits();
            return null;
        }

        @Override
        public Void memberShape(MemberShape shape) {
            Optional<DocumentationTrait> optionalMemberDocumentationTrait =
                    shape.getMemberTrait(model, DocumentationTrait.class);
            Optional<DeprecatedTrait> optionalMemberDeprecatedTrait =
                    shape.getMemberTrait(model, DeprecatedTrait.class);
            Optional<ExternalDocumentationTrait> optionalMemberExternalDocumentationTrait =
                    shape.getMemberTrait(model, ExternalDocumentationTrait.class);
            Optional<InternalTrait> optionalMemberInternalTrait =
                    shape.getMemberTrait(model, InternalTrait.class);
            Optional<RecommendedTrait> optionalMemberRecommendedTrait =
                    shape.getMemberTrait(model, RecommendedTrait.class);
            Optional<SinceTrait> optionalMemberSinceTrait =
                    shape.getMemberTrait(model, SinceTrait.class);
            // TODO - implement tags trait
            // Optional<TagsTrait> optionalMemberTagsTrait =
            //        memberShape.getMemberTrait(model, TagsTrait.class);
            Optional<UnstableTrait> optionalMemberUnstableTrait =
                    shape.getMemberTrait(model, UnstableTrait.class);
            Optional<SensitiveTrait> optionalMemberSensitiveTrait =
                    shape.getMemberTrait(model, SensitiveTrait.class);

            writeDocumentationTrait(optionalMemberDocumentationTrait);
            writeDeprecatedTrait(optionalMemberDeprecatedTrait);
            writeUnstableTrait(optionalMemberUnstableTrait);
            writeExternalDocumentationTrait(optionalMemberExternalDocumentationTrait);
            writeInternalTrait(optionalMemberInternalTrait);
            writeRecommendedTrait(optionalMemberRecommendedTrait);
            writeSinceTrait(optionalMemberSinceTrait);
            writeSensitiveTrait(optionalMemberSensitiveTrait);

            return null;
        }

        @Override
        public Void operationShape(OperationShape shape) {
            writeAllShapeTraits();

            Shape inputShape = model.expectShape(shape.getInputShape());
            String inputShapeName = symbolProvider.toSymbol(inputShape).getName();
            String inputShapeDocumentation = "See {Types::" + inputShapeName + "}.";

            writer.writeYardParam("Hash", "params", inputShapeDocumentation);

            ShapeId inputShapeId = shape.getInputShape();
            StructureShape input =
                    model.expectShape(inputShapeId).asStructureShape().get();

            for (MemberShape memberShape : input.members()) {
                Optional<DocumentationTrait> optionalMemberDocumentation =
                        memberShape.getMemberTrait(model, DocumentationTrait.class);

                if (optionalMemberDocumentation.isPresent()) {
                    String documentation = optionalMemberDocumentation.get().getValue();
                    Shape target = model.expectShape(memberShape.getTarget());
                    String param = ":" + symbolProvider.toMemberName(memberShape);
                    String type = (String) symbolProvider.toSymbol(target).getProperty("yardType").get();
                    writer.writeYardOption("params", type, param, "", documentation);
                }
            }

            Shape outputShape = model.expectShape(shape.getOutputShape());
            String outputShapeName = symbolProvider.toSymbol(outputShape).getName();
            String outputShapeType = "Types::" + outputShapeName;

            writer
                    .writeYardReturn(outputShapeType, "")
                    .writeYardExample(
                            "Request syntax with placeholder values",
                            new PlaceholderExampleGenerator(shape, symbolProvider, model).generate()
                    )
                    .writeYardExample(
                            "Response structure",
                            new ResponseExampleGenerator(shape, symbolProvider, model).generate()
                    );

            Optional<ExamplesTrait> optionalExamplesTrait = shape.getTrait(ExamplesTrait.class);
            writeExamplesTrait(optionalExamplesTrait);

            return null;
        }

        @Override
        public Void serviceShape(ServiceShape shape) {
            writeAllShapeTraits();
            return null;
        }
    }
}
