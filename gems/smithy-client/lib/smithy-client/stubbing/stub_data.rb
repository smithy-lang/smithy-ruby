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

        # @param [Hash] params
        # @return [Structure]
        def stub(params = {})
          stub = EmptyStub.new(@schema).stub
          data = ParamConverter.new(@schema, convert_structures: false).convert(params)
          ParamValidator.new(@schema, validate_required: false).validate!(data, context: 'stub')
          DataApplicator.new(@schema).apply(data, stub)
          stub
        end
      end
    end
  end
end
