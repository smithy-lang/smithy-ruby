# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Xml
    describe Codec do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      it 'freezes its reusable workers' do
        codec = described_class.new

        expect(codec.instance_variable_get(:@builder)).to be_frozen
        expect(codec.instance_variable_get(:@parser)).to be_frozen
      end

      it 'reuses the same codec instance across build calls without leaking builder state' do
        codec = described_class.new

        first = codec.build(structure_shape, { string: 'first' })
        second = codec.build(structure_shape, { integer: 123 })

        expect(first).to eq('<Structure><string>first</string></Structure>')
        expect(second).to eq('<Structure><integer>123</integer></Structure>')
      end

      it 'reuses the same codec instance across parse calls' do
        codec = described_class.new

        first = codec.parse(structure_shape, '<Structure><string>first</string></Structure>')
        second = codec.parse(structure_shape, '<Structure><integer>123</integer></Structure>')

        expect(first.to_h).to eq(string: 'first')
        expect(second.to_h).to eq(integer: 123)
      end

      it 'supports concurrent builds on the same codec instance' do
        codec = described_class.new
        builds = 20.times.map do |i|
          Thread.new do
            value = "value-#{i}"
            codec.build(structure_shape, string: value)
          end
        end

        expect(builds.map(&:value)).to eq(
          20.times.map { |i| "<Structure><string>value-#{i}</string></Structure>" }
        )
      end
    end
  end
end
