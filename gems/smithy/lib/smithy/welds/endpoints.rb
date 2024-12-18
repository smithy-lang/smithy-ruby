# frozen_string_literal: true

module Smithy
  module Welds
    # Provides default endpoint builtin/function bindings.
    # TODO : There are many ways we could "register" the base (ie, non-AWS) endpoint builtins/functions
    # I like this since it uses the same extension point that AWS will and makes it easy to remove/replace.
    class Endpoints < Weld
      def self.preprocess(model)
        model['shapes'].select { |_k, s| s['type'] == 'service' }.each_value do |shape|
          add_default_endpoints(shape['traits']) unless shape['traits']['smithy.rules#endpointRuleSet']
        end
      end

      def self.built_in_bindings
        [Vise::Endpoints::BuiltInBinding.new(
          id: 'SDK::Endpoint',
          render_config: proc do |_plan|
            <<~ADD_OPTION
              option(
                :endpoint,
                doc_type: String,
                docstring: "Custom Endpoint"
              )
            ADD_OPTION
          end,
          render_build: proc do |_plan, _operation|
            'config.endpoint'
          end,
          render_test_set: proc do |_plan, _operation, _node|
          end
        )]
      end

      def self.function_bindings
        # TODO: Add all stdlib from:
        # https://github.com/smithy-lang/smithy-ruby/blob/main/codegen/smithy-ruby-codegen/src/main/java/software/amazon/smithy/ruby/codegen/rulesengine/FunctionBinding.java#L49
        [Vise::Endpoints::FunctionBinding.new(
          id: 'isValidHostLabel',
          ruby_method: 'Smithy::Client::EndpointRules::valid_host_label?'
        )]
      end

      def self.add_default_endpoints(service_traits)
        service_traits['smithy.rules#endpointRuleSet'] = default_endpoint_rules
        service_traits['smithy.rules#smithy.rules#endpointTests'] = default_endpoint_tests
      end

      # rubocop:disable Metrics/MethodLength:
      def self.default_endpoint_rules
        JSON.parse(<<~JSON)
          {
            "version": "1.0",
            "parameters": {
                "endpoint": {
                    "type": "string",
                    "builtIn": "SDK::Endpoint",
                    "documentation": "Endpoint"
                }
            },
            "rules": [
                {
                    "conditions": [
                        {
                            "fn": "isSet",
                            "argv": [
                                {
                                    "ref": "endpoint"
                                }
                            ]
                        }
                    ],
                    "endpoint": {
                        "url": "endpoint"
                    },
                    "type": "endpoint"
                },
                {
                    "conditions": [],
                    "error": "Endpoint is not set - you must configure an endpoint.",
                    "type": "error"
                }
            ]
          }
        JSON
      end
      # rubocop:enable Metrics/MethodLength:

      def self.default_endpoint_tests
        # TODO: Add default test cases
        JSON.parse(<<~JSON)
          {
            "version": "1.0",
            "testCases": []
          }
        JSON
      end
    end
  end
end
