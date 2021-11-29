# frozen_string_literal: true

require 'rails_json'

module RailsJson
  module Stubs
    describe KitchenSinkOperation do
      let(:client) { RailsJson::Client.new(stub_responses: true, endpoint: 'https://example.com')}

      it 'returns a default with recursive values' do
        resp = client.kitchen_sink_operation()

        expect(resp.blob).to eq('blob')
        expect(resp.boolean).to eq(false)
        expect(resp.double).to eq(1.0)
        expect(resp.empty_struct.to_h).to eq({})

        expect(resp.httpdate_timestamp).to be_within(1).of(Time.now)
        expect(resp.iso8601_timestamp).to be_within(1).of(Time.now)
        expect(resp.timestamp).to be_within(1).of(Time.now)
        expect(resp.unix_timestamp).to be_within(1).of(Time.now)

        expect(resp.json_value).to eq('json_value')
        expect(resp.list_of_lists).to eq([["member"]])
        expect(resp.list_of_maps_of_strings).to eq([{"test_key"=>"value"}])
        expect(resp.to_h[:map_of_structs]).to eq({"test_key"=>{value: "value"}})

        expect(resp.simple_struct).to be_a(Types::SimpleStruct)
        expect(resp.simple_struct.value).to eq('value')

        expect(resp.recursive_struct).to be_a(Types::KitchenSink)
        expect(resp.recursive_struct.blob).to eq('blob')
        expect(resp.recursive_struct.recursive_struct).to be_nil

        expect(resp.recursive_map["test_key"]).to be_a(Types::KitchenSink)
        expect(resp.recursive_map["test_key"].blob).to eq('blob')
        expect(resp.recursive_map["test_key"].recursive_struct).to be_nil

        expect(resp.struct_with_location_name).to be_a(Types::StructWithLocationName)
        expect(resp.struct_with_location_name.value).to eq('value')
      end

      it 'returns the stubbed values' do
        t = Time.now.utc
        client.stub_responses(:kitchen_sink_operation,
                              { blob: 'my blob',
                                boolean: true,
                                timestamp: t,
                                simple_struct: {value: 'my value'},
                                recursive_map: { 'test_key' => { blob: 'blob 2' } }
                              }
        )
        resp = client.kitchen_sink_operation()

        expect(resp.blob).to eq('my blob')
        expect(resp.boolean).to eq(true)
        expect(resp.timestamp).to be_within(1).of(t)
        expect(resp.simple_struct.to_h).to eq({value: 'my value'})
        expect(resp.to_h[:recursive_map]).to eq({ 'test_key' => { blob: 'blob 2' } })
      end

      it 'stubs an empty body when given nil' do
        client.stub_responses(:kitchen_sink_operation, { })
        resp = client.kitchen_sink_operation()

        expect(resp.blob).to be_nil
        expect(resp.boolean).to be_nil
        expect(resp.simple_struct).to be_nil
        expect(resp.recursive_map).to be_nil
      end
    end
  end
end
