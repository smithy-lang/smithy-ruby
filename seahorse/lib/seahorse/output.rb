# frozen_string_literal: true

module Seahorse
  class Output
    def initialize(error: nil, data: nil)
      @error = error
      @data = data
    end

    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Struct, nil]
    attr_accessor :data
  end
end
