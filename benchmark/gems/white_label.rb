# frozen_string_literal: true

module Benchmark
  module Gems
    class WhiteLabel < Benchmark::Gem

      def gem_name
        'white_label'
      end

      def gem_dir
        'codegen/projections/white_label'
      end

      def client_module_name
        :WhiteLabel
      end

      def operation_benchmarks
        {
          kitchen_sink_small: {
            setup: proc do |client|
              client.stub_responses(:kitchen_sink, data: {})
              {string: "test string"}
            end,
            test: proc do |client, req|
              client.kitchen_sink(req)
            end
          }
        }
      end

    end
  end
end
