# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Stubs data for an operation.
      # @api private
      class StubData
        def initialize(operation)
          @schema = operation.output
        end

        # @param [Hash] data
        # @return [Structure]
        def stub(data = {})
          stub = EmptyStub.new(@schema).stub
          apply_data(data, stub)
          stub
        end

        private

        def apply_data(data, stub)
          data = ParamConverter.new(@schema).convert(data)
          ParamValidator.new(@schema).validate!(data, context: 'stub')
          DataApplicator.new(@schema).apply(data, stub)
        end
      end
    end
  end
end
