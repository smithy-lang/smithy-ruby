# frozen_string_literal: true

module Seahorse
  class Output
    def initialize(error: nil, data: nil, context: nil)
      @error = error
      @data = data
      @context = context
    end

    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Struct, nil]
    attr_accessor :data

    # @return [Context]
    attr_accessor :context
  end
end
