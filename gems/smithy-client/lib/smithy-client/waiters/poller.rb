# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      class Poller
        def initialize(options = {})
          @operation_name = options[:operation_name]
          @acceptors = options[:acceptors]
        end

        def call(client, params)
          resp = client.send(@operation_name, params)
          status = evaluate_acceptors(resp)
          [resp, status]
        end

        def evaluate_acceptors(resp)
          @acceptors.each do |acceptor|
            return acceptor['state'] if acceptor_matches?(acceptor['matcher'], resp)
          end

          # If none of the acceptors match and an error was encountered,
          # transition to failure state. Otherwise, transition to retry state.
          if resp.error?
            'error'
          else
            'retry'
          end
        end

        def acceptor_matches?(matcher, resp)
          matcher_type = matcher.keys[0]
          send("matches_#{matcher_type}?", matcher_type, resp)
        end

        def matches_output?(path_matcher, resp)
          return false if resp.error || resp.data.nil?

          actual = JMESPath.search(path_matcher['path'], resp.data)
          is_equal?(actual, expected, path_matcher['comparator'])
        end

        def matches_inputOutput?(path_matcher, resp)
          return false if resp.error

          data = {
            input: input, ### Where do we get this?
            output: resp.data
          }

          actual = JMESPath.search(path_matcher['path'], data)
          is_equal?(actual, expected, path_matcher['comparator'])
        end

        def matches_success?(path_matcher, resp)
          puts "resp is #{resp}"
          if path_matcher['success']
            resp.error.nil?
          else
            resp.error?
          end
        end

        def matches_errorType?(path_matcher, resp)
          return false unless resp.error

          error = path_matcher['errorType'].split('#').last.split('#').first
          error == resp.error
        end

        def is_equal?(actual, expected, comparator)
          case comparator
          when 'stringEquals'
            return actual == expected
          when 'booleanEquals'
            return actual.to_s == expected
          when 'allStringEquals'
            return false if actual.empty?

            actual.each do |value|
              return false if value != expected
            end
            return true
          when 'anyStringEquals'
            return false if actual.empty?

            actual.each do |value|
              return true if value == expected
            end
            return false
          end
        end
      end
    end
  end
end