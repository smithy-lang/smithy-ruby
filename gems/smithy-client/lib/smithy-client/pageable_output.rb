# frozen_string_literal: true

module Smithy
  module Client
    # Raised when calling {PageableOutput#next_page} on a paginator that
    # is on the last page of results. You can call {PageableOutput#last_page?}
    # or {PageableOutput#next_page?} to know if there are more pages.
    class LastPageError < RuntimeError
      # @param [Output] output
      def initialize(output)
        @output = output
        super('unable to fetch next page, end of results reached')
      end

      # @return [Output]
      attr_reader :output
    end

    # Decorates a {Smithy::Client::Output} with paging convenience methods.
    # Most API calls provide paged responses to limit the amount of data returned
    # with each response. To optimize for latency, some APIs may return an
    # inconsistent number of responses per page. You should rely on the values of
    # the `next_page?` method or using enumerable methods such as `each_page` rather
    # than the number of items returned to iterate through results. See below for
    # examples.
    #
    # # Enumerator Methods
    # The simplest way to handle paged response data is to use the built-in
    # `each_page` enumerator on the output object:
    #
    #     weather = Weather::Client.new
    #     weather.list_cities.each_page do |page|
    #       puts page.items.map(&:name)
    #     end
    #
    # This yields one output object per API call made. The SDK retrieves additional
    # pages of data to complete the request.
    #
    # If the operation allows for it, a selected item can be enumerated using
    # `each_item`:
    #
    #     weather = Weather::Client.new
    #     weather.list_cities.each_item do |item|
    #       puts item.name
    #     end
    #
    # # Handling Paged Output Manually
    # To handle paging yourself, use the output's `next_page?` method to verify
    # there are more pages to retrieve, or use the `last_page?` method to verify
    # there are no more pages to retrieve.
    #
    # If there are more pages, use the `next_page` method to retrieve the
    # next page of results, as shown in the following example.
    #
    #     weather = Weather::Client.new
    #
    #     # Get the first page of data
    #     output = weather.list_cities
    #
    #     # Get additional pages
    #     while output.next_page?
    #       output = output.next_page
    #       # Use the response data here...
    #       puts output.items.map(&:name)
    #     end
    #
    module PageableOutput
      # @api private
      attr_accessor :paginator

      # Returns `true` if there are no more results. Calling {#next_page}
      # when this method returns `false` will raise an error.
      # @return [Boolean]
      def last_page?
        return @last_page if @last_page

        @last_page = !truncated?
      end

      # Returns `true` if there are more results. Calling {#next_page} will
      # return the next response.
      # @return [Boolean]
      def next_page?
        return @next_page if @next_page

        @next_page = truncated?
      end

      # @param [Hash] params A hash of additional request params.
      # @return [Output] Returns the next page of results.
      def next_page(params = {})
        raise LastPageError, self if last_page?

        params = next_page_params(params)
        context.client.send(context.operation_name, params)
      end

      # Yields the current and each following output to the given block.
      # @yieldparam [Output] output
      # @return [Enumerable, nil] Returns a new Enumerable if no block is given.
      def each_page(&)
        output = self
        yield(output)
        until output.last_page?
          output = output.next_page
          yield(output)
        end
      end

      # Yields the current and each following item to the given block.
      # @yieldparam [Object] item
      # @return [Enumerable, nil] Returns a new Enumerable if no block is given.
      def each_item(&)
        output = self
        @paginator.items(output.data).each(&)
        until output.last_page?
          output = output.next_page
          @paginator.items(output.data).each(&)
        end
      end

      private

      def truncated?
        next_t = @paginator.next_tokens(data)
        !(next_t.empty? || next_t == @paginator.prev_tokens(context.params))
      end

      def next_page_params(params)
        prev_tokens = @paginator.prev_tokens(context.params)
        # Remove all previous tokens from original params
        # Sometimes a token can be nil and merge would not include it.
        new_params = context.params.except(*prev_tokens)
        new_params.merge!(@paginator.next_tokens(data).merge(params))
      end
    end
  end
end
