# frozen_string_literal: true

module Smithy
  module Vise
    module Endpoints
      # Endpoint BuiltInBinding
      class FunctionBinding
        def initialize(id:, ruby_method:)
          @id = id
          @ruby_method = ruby_method
        end

        attr_reader :id, :ruby_method
      end
    end
  end
end
