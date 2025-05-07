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
          begin
            output = client.send(@operation_name, params)
          rescue StandardError => e
            error = e
          end
          output_or_error = output || error
          status = evaluate_acceptors(output, error)
          [output_or_error, status.to_sym]
        end

        private

        def evaluate_acceptors(output, error)
          @acceptors.each do |acceptor|
            return acceptor['state'] if acceptor_matches?(acceptor['matcher'], output, error)
          end
          if error
            'error'
          else
            'retry'
          end
        end

        def acceptor_matches?(matcher, output, error)
          matcher_type = matcher.keys.first
          send("matches_#{matcher_type}?", matcher[matcher_type], output, error)
        end

        def matches_output?(path_matcher, output, error)
          return false unless error.nil?

          actual = JMESPath.search(path_matcher['path'], output)
          equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        def matches_inputOutput?(path_matcher, output, error) # rubocop:disable Naming/MethodName
          return false unless error.nil? && @input

          data = {
            input: @input,
            output: output
          }
          actual = JMESPath.search(path_matcher['path'], data)
          equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        def matches_success?(path_matcher, output, error)
          if path_matcher == true
            !output.nil?
          else
            !error.nil?
          end
        end

        def matches_errorType?(path_matcher, output, error) # rubocop:disable Naming/MethodName
          return false unless output.nil?

          error.class.to_s.include?(path_matcher)
        end

        def equal?(actual, expected, comparator)
          send("#{comparator}?", actual, expected)
        end

        def stringEquals?(actual, expected) # rubocop:disable Naming/MethodName
          actual == expected
        end

        def booleanEquals?(actual, expected) # rubocop:disable Naming/MethodName
          actual.to_s == expected
        end

        def allStringEquals?(actual, expected) # rubocop:disable Naming/MethodName
          return false if actual.nil? || actual.empty?

          actual.all? { |value| value == expected }
        end

        def anyStringEquals?(actual, expected) # rubocop:disable Naming/MethodName
          return false if actual.nil? || actual.empty?

          actual.any? { |value| value == expected }
        end
      end
    end
  end
end
