# frozen_string_literal: true

module Benchmark
  module Gems
    class RailsJson < Benchmark::Gem
      def gem_name
        'rails_json'
      end

      def gem_dir
        'codegen/smithy-ruby-rails-codegen-test/build/smithyprojections/smithy-ruby-rails-codegen-test/railsjson/ruby-codegen/rails_json'
      end

      def client_module_name
        :RailsJson
      end

      def operation_benchmarks
        {
          empty_input_and_empty_output: {
            setup: proc do |client|
              client.stub_responses(:empty_input_and_empty_output, data: {})
              {}
            end,
            test: proc do |client, req|
              client.empty_input_and_empty_output(req)
            end
          },
          endpoint_with_host_label_operation: {
            setup: proc do |_client|
              { label: 'label' }
            end,
            test: proc do |client, req|
              client.endpoint_with_host_label_operation(req)
            end
          },
          document_type_small: {
            setup: proc do |client|
              client.stub_responses(:document_type, data: {})
              {}
            end,
            test: proc do |client, req|
              client.document_type(req)
            end
          },
          document_type_large: {
            setup: proc do |client|
              input = {
                string_value: 'string',
                document_value: [
                  true,
                  'hi',
                  [
                    1,
                    2
                  ],
                  {
                    foo: {
                      baz: [
                        3,
                        4
                      ]
                    }
                  }
                ]
              }
              client.stub_responses(:document_type, data: input)
              input
            end,
            test: proc do |client, req|
              client.document_type(req)
            end
          }
        }
      end
    end
  end
end
