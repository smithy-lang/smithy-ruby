# frozen_string_literal: true

module Smithy
  module Welds

    # Provides default endpoint builtin/function bindings.
    class Endpoints < Weld
      def self.built_in_bindings
        [Vise::Endpoints::BuiltInBinding.new(
          id: 'SDK::Endpoint',
          render_config: proc do |_plan|

          end,
          render_build: proc do |_plan, _operation|

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
    end
  end
end
