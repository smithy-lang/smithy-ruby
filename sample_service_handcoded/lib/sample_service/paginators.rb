module SampleService
  module Paginators

    class ListHighScores

      def initialize(client, params = {}, options = {})
        @params = params
        @options = options
        @client = client
      end

      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]  # codegen
          response = @client.list_high_scores(params, @options) # codegen
          e.yield(response)
          output_token = response.data.next_token # codegen
          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token) # code gen
            response = @client.list_high_scores(params, @options) # code gen
            e.yield(response)
            output_token = response.data.next_token # codegen
          end
        end
      end

      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.data.high_scores.each do |item| # code gen
              e.yield(item)
            end
          end
        end
      end

    end

  end
end
