# frozen_string_literal: true

require_relative '../spec_helper'

require 'rexml'

module Smithy
  module Xml
    describe Builder do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      def rexml(xml)
        REXML::Document.new(xml).to_s.gsub(/>\s+?</, '><').strip
      end

      it 'returns an empty frame when given a unit shape' do
        ref = Schema::Shapes::ShapeRef.new(shape: Schema::Shapes::Prelude::Unit, location_name: 'unit')
        expect(subject.build(ref, '')).to eq('<unit/>')
      end

      context 'structures' do
        before { allow(Time).to receive(:at).and_return(time) }
        let(:time) { Time.now }
        let(:data) do
          {
            big_decimal: 0.0,
            big_integer: 0,
            blob: 'blob',
            boolean: false,
            byte: 0,
            double: 0.0,
            enum: 'enum',
            float: 0.0,
            int_enum: 0,
            integer: 0,
            list: [],
            long: 0,
            map: {},
            short: 0,
            streaming_blob: 'streaming blob',
            string: 'string',
            structure_list: [],
            structure_map: {},
            timestamp: time,
            union: { string: 'string' }
          }
        end
        let(:expected) do
          {
            'bigDecimal' => 0.0,
            'bigInteger' => 0,
            'blob' => 'YmxvYg==',
            'boolean' => false,
            'byte' => 0,
            'double' => 0.0,
            'enum' => 'enum',
            'float' => 0.0,
            'intEnum' => 0,
            'integer' => 0,
            'list' => [],
            'long' => 0,
            'map' => {},
            'short' => 0,
            'streamingBlob' => 'c3RyZWFtaW5nIGJsb2I=',
            'string' => 'string',
            'structureList' => [],
            'structureMap' => {},
            'timestamp' => time.to_i,
            'union' => { 'string' => 'string' }
          }
        end

        it 'builds structures as a type' do
          type = structure_shape.type.new(data.merge(structure: data))
          bytes = subject.build(structure_shape, type)
          expect(bytes).to eq(rexml(bytes))
        end

        it 'builds structures as a hash' do
          bytes = subject.build(structure_shape, data.merge(structure: data))
          expect(bytes).to eq(rexml(bytes))
        end

        it 'builds structures with xmlName' do
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#xmlName' => 'NewString' }
          }
          data = { string: 'string' }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<NewString>string</NewString>')
        end
      end

      context 'unions' do
        it 'builds unions as a type' do
          union = structure_shape.member(:union).shape.member_type(:string).new(string: 'string')
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(bytes).to include('<union><string>string</string></union>')
        end

        it 'builds unions as a hash' do
          data = { union: { string: 'string' } }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<union><string>string</string></union>')
        end

        it 'builds union unit members as a type' do
          union = structure_shape.member(:union).shape.member_type(:unit).new(unit: Schema::EmptyStructure.new)
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(bytes).to include('<union><unit/></union>')
        end

        it 'builds union unit members as a hash' do
          data = { union: { unit: {} } }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<union><unit/></union>')
        end

        it 'builds a nil union' do
          data = { union: nil }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to eq('<Structure></Structure>')
        end

        it 'builds union members with xmlName' do
          shapes['smithy.ruby.tests#Union']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#xmlName' => 'NewString' }
          }
          data = { union: { string: 'string' } }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<union><NewString>string</NewString></union>')
        end
      end

      context 'lists' do
        it 'builds lists' do
          data = { list: ['string'] }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<list><member>string</member></list>')
        end

        it 'builds lists with nil values' do
          data = { list: [nil] }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<list><member></member></list>')
        end
      end

      context 'maps' do
        it 'builds maps' do
          data = { map: { 'key' => 'value' } }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<map><entry><key>key</key><value>value</value></entry></map>')
        end

        it 'builds maps with nil values' do
          data = { map: { 'key' => nil } }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include('<map><entry><key>key</key><value></value></entry></map>')
        end
      end

      context 'timestamps' do
        it 'builds date-time format by default' do
          time = Time.now.utc
          data = { timestamp: time }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include("<timestamp>#{time.utc.iso8601}</timestamp>")
        end

        it 'builds epoch seconds format' do
          time = Time.now
          shapes['smithy.ruby.tests#Structure']['members']['timestamp']['traits'] = {
            'smithy.api#timestampFormat' => 'epoch-seconds'
          }
          data = { timestamp: time }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include("<timestamp>#{time.to_i}</timestamp>")
        end

        it 'builds http-date format' do
          time = Time.now.utc
          shapes['smithy.ruby.tests#Structure']['members']['timestamp']['traits'] = {
            'smithy.api#timestampFormat' => 'http-date'
          }
          data = { timestamp: time }
          bytes = subject.build(structure_shape, data)
          expect(bytes).to include("<timestamp>#{time.httpdate}</timestamp>")
        end
      end
    end
  end
end
