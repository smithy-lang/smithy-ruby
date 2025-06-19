# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: EndpointProvider', rbs_test: true do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_context context, 'EndpointDefaults', fixture: 'endpoint_tests/default-values'

      subject { EndpointDefaults::EndpointProvider.new }

      describe '#resolve' do
        it 'resolves the endpoint' do
          params = EndpointDefaults::EndpointParameters.new(bar: 'bar', baz: 'baz')

          endpoint = subject.resolve(params)
          expect(endpoint).to be_a(Smithy::Client::EndpointRules::Endpoint)
          expect(endpoint.uri).to eq('https://example.com/baz')
        end

        it 'raises errors from rules' do
          params = EndpointDefaults::EndpointParameters.new(bar: nil, baz: 'baz')
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, 'endpoint error')
        end
      end
    end
  end
end
