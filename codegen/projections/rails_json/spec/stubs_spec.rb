# frozen_string_literal: true

require 'rails_json'

module RailsJson
  module Stubs
    describe KitchenSinkOperation do
      let(:client) do
        RailsJson::Client.new(
          stub_responses: true,
          endpoint: 'https://example.com'
        )
      end

      it 'returns a default with recursive values' do
        resp = client.kitchen_sink_operation

        expect(resp.data.blob).to eq('blob')
        expect(resp.data.boolean).to eq(false)
        expect(resp.data.double).to eq(1.0)
        expect(resp.data.empty_struct.to_h).to eq({})

        expect(resp.data.httpdate_timestamp).to be_within(1).of(Time.now)
        expect(resp.data.iso8601_timestamp).to be_within(1).of(Time.now)
        expect(resp.data.timestamp).to be_within(1).of(Time.now)
        expect(resp.data.unix_timestamp).to be_within(1).of(Time.now)

        expect(resp.data.json_value).to eq('json_value')
        expect(resp.data.list_of_lists).to eq([['member']])
        expect(resp.data.list_of_maps_of_strings).to eq([{ 'key' => 'value' }])
        expect(resp.data.to_h[:map_of_structs])
          .to eq({ 'key' => { value: 'value' } })

        expect(resp.data.simple_struct).to be_a(Types::SimpleStruct)
        expect(resp.data.simple_struct.value).to eq('value')

        expect(resp.data.recursive_struct).to be_a(Types::KitchenSink)
        expect(resp.data.recursive_struct.blob).to eq('blob')
        expect(resp.data.recursive_struct.recursive_struct).to be_nil

        expect(resp.data.recursive_map['key']).to be_a(Types::KitchenSink)
        expect(resp.data.recursive_map['key'].blob).to eq('blob')
        expect(resp.data.recursive_map['key'].recursive_struct).to be_nil

        expect(resp.data.struct_with_location_name)
          .to be_a(Types::StructWithLocationName)
        expect(resp.data.struct_with_location_name.value).to eq('value')
      end

      it 'returns the stubbed values' do
        t = Time.now.utc
        client.stub_responses(
          :kitchen_sink_operation,
          data: {
            blob: 'my blob',
            boolean: true,
            timestamp: t,
            simple_struct: { value: 'my value' },
            recursive_map: { 'key' => { blob: 'blob 2' } }
          }
        )
        resp = client.kitchen_sink_operation

        expect(resp.data.blob).to eq('my blob')
        expect(resp.data.boolean).to eq(true)
        expect(resp.data.timestamp).to be_within(1).of(t)
        expect(resp.data.simple_struct.to_h).to eq({ value: 'my value' })
        expect(resp.data.to_h[:recursive_map])
          .to eq({ 'key' => { blob: 'blob 2' } })
      end

      it 'stubs an empty body when given empty hash' do
        client.stub_responses(:kitchen_sink_operation, data: {})
        resp = client.kitchen_sink_operation

        expect(resp.data.blob).to be_nil
        expect(resp.data.boolean).to be_nil
        expect(resp.data.simple_struct).to be_nil
        expect(resp.data.recursive_map).to be_nil
      end

      it 'stubs an error' do
        client.stub_responses(
          :kitchen_sink_operation,
          error: {
            class: RailsJson::Errors::ErrorWithMembers,
            data: { code: 'code', message: 'message' }
          }
        )

        begin
          client.kitchen_sink_operation
        rescue RailsJson::Errors::ApiError => e
          expect(e).to be_a(RailsJson::Errors::ErrorWithMembers)
          expect(e.data.code).to eq('code')
          expect(e.data.message).to eq('message')
        end
      end
    end
  end
end
