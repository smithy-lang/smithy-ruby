# frozen_string_literal: true

module Benchmark
  module Gems
    class RailsJson < Benchmark::Gem

      def gem_name
        'rails_json'
      end

      def client_module_name
        :RailsJson
      end

      def operation_benchmarks
        {
          empty_operation: {
            setup: proc do |client|
              {}
            end,
            test: proc do |client, req|
              client.empty_operation(req)
            end
          },
          endpoint_with_host_label_operation: {
            setup: proc do |client|
              {label_member: 'label'}
            end,
            test: proc do |client, req|
              client.endpoint_with_host_label_operation(req)
            end
          },
          kitchen_sink_small: {
            setup: proc do |client|
              client.stub_responses(:kitchen_sink_operation, [{}])
              {}
            end,
            test: proc do |client, req|
              client.kitchen_sink_operation(req)
            end
          },
          kitchen_sink_large: {
            setup: proc do |client|
              kitchen_sink = {
                blob: 'Blob',
                boolean: false,
                double: 1.0,
                empty_struct: { },
                float: 1.0,
                httpdate_timestamp: Time.now,
                integer: 1,
                iso8601_timestamp: Time.now,
                json_value: 'JsonValue',
                list_of_lists: [
                  [
                    'member'
                  ]
                ],
                list_of_maps_of_strings: [
                  {
                    'key' => 'value'
                  }
                ],
                list_of_structs: [
                  {
                    value: 'Value'
                  }
                ],
                long: 1,
                recursive_list: [
                  {
                    blob: 'Blob',
                    boolean: false,
                    double: 1.0,
                    float: 1.0,
                    httpdate_timestamp: Time.now,
                    integer: 1,
                    iso8601_timestamp: Time.now,
                    json_value: 'JsonValue',
                    long: 1,
                    string: 'String',
                    struct_with_location_name: {
                      value: 'Value'
                    },
                    timestamp: Time.now,
                    unix_timestamp: Time.now
                  }
                ],
                string: 'String',
                timestamp: Time.now,
                unix_timestamp: Time.now
              }
              client.stub_responses(:kitchen_sink_operation, [kitchen_sink])
              kitchen_sink
            end,
            test: proc do |client, req|
              client.kitchen_sink_operation(req)
            end
          }
        }
      end

    end
  end
end
