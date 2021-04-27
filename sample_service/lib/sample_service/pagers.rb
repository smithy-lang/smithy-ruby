module SampleService
  module Pagers
    class ListHighScores
      def initialize(client, params, options)
        @client = client
        @params = params
        @options = options
      end

      # @return - Enumerable over pages
      def pages
        Enumerator.new do |g|
          params = @params
          last_token = params[:next_token]
          next_token = params[:next_token]
          loop do
            params = params.merge(next_token: next_token)
            resp = client.list_high_scores(params, options)
            g.yeild resp
            break if resp.data.next_token && resp.data.next_token != params.next_token # check last token
          end
        end
      end

      # @return - Enumerable over items
      def items
        Enumerator.new do |g|
          pages.each do |resp|
            resp.data.items do |i|
              g.yield i
            end
          end
        end
      end
    end
  end
end
