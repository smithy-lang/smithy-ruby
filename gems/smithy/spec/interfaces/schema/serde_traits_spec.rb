# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Schema: Serde Traits', rbs_test: true do
  model = {
    'smithy' => '2.0',
    'shapes' => {
      'smithy.ruby.tests#SerdeService' => {
        'type' => 'service',
        'version' => '2024-01-01',
        'operations' => [{ 'target' => 'smithy.ruby.tests#SerdeOperation' }]
      },
      'smithy.ruby.tests#SerdeOperation' => {
        'type' => 'operation',
        'input' => { 'target' => 'smithy.ruby.tests#SerdeStructure' },
        'output' => { 'target' => 'smithy.ruby.tests#SerdeStructure' }
      },
      'smithy.ruby.tests#SerdeStructure' => {
        'type' => 'structure',
        'traits' => {
          'smithy.api#xmlNamespace' => { 'uri' => 'http://example.com/ns' }
        },
        'members' => {
          'fooBar' => {
            'target' => 'smithy.api#String',
            'traits' => {
              'aws.protocols#ec2QueryName' => 'FooBarMember',
              'smithy.api#jsonName' => 'foo_bar',
              'smithy.api#xmlName' => 'FooBar',
              'smithy.api#xmlAttribute' => {}
            }
          },
          'items' => { 'target' => 'smithy.ruby.tests#SparseList' },
          'mapping' => { 'target' => 'smithy.ruby.tests#SparseMap' }
        }
      },
      'smithy.ruby.tests#SparseList' => {
        'type' => 'list',
        'traits' => {
          'smithy.api#sparse' => {},
          'smithy.api#xmlFlattened' => {}
        },
        'member' => { 'target' => 'smithy.api#String' }
      },
      'smithy.ruby.tests#SparseMap' => {
        'type' => 'map',
        'traits' => { 'smithy.api#sparse' => {} },
        'key' => { 'target' => 'smithy.api#String' },
        'value' => { 'target' => 'smithy.api#String' }
      }
    }
  }

  ['generated schema gem', 'generated schema from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated schema gem'

    context context do
      include_context context, 'SerdeService', model: model

      it 'emits model_name and symbolized serde traits into runtime shapes' do
        member = SerdeService::Schema::SerdeOperationInput.member(:foo_bar)

        expect(member.model_name).to eq('fooBar')
        expect(member.traits).to eq(
          ec2_query_name: 'FooBarMember',
          json_name: 'foo_bar',
          xml_name: 'FooBar',
          xml_attribute: {}
        )
        expect(SerdeService::Schema::SerdeOperationInput.traits).to eq(
          xml_namespace: { 'uri' => 'http://example.com/ns' }
        )
        expect(SerdeService::Schema::SparseList.traits).to eq(
          sparse: {},
          xml_flattened: {}
        )
        expect(SerdeService::Schema::SparseMap.traits).to eq(sparse: {})
      end
    end
  end
end
