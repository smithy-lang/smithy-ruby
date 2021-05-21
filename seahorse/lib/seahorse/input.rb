# frozen_string_literal: true

module Seahorse
  class Input
    def initialize(params: nil, data: nil)
      @params = params
      @data = data
    end

    # @return [Hash]
    attr_accessor :params

    # @return [InputType]
    attr_accessor :data
  end
end
