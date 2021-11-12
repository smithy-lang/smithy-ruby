# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Paginators
    class ListHighScores
      # @param [Client] client
      # @param [Hash] params (see Client#list_high_scores)
      # @param [Hash] options (see Client#list_high_scores)
      def initialize(client, params = {}, options = {})
        @params = params
        @options = options
        @client = client
      end

      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          response = @client.list_high_scores(params, @options)
          e.yield(response)
          output_token = response.next_token
          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            response = @client.list_high_scores(params, @options)
            e.yield(response)
            output_token = response.next_token
          end
        end
      end

      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.high_scores.each do |item|
              e.yield(item)
            end
          end
        end
      end
    end
  end
end
