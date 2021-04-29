module Seahorse
  module Paginator

    def initialize(client, params = {}, options = {})
      @client = client
      @params = params
      @options = options
    end

    def pages
      params = @params
      options = @options
      Enumerator.new do |e|
        @prev_token = input_token(params)
        response = call_operation(@client, params, options)
        e.yield(response)
        until last_page?(response)
          params = merge_next_token(params, response)
          response = call_operation(@client, params, options)
          e.yield(response)
        end
      end
    end

    def items
      Enumerator.new do |e|
        pages.each do |response|
          # @items field
          items_path(response).each do |item|
            e.yield(item)
          end
        end
      end
    end

    private

    def last_page?(response)
      next_token = output_token_path(response)
      next_token.nil? || @prev_token == next_token
    end

  end
end
