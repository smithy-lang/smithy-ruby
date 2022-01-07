# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Paginators

    class ListCities
      # @param [Client] client
      # @param [Hash] params (see Client#list_cities)
      # @param [Hash] options (see Client#list_cities)
      def initialize(client, params = {}, options = {})
        @params = params
        @options = options
        @client = client
      end
      # Iterate all response pages of the list_cities operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          response = @client.list_cities(params, @options)
          e.yield(response)
          output_token = response.next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            response = @client.list_cities(params, @options)
            e.yield(response)
            output_token = response.next_token
          end
        end
      end

      # Iterate all items from pages in the list_cities operation.
      # @return [Enumerator]
      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.items.each do |item|
              e.yield(item)
            end
          end
        end
      end
    end

  end
end
