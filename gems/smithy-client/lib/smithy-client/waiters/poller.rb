# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      # Abstract poller class which polls a single API operation and inspects
      # the output and/or error for states matching one of its acceptors.
      class Poller
        def initialize(options = {})
          @operation_name = options[:operation_name]
          @acceptors = options[:acceptors]
        end

        def call(client, params)
          @input = params
          request = client.build_request(@operation_name, params)
          request.handlers.remove(Plugins::RaiseResponseErrors::Handler)
          request.handle do |context|
            context[:user_agent_feature_ids] ||= []
            context[:user_agent_feature_ids] << 'WAITER'
            @handler.call(context)
          ensure
            context.config[:user_agent_feature_ids].delete('WAITER')
          end
          response = request.send_request
          status = evaluate_acceptors(response)
          [response, status.to_sym]
        end

        private

        def evaluate_acceptors(response)
          @acceptors.each do |acceptor|
            return acceptor['state'] if acceptor_matches?(acceptor['matcher'], response)
          end
          response.error.nil? ? 'retry' : 'error'
        end

        def acceptor_matches?(matcher, response)
          matcher_type = matcher.keys.first
          send("matches_#{matcher_type}?", matcher[matcher_type], response)
        end

        def matches_output?(path_matcher, response)
          return false if response.data.nil?

          actual = JMESPath.search(path_matcher['path'], response.data)
          equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        # rubocop:disable Naming/MethodName
        def matches_inputOutput?(path_matcher, response)
          return false unless !response.data.nil? && @input

          data = {
            input: @input,
            output: response.data
          }
          actual = JMESPath.search(path_matcher['path'], data)
          equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        def matches_success?(path_matcher, response)
          path_matcher == true ? !response.data.nil? : !response.error.nil?
        end

        def matches_errorType?(path_matcher, response)
          return false if response.error.nil?

          response.error.class.to_s.end_with?("Errors::#{path_matcher}")
        end

        def equal?(actual, expected, comparator)
          send("#{comparator}?", actual, expected)
        end

        def stringEquals?(actual, expected)
          actual == expected
        end

        def booleanEquals?(actual, expected)
          actual.to_s == expected
        end

        def allStringEquals?(actual, expected)
          return false if actual.nil? || actual.empty?

          actual.all? { |value| value == expected }
        end

        def anyStringEquals?(actual, expected)
          return false if actual.nil? || actual.empty?

          actual.any? { |value| value == expected }
        end
        # rubocop:enable Naming/MethodName

        def with_metric (&block)
          Thread.current[:smithy_ruby_user_agent_metric] ||= []
          Thread.current[:smithy_ruby_user_agent_metric] << 'B'
          block.call
        ensure
          Thread.current[:smithy_ruby_user_agent_metric].pop
        end
      end
    end
  end
end
