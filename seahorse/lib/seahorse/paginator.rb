module Seahorse
  class Paginator

    def initialize(input_token:, operation_lambda:, output_token_lambda:, items_lambda:, params:, options:, client:)
      @operation_lambda = operation_lambda
      @input_token = input_token
      @output_token_lambda = output_token_lambda
      @items_lambda = items_lambda
      @params = params
      @options = options
      @client = client
    end

    def pages
      params = @params
      options = @options
      Enumerator.new do |e|
        @prev_token = params[@input_token]
        response = @operation_lambda.call(@client, params, options)
        e.yield(response)
        until last_page?(response)
          params = params.merge(@input_token => @output_token_lambda.call(response))
          response = @operation_lambda.call(@client, params, options)
          e.yield(response)
        end
      end
    end

    def items
      Enumerator.new do |e|
        pages.each do |response|
          # @items field
          @items_lambda.call(response).each do |item|
            e.yield(item)
          end
        end
      end
    end

    private

    def last_page?(response)
      next_token = @output_token_lambda.call(response)
      next_token.nil? || @prev_token == next_token
    end

  end
end
