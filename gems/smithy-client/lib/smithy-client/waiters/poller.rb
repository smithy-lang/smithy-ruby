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
          # TODO: make build_input public and update this line
          input = client.send(:build_input, @operation_name, params)
          input.handlers.remove(Plugins::RaiseResponseErrors::Handler)
          output = input.send_request
          status = evaluate_acceptors(output)
          [output, status.to_sym]
        end

        private

        def evaluate_acceptors(output)
          @acceptors.each do |acceptor|
            return acceptor['state'] if acceptor_matches?(acceptor['matcher'], output)
          end
          output.error.nil? ? 'retry' : 'error'
        end

        def acceptor_matches?(matcher, output)
          matcher_type = matcher.keys.first
          send("matches_#{matcher_type}?", matcher[matcher_type], output)
        end

        def matches_output?(path_matcher, output)
          return false if output.data.nil?

          actual = JMESPath.search(path_matcher['path'], output.data)
          equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        # rubocop:disable Naming/MethodName
        def matches_inputOutput?(path_matcher, output)
          return false unless !output.data.nil? && @input

          data = {
            input: @input,
            output: output.data
          }
          actual = JMESPath.search(path_matcher['path'], data)
          equal?(actual, path_matcher['expected'], path_matcher['comparator'])
        end

        def matches_success?(path_matcher, output)
          path_matcher == true ? !output.data.nil? : !output.error.nil?
        end

        def matches_errorType?(path_matcher, output)
          return false if output.error.nil?

          output.error.class.to_s.end_with?("Errors::#{path_matcher}")
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
      end
    end
  end
end
