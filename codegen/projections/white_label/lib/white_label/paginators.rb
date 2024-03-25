# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Paginators

    class Operation____PaginatorsTestWithBadNames
      # @param [Client] client
      # @param (see Client#operation____paginators_test_with_bad_names)
      def initialize(client, params = {}, options = {})
        @client = client
        @params = params
        @options = options
      end

      # Iterate all response pages of the operation____paginators_test_with_bad_names operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:member___next_token]
          output = @client.operation____paginators_test_with_bad_names(params, @options)
          e.yield(output)
          output_token = output.data.member___wrapper&.member___123next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(member___next_token: output_token)
            output = @client.operation____paginators_test_with_bad_names(params, @options)
            e.yield(output)
            output_token = output.data.member___wrapper&.member___123next_token
          end
        end
      end

      # Iterate all items from pages in the operation____paginators_test_with_bad_names operation.
      # @return [Enumerator]
      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.data.member___items.each do |item|
              e.yield(item)
            end
          end
        end
      end
    end

    class PaginatorsTest
      # @param [Client] client
      # @param (see Client#paginators_test)
      def initialize(client, params = {}, options = {})
        @client = client
        @params = params
        @options = options
      end

      # Iterate all response pages of the paginators_test operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          output = @client.paginators_test(params, @options)
          e.yield(output)
          output_token = output.data.next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            output = @client.paginators_test(params, @options)
            e.yield(output)
            output_token = output.data.next_token
          end
        end
      end
    end

    class PaginatorsTestWithItems
      # @param [Client] client
      # @param (see Client#paginators_test_with_items)
      def initialize(client, params = {}, options = {})
        @client = client
        @params = params
        @options = options
      end

      # Iterate all response pages of the paginators_test_with_items operation.
      # @return [Enumerator]
      def pages
        params = @params
        Enumerator.new do |e|
          @prev_token = params[:next_token]
          output = @client.paginators_test_with_items(params, @options)
          e.yield(output)
          output_token = output.data.next_token

          until output_token.nil? || @prev_token == output_token
            params = params.merge(next_token: output_token)
            output = @client.paginators_test_with_items(params, @options)
            e.yield(output)
            output_token = output.data.next_token
          end
        end
      end

      # Iterate all items from pages in the paginators_test_with_items operation.
      # @return [Enumerator]
      def items
        Enumerator.new do |e|
          pages.each do |page|
            page.data.items.each do |item|
              e.yield(item)
            end
          end
        end
      end
    end

  end
end
