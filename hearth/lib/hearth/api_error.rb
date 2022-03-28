# frozen_string_literal: true

module Hearth
  # Base class for errors returned from an API. This excludes networking
  # errors and errors generated on the client-side.
  class ApiError < StandardError
    def initialize(error_code:, metadata:, message: nil)
      @error_code = error_code
      @metadata = metadata
      super(message)
    end

    # @return [String]
    attr_reader :error_code

    # @return [Hash]
    attr_reader :metadata
  end
end
