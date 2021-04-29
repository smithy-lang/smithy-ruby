module SampleService
  module Paginators

    class ListHighScores
      def initialize(client, params = {}, options = {})
        @client = client
        @params = params
        @options = options
      end

      def pages
        Seahorse::Paginator.new(
          params: @params,
          options: @options,
          client: @client,
          operation_lambda: ->(client, params, options) { client.list_high_scores(params, options) },
          output_token_lambda: ->(response) { response.data.next_token },
          items_lambda: ->(response) { response.data.high_scores },
          input_token: :next_token
        ).pages
      end

    end

  end
end
