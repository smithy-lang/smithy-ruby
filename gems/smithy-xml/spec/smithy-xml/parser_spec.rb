# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Xml
    describe Parser do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      it 'returns an empty structure when given a unit shape' do
        expect(subject.parse(Schema::Shapes::Prelude::Unit, '')).to be_a(Schema::EmptyStructure)
      end

      context 'structures' do
        before { allow(Time).to receive(:at).and_return(time) }
        let(:time) { Time.now }
        let(:data) do
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
            'timestamp' => time,
            'union' => { 'string' => 'string' }
          }
        end
        let(:expected) do
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

        it 'parses structures' do
          bytes = <<~XML
            <Structure>
              <bigDecimal>0.0</bigDecimal>
              <bigInteger>0</bigInteger>
              <blob>YmxvYg==</blob>
              <boolean>false</boolean>
              <byte>0</byte>
              <double>0.0</double>
              <enum>enum</enum>
              <float>0.0</float>
              <intEnum>0</intEnum>
              <integer>0</integer>
              <list/>
              <long>0</long>
              <map/>
              <short>0</short>
              <streamingBlob>c3RyZWFtaW5nIGJsb2I=</streamingBlob>
              <string>string</string>
              <structureList/>
              <structureMap/>
              <timestamp>#{time.to_i}</timestamp>
              <union>
                <string>string</string>
              </union>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(expected)
        end

        it 'parses structures with xmlName' do
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#xmlName' => 'NewString' }
          }
          bytes = <<~XML
            <Structure>
              <NewString>string</NewString>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(string: 'string')
        end
      end

      context 'unions' do
        it 'parses unions' do
          bytes = <<~XML
            <Structure>
              <union>
                <string>string</string>
              </union>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { string: 'string' })
        end

        it 'parses unit members' do
          bytes = <<~XML
            <Structure>
              <union>
                <unit/>
              </union>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { unit: {} })
        end

        it 'parses nil unions' do
          bytes = <<~XML
            <Structure>
              <union/>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: {})
        end

        it 'parses unknown members' do
          bytes = <<~XML
            <Structure>
              <union>
                <someThing>someValue</someThing>
              </union>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { unknown: { 'someThing' => 'someValue' } })
        end
      end

      context 'lists' do
        it 'parses lists' do
          bytes = <<~XML
            <Structure>
              <list>
                <member>string</member>
              </list>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: ['string'])
        end

        it 'parses lists with nil values' do
          bytes = <<~XML
            <Structure>
              <list>
                <member/>
              </list>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: [''])
        end
      end

      context 'maps' do
        it 'parses maps' do
          bytes = <<~XML
            <Structure>
              <map>
                <entry>
                  <key>key</key>
                  <value>value</value>
                </entry>
              </map>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => 'value' })
        end

        it 'parses maps with nil values' do
          bytes = <<~XML
            <Structure>
              <map>
                <entry>
                  <key>key</key>
                  <value/>
                </entry>
              </map>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => '' })
        end
      end

      context 'floats' do
        it 'parses infinity' do
          bytes = <<~XML
            <Structure>
              <float>Infinity</float>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(float: Float::INFINITY)
        end

        it 'parses negative infinity' do
          bytes = <<~XML
            <Structure>
              <float>-Infinity</float>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(float: -Float::INFINITY)
        end

        it 'parses NaN' do
          bytes = <<~XML
            <Structure>
              <float>NaN</float>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(float: Float::NAN)
        end
      end

      context 'timestamps' do
        before { allow(Time).to receive(:at).and_return(time) }
        let(:time) { Time.now }

        it 'parses epoch seconds' do
          bytes = <<~XML
            <Structure>
              <timestamp>#{time.to_i}</timestamp>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(timestamp: time)
        end

        it 'parses date-time format' do
          bytes = <<~XML
            <Structure>
              <timestamp>#{time.utc.iso8601}</timestamp>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(timestamp: time)
        end

        it 'parses http-date format' do
          bytes = <<~XML
            <Structure>
              <timestamp>#{time.utc.httpdate}</timestamp>
            </Structure>
          XML
          expect(subject.parse(structure_shape, bytes).to_h).to eq(timestamp: time)
        end

        it 'handles unrecognized timestamp formats' do
          bytes = <<~XML
            <Structure>
              <timestamp>unrecognized format</timestamp>
            </Structure>
          XML
          expect { subject.parse(structure_shape, bytes) }.to raise_error(/unhandled timestamp format/)
        end
      end
    end
  end
end
