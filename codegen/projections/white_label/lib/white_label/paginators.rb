# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Paginators

    class Operation____PaginatorsTestWithBadNames
      # @param [Client] client
      # @param [Hash] params (see Client#operation____paginators_test_with_bad_names)
      # @param [Hash] options (see Client#operation____paginators_test_with_bad_names)
      def initialize(client, params = {}, options = {})
        @params = params
        @options = options
        @client = client
      end
      # Iterate all response pages of the operation____paginators_test_with_bad_names operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:member____next_token]
          response = @client.operation____paginators_test_with_bad_names(params, @options)
          e.yield(response)
          output_token = response.member____wrapper&.member____123next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(member____next_token: output_token)
            response = @client.operation____paginators_test_with_bad_names(params, @options)
            e.yield(response)
            output_token = response.member____wrapper&.member____123next_token
          end
        end
      end

      # Iterate all items from pages in the operation____paginators_test_with_bad_names operation.
      # @return [Enumerator]
      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.member____items.each do |item|
              e.yield(item)
            end
          end
        end
      end
    end

    class PaginatorsTest
      # @param [Client] client
      # @param [Hash] params (see Client#paginators_test)
      # @param [Hash] options (see Client#paginators_test)
      def initialize(client, params = {}, options = {})
        @params = params
        @options = options
        @client = client
      end
      # Iterate all response pages of the paginators_test operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          response = @client.paginators_test(params, @options)
          e.yield(response)
          output_token = response.next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            response = @client.paginators_test(params, @options)
            e.yield(response)
            output_token = response.next_token
          end
        end
      end
    end

    class PaginatorsTestWithItems
      # @param [Client] client
      # @param [Hash] params (see Client#paginators_test_with_items)
      # @param [Hash] options (see Client#paginators_test_with_items)
      def initialize(client, params = {}, options = {})
        @params = params
        @options = options
        @client = client
      end
      # Iterate all response pages of the paginators_test_with_items operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          response = @client.paginators_test_with_items(params, @options)
          e.yield(response)
          output_token = response.next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            response = @client.paginators_test_with_items(params, @options)
            e.yield(response)
            output_token = response.next_token
          end
        end
      end

      # Iterate all items from pages in the paginators_test_with_items operation.
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
