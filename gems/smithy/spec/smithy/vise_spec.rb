# frozen_string_literal: true

module Smithy
  describe Vise do
    let(:fixture) do
      path = File.expand_path('../fixtures/vise/model.json', __dir__)
      JSON.parse(File.read(path))
    end

    describe Vise::Model do
      subject { described_class.new(fixture) }

      def expect_shape(id, shape)
        expected = subject.shapes[id]
        actual = Vise::Model::SHAPE_CLASSES[shape['type']]
        raise "Unknown shape type: #{shape['type']}" unless actual

        expect(expected).to be_a(actual)
      end

      it 'parses the shapes' do
        expect(subject.shapes.each_value).to all(be_a(Vise::Shape))
      end

      it 'parses the shape types' do
        fixture['shapes'].each do |id, shape|
          expect_shape(id, shape)
        end
      end

      describe '#service' do
        it 'finds the service shape' do
          expected = fixture['shapes'].select { |_, shape| shape['type'] == 'service' }
          actual = subject.service
          expect(actual.id).to eq(expected.keys.first)
        end
      end

      describe '#operations' do
        it 'returns a complete set of operations' do
          expected =
            fixture['shapes']
            .select { |_, shape| shape['type'] == 'operation' }
            .reject { |id, _| id.include?('OrphanedOperation') }
          actual = subject.operations
          expect(actual.keys).to match_array(expected.keys)
        end
      end
    end

    # TODO: Add more specs for subclasses
  end
end
