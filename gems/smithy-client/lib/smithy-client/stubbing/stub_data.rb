# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Stubs data for an operation.
      # @api private
      class StubData
        def initialize(operation)
          @output = operation.output
        end

        # @param [Hash] params
        # @return [Structure]
        def stub(params = {})
          stub = EmptyStub.new(@output).stub
          data = ParamConverter.new(@output).convert(params)
          ParamValidator.new(@output, validate_required: false).validate!(data, context: 'stub')
          DataApplicator.new(@output).apply(data, stub)
          stub
        end
      end
    end
  end
end
