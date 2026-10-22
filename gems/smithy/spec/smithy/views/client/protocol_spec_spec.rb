# frozen_string_literal: true

require 'open3'
require_relative '../../../spec_helper'

module Smithy
  module Views
    module Client
      describe ProtocolSpec do
        it 'generates specs that accept valid queries and reject invalid queries' do
          cases = [
            ['EscapedUnicode', 'key=%F0%9F%98%B9', { 'queryParams' => ['key=%F0%9F%98%B9'] }, 'passed'],
            ['ReorderedPairs', 'tag=b&tag=a&tag=a&extra=value',
             { 'queryParams' => ['tag=a', 'tag=a', 'tag=b'] }, 'passed'],
            ['MissingRepeatedPair', 'tag=a', { 'queryParams' => ['tag=a', 'tag=a'] }, 'failed'],
            ['WrongEscaping', 'key=a+b', { 'queryParams' => ['key=a%20b'] }, 'failed'],
            ['RequiredKey', 'escaped%20key=value', { 'requireQueryParams' => ['escaped%20key'] }, 'passed'],
            ['MissingRequiredKey', nil, { 'requireQueryParams' => ['key'] }, 'failed'],
            ['ForbiddenKey', 'escaped%20key=value', { 'forbidQueryParams' => ['escaped%20key'] }, 'failed'],
            ['AbsentForbiddenKey', nil, { 'forbidQueryParams' => ['key'] }, 'passed']
          ]
          model = JSON.load_file(File.expand_path('../../../fixtures/weather/model.json', __dir__))
          operation = model['shapes']['smithy.ruby.tests#GetCurrentTime']
          operation['traits']['smithy.test#httpRequestTests'] = cases.map do |id, query, expectations, _status|
            {
              'id' => id, 'method' => 'GET', 'uri' => '/',
              'host' => query ? "example.com/?#{query}" : 'example.com/'
            }.merge(expectations)
          end
          plan = ::SpecHelper.generate_gem('QueryTests', :client, model: model)
          spec_path = "#{plan.destination_root}/spec/#{plan.gem_name}/protocol_spec.rb"
          output, = Open3.capture3(Gem.ruby, '-S', 'bundle', 'exec', 'rspec', spec_path, '--format', 'json')
          examples = JSON.parse(output).fetch('examples')

          expect(examples.to_h { |example| [example['description'], example['status']] })
            .to eq(cases.to_h { |id, _query, _expectations, status| [id, status] })
          examples.select { |example| example['status'] == 'failed' }.each do |example|
            expect(example.dig('exception', 'class')).to eq('RSpec::Expectations::ExpectationNotMetError')
          end
        ensure
          ::SpecHelper.cleanup_gem(plan)
        end
      end
    end
  end
end
