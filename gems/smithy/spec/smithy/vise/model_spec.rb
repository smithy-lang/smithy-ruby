# frozen_string_literal: true

module Smithy
  module Vise
    describe Model do
      let(:fixture) do
        path = File.expand_path('../../fixtures/vise/model.json', __dir__)
        JSON.parse(File.read(path))
      end

      subject { described_class.new(fixture) }

      def expect_shape(id, shape)
        expected = subject.shapes[id]
        actual = Model::SHAPE_CLASSES[shape['type']]
        raise "Unknown shape type: #{shape['type']}" unless actual

        expect(expected).to be_a(actual)
      end

      it 'parses the shapes' do
        expect(subject.shapes.each_value).to all(be_a(Shape))
      end

      it 'parses the shape types' do
        fixture['shapes'].each do |id, shape|
          expect_shape(id, shape)
        end
      end
    end
  end
end
