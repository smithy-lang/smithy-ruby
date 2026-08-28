# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
    describe Codec do
      let(:shape) { double('shape') }

      describe '#build' do
        it 'passes an explicit default timestamp through to the builder' do
          builder = instance_double(Builder, build: '{}')
          allow(Builder).to receive(:new).and_return(builder)

          described_class.new(default_timestamp: 'date-time').build(shape, {})

          expect(Builder).to have_received(:new).with(default_timestamp: 'date-time')
        end
      end

      describe '#parse' do
        it 'passes the configured options through to the parser' do
          parser = instance_double(Parser, parse: {})
          allow(Parser).to receive(:new).and_return(parser)

          described_class.new(json_name: true).parse(shape, '{}')

          expect(Parser).to have_received(:new).with(json_name: true)
        end
      end
    end
  end
end
