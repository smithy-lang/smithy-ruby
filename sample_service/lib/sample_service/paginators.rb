module SampleService
  # @api private
  module Paginators

    class ListHighScores
      include Enumerable

      def initialize(params = {}, options = {}, client:)
        @params = params
        @options = options
        @client = client
      end

      def each(&block)
        # Enumerator.new do |e|
          @prev_token = input_token(@params)
          response = @client.list_high_scores(@params, @options)
          yield(response)
          until last_page?(response)
            @params = @params.merge(next_token: output_token(response))
            response = @client.list_high_scores(@params, @options)
            yield(response)
          end
        # end
      end

      # def each_item
      #   Enumerator.new do |e|
      #     each_page do |page|
      #       # @items field
      #       page.data.high_scores do |item|
      #         e.yield(item)
      #       end
      #     end
      #   end
      # end

      private

      def output_token(response)
        # code gen path to output token from response
        response.data.next_token
      end

      def input_token(params)
        # code gen path to input token from params
        params[:next_token]
      end

      def last_page?(response)
        next_token = output_token(response)
        next_token.nil? || @prev_token == next_token
      end

    end

  end
end
