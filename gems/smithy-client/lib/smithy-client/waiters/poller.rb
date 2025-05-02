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
          @input = params
          begin
            resp = client.send(@operation_name, params)
          rescue StandardError => e
            error = e
          end
          output_or_error = resp || error
          status = evaluate_acceptors(resp, error)
          [output_or_error, status]
        end

        private

        def evaluate_acceptors(resp, error)
          @acceptors.each do |acceptor|
            return acceptor['state'] if acceptor_matches?(acceptor['matcher'], resp, error)
          end

          # If none of the acceptors match and an error was encountered,
          # transition to failure state. Otherwise, transition to retry state.
          if error
            'error'
          else
            'retry'
          end
        end

        def acceptor_matches?(matcher, resp, error)
          matcher_type = matcher.keys[0]
          send("matches_#{matcher_type}?", matcher[matcher_type], resp, error)
        end

        def matches_output?(path_matcher, resp, error)
          return false unless error.nil?

          actual = JMESPath.search(underscore_jmespath(path_matcher['path']), resp)
          is_equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        def matches_inputOutput?(path_matcher, resp, error)
          return false unless error.nil? && @input

          data = {
            input: @input,
            output: resp
          }
          actual = JMESPath.search(underscore_jmespath(path_matcher['path']), data)
          is_equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        def matches_success?(path_matcher, resp, error)
          if path_matcher == true
            !resp.nil?
          else
            !error.nil?
          end
        end

        def matches_errorType?(path_matcher, resp, error)
          return false unless resp.nil?

          err = path_matcher.split('#').last.split('#').first
          error.class.to_s.include?(err)
        end

        def is_equal?(actual, expected, comparator)
          case comparator
          when 'stringEquals'
            return actual == expected
          when 'booleanEquals'
            return actual.to_s == expected
          when 'allStringEquals'
            return false if actual.nil? || actual.empty?

            actual.all? { |value| value == expected }
          when 'anyStringEquals'
            return false if actual.nil? || actual.empty?

            actual.any? { |value| value == expected }
          end
        end

        def underscore(string)
          string.gsub(/::/, '/')
                .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                .tr("-", "_")
                .downcase
        end

        def underscore_jmespath(expression)
          expression
            .gsub(' or ', '||')
            .gsub(/(?<![`'])\b\w+\b(?![`'])/) { |str| underscore(str) }
        end
      end
    end
  end
end