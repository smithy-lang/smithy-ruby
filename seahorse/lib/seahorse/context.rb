# frozen_string_literal: true

module Seahorse
  class Context
    def initialize(metadata = {})
      @request = metadata.delete(:request)
      @response = metadata.delete(:response)
      @params = metadata.delete(:params)
      @logger = metadata.delete(:logger)
      @metadata = metadata
    end

    # TODO: Document methods
    attr_reader :request
    attr_reader :response
    attr_reader :params
    attr_reader :logger
    attr_reader :metadata

  end
end
