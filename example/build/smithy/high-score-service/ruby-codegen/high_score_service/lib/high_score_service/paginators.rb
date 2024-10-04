# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Paginators

    class ListHighScores
      # @param [Client] client
      # @param (see Client#list_high_scores)
      def initialize(client, params = {}, options = {})
        @client = client
        @params = params
        @options = options
      end

      # Iterate all response pages of the list_high_scores operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          output = @client.list_high_scores(params, @options)
          e.yield(output)
          output_token = output.data.next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            output = @client.list_high_scores(params, @options)
            e.yield(output)
            output_token = output.data.next_token
          end
        end
      end

      # Iterate all items from pages in the list_high_scores operation.
      # @return [Enumerator]
      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.data.high_scores.each do |item|
              e.yield(item)
            end
          end
        end
      end
    end

  end
end
