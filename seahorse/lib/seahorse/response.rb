# frozen_string_literal: true

module Seahorse
  class Response

    def initialize(error: nil, data: nil, metadata: {})
      @error = error
      @data = data
      @metadata = metadata
    end

    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Hash, nil]
    attr_accessor :data

    # @return [Hash]
    attr_accessor :metadata

    def [](key)
      case key
      when :error then error
      when :data then data
      when :metadata then metadata
      else
        raise ArgumentError, 'invalid key, expected :error, :data, ' \
          "or :metadata, got #{key.inspect}"
      end
    end

    def to_hash
      {
        error: error,
        data: data,
        metadata: metadata,
      }
    end
    alias to_h to_hash

  end
end
