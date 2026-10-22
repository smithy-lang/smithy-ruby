# frozen_string_literal: true

require_relative '../../../spec_helper'

module Smithy
  module Views
    module Client
      describe ProtocolSpec do
        def assert_query(query, expectations)
          test_case = double(
            'request test', docstrings: [], params: '{}', skip?: false,
                            idempotency_token_trait?: false, query_expect?: true
          )
          values = { 'id' => 'QueryParameters', 'method' => 'GET', 'uri' => '/' }.merge(expectations)
          allow(test_case).to receive(:[]) { |key| values[key] }
          operation_tests = double(
            'operation tests', name: 'operation', request_tests: [test_case], response_tests: [], error_tests: []
          )
          view = described_class.allocate
          allow(view).to receive(:module_name).and_return('QueryTests')
          allow(view).to receive(:all_operation_tests).and_return([operation_tests])
          assertions = view.render[/^ {10}actual_query.*?(?=^ {8}end)/m]
          raise 'Generated query assertions were not found' unless assertions

          endpoint = URI.parse(query.nil? ? 'https://example.com/' : "https://example.com/?#{query}")
          request = double('request', endpoint: endpoint)
          eval(assertions, binding, described_class.template_file) # rubocop:disable Security/Eval
        end

        [
          ['accepts escaped Unicode', 'key=%F0%9F%98%B9', { 'queryParams' => ['key=%F0%9F%98%B9'] }, true],
          ['ignores pair and repeated-value ordering', 'tag=b&tag=a&tag=a',
           { 'queryParams' => ['tag=a', 'tag=a', 'tag=b'] }, true],
          ['allows additional pairs', 'key=expected&key=extra&other=value',
           { 'queryParams' => ['key=expected'] }, true],
          ['rejects a missing repeated pair', 'tag=a', { 'queryParams' => ['tag=a', 'tag=a'] }, false],
          ['rejects a different value', 'key=actual', { 'queryParams' => ['key=expected'] }, false],
          ['rejects equivalent decoded values with incorrect escaping', 'key=a+b',
           { 'queryParams' => ['key=a%20b'] }, false],
          ['distinguishes valueless parameters from empty values', 'key=', { 'queryParams' => ['key'] }, false],
          ['rejects a missing expected pair', nil, { 'queryParams' => ['key=value'] }, false],
          ['requires escaped parameter names', 'escaped%20key=value',
           { 'requireQueryParams' => ['escaped%20key'] }, true],
          ['rejects a missing required parameter', nil, { 'requireQueryParams' => ['key'] }, false],
          ['forbids escaped parameter names', 'escaped%20key=value',
           { 'forbidQueryParams' => ['escaped%20key'] }, false],
          ['allows an absent forbidden parameter', 'other=value', { 'forbidQueryParams' => ['key'] }, true],
          ['handles an empty query', nil, { 'queryParams' => [], 'forbidQueryParams' => ['key'] }, true]
        ].each do |description, query, expectations, valid|
          it description do
            if valid
              expect { assert_query(query, expectations) }.not_to raise_error
            else
              expect { assert_query(query, expectations) }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
            end
          end
        end
      end
    end
  end
end
