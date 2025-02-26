# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # @api private
      class StubData
        def initialize(operation)
          @rules = operation.output
        end

        def stub(data = {})
          stub = EmptyStub.new(@rules).stub
          apply_data(data, stub)
          stub
        end

        private

        def apply_data(data, stub)
          data = ParamConverter.new(@rules).convert(data)
          ParamValidator.new(@rules).validate!(data, context: 'stub')
          DataApplicator.new(@rules).apply(data, stub)
        end
      end
    end
  end
end
