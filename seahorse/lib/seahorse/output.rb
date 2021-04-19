# frozen_string_literal: true

module Seahorse
  class Output
    def initialize(error: nil, data: nil, context: {}, pager: nil)
      @error = error
      @data = data
      @context = context
      @pager = pager
    end

    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Struct, nil]
    attr_accessor :data

    # @return [Hash]
    attr_accessor :context

    # @return [Pager]
    attr_accessor :pager

    def next_page
      return nil unless pager # TODO: Should this raise a LastPageError?

      raise ArgumentError, 'Response must be pageable and have another page available with next_page?' unless next_page?
      pager.next_page
    end

    def next_page?
      return pager && pager.next_token
    end
  end

  class Pager
    def initialize(next_token: nil)
      @next_token = next_token
    end

    attr_accessor :next_token

    attr_accessor :request_next_page

    def next_page
      request_next_page.call
    end

  end
end
