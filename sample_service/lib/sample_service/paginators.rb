module SampleService
  module Paginators

    class ListHighScores
      include Seahorse::Paginator

      def merge_next_token(params, response)
        # code gen next token from output
        params.merge(next_token: output_token_path(response))
      end

      def call_operation(client, params, options)
        # code gen operation name
        client.list_high_scores(params, options)
      end

      def output_token_path(response)
        # code gen path to output token from response
        response.data.next_token
      end

      def items_path(response)
        # code gen path to items from response
        response.data.high_scores
      end

      def input_token(params)
        # code gen path to input token from params
        params[:next_token]
      end

      def page_size(params)
        # code gen path to page size from params
        params[:max_results]
      end

    end

  end
end
