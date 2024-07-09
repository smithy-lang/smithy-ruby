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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.EnumShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.ServiceShape;
import software.amazon.smithy.model.shapes.Shape;
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
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Generate documentation for a shape.
 */
@SmithyInternalApi
public class ShapeDocumentationGenerator {
    private final Model model;
    private final RubyCodeWriter writer;
    private final SymbolProvider symbolProvider;
    private final Shape shape;

    /**
     * @param model model to generate from
     * @param writer writer to write documentation to
     * @param symbolProvider symbol provider
     * @param shape shape to generate documentation for
     */
    public ShapeDocumentationGenerator(Model model, RubyCodeWriter writer, SymbolProvider symbolProvider, Shape shape) {
        this.writer = writer;
        this.model = model;
        this.symbolProvider = symbolProvider;
        this.shape = shape;
    }

    /**
     * Generate documentation for a shape.
     */
    public void render() {
        shape.accept(new ShapeDocumentationVisitor());
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
        if (optionalTagsTrait.isPresent()) {
            String tags = optionalTagsTrait.get().getValues()
                    .stream().map((tag) -> "\"" + tag + "\"")
                    .collect(Collectors.joining(", "));
            writer.writeDocstring("Tags: [" + tags + "]");
        }
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
        Optional<TagsTrait> optionalTagsTrait =
                shape.getTrait(TagsTrait.class);
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
        writeTagsTrait(optionalTagsTrait);
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
        public Void enumShape(EnumShape shape) {
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
            Optional<TagsTrait> optionalMemberTagsTrait =
                    shape.getMemberTrait(model, TagsTrait.class);
            Optional<UnstableTrait> optionalMemberUnstableTrait =
                    shape.getMemberTrait(model, UnstableTrait.class);

            writeDocumentationTrait(optionalMemberDocumentationTrait);
            Shape target = model.expectShape(shape.getTarget());
            if (target.isEnumShape()) {
                String enumValues = target.asEnumShape().get()
                        .getEnumValues().values().stream()
                        .map((value) -> "\"" + value + "\"")
                        .collect(Collectors.joining(", "));
                writer.writeDocstring("Enum, one of: [" + enumValues + "]");
            }
            writeDeprecatedTrait(optionalMemberDeprecatedTrait);
            writeUnstableTrait(optionalMemberUnstableTrait);
            writeExternalDocumentationTrait(optionalMemberExternalDocumentationTrait);
            writeInternalTrait(optionalMemberInternalTrait);
            writeRecommendedTrait(optionalMemberRecommendedTrait);
            writeSinceTrait(optionalMemberSinceTrait);
            writeTagsTrait(optionalMemberTagsTrait);

            return null;
        }

        @Override
        public Void operationShape(OperationShape shape) {
            // TODO: write out different documentation for eventStream operations!
            writeAllShapeTraits();

            Shape inputShape = model.expectShape(shape.getInputShape());
            String inputShapeName = symbolProvider.toSymbol(inputShape).getName();

            String paramsDocString = """
                    Request parameters for this operation.
                    See {Types::%s#initialize} for available parameters.
                    """.formatted(inputShapeName);
            String optionsDocString = """
                    Request option override of configuration. See {Config#initialize} for available options.
                    Some configurations cannot be overridden.
                    """;

            writer
                    .writeYardParam("Hash | Types::" + inputShapeName, "params", paramsDocString)
                    .writeYardParam("Hash", "options", optionsDocString)
                    .writeYardReturn(Hearth.OUTPUT + "", "")
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
