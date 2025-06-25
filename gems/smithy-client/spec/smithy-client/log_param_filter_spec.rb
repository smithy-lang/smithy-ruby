# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe LogParamFilter do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
      let(:service_shape) { sample_client.const_get(:Schema).const_get(:SampleSchema) }
      let(:input) { service_shape.operation(:operation).input }

      describe '#filter' do
        it 'filters sensitive structures as a hash' do
          shapes['smithy.ruby.tests#SensitiveStructure'] = {
            'type' => 'structure',
            'members' => { 'string' => { 'target' => 'smithy.api#String' } },
            'traits' => { 'smithy.api#sensitive' => {} }
          }
          shapes['smithy.ruby.tests#Structure']['members']['sensitiveStructure'] = {
            'target' => 'smithy.ruby.tests#SensitiveStructure'
          }

          filtered = subject.filter(input, { sensitive_structure: { string: 'sensitive' } })
          expect(filtered).to eq(sensitive_structure: '[FILTERED]')
        end

        it 'filters sensitive structures as a type' do
          shapes['smithy.ruby.tests#SensitiveStructure'] = {
            'type' => 'structure',
            'members' => { 'string' => { 'target' => 'smithy.api#String' } },
            'traits' => { 'smithy.api#sensitive' => {} }
          }
          shapes['smithy.ruby.tests#Structure']['members']['sensitiveStructure'] = {
            'target' => 'smithy.ruby.tests#SensitiveStructure'
          }

          sensitive_structure = input.shape.member(:sensitive_structure).shape.type
          filtered = subject.filter(input, { sensitive_structure: sensitive_structure.new(string: 'sensitive') })
          expect(filtered).to eq(sensitive_structure: '[FILTERED]')
        end

        it 'filters complex sensitive structure members' do
          shapes['smithy.ruby.tests#List']['traits'] = { 'smithy.api#sensitive' => {} }
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sensitive' => {} }
          shapes['smithy.ruby.tests#Union']['traits'] = { 'smithy.api#sensitive' => {} }

          filtered = subject.filter(
            input,
            { list: ['sensitive'], map: { 'key' => 'sensitive' }, union: { string: 'sensitive' } }
          )
          expect(filtered).to eq(list: '[FILTERED]', map: '[FILTERED]', union: '[FILTERED]')
        end

        it 'filters scalar sensitive structure members' do
          shapes['smithy.ruby.tests#String'] = { 'type' => 'string', 'traits' => { 'smithy.api#sensitive' => {} } }
          shapes['smithy.ruby.tests#Structure']['members']['string']['target'] = 'smithy.ruby.tests#String'
          filtered = subject.filter(input, { string: 'sensitive' })
          expect(filtered).to eq(string: '[FILTERED]')
        end

        it 'filters sensitive lists' do
          shapes['smithy.ruby.tests#List']['traits'] = { 'smithy.api#sensitive' => {} }
          filtered = subject.filter(input, { list: 'sensitive' })
          expect(filtered).to eq(list: '[FILTERED]')
        end

        it 'filters complex sensitive list members' do
          shapes['smithy.ruby.tests#SensitiveStructure'] = {
            'type' => 'structure',
            'members' => { 'string' => { 'target' => 'smithy.api#String' } },
            'traits' => { 'smithy.api#sensitive' => {} }
          }
          shapes['smithy.ruby.tests#StructureList']['member']['target'] = 'smithy.ruby.tests#SensitiveStructure'

          filtered = subject.filter(input, { structure_list: [{ string: 'sensitive1' }, { string: 'sensitive2' }] })
          expect(filtered).to eq(structure_list: %w[[FILTERED] [FILTERED]])
        end

        it 'filters scalar sensitive list members' do
          shapes['smithy.ruby.tests#String'] = { 'type' => 'string', 'traits' => { 'smithy.api#sensitive' => {} } }
          shapes['smithy.ruby.tests#List']['member']['target'] = 'smithy.ruby.tests#String'
          filtered = subject.filter(input, { list: %w[sensitive1 sensitive2] })
          expect(filtered).to eq(list: %w[[FILTERED] [FILTERED]])
        end

        it 'filters sensitive maps' do
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sensitive' => {} }
          filtered = subject.filter(input, { map: { 'key1' => 'value1', 'key2' => 'value2' } })
          expect(filtered).to eq(map: '[FILTERED]')
        end

        it 'filters complex sensitive map values' do
          shapes['smithy.ruby.tests#SensitiveStructure'] = {
            'type' => 'structure',
            'members' => { 'string' => { 'target' => 'smithy.api#String' } },
            'traits' => { 'smithy.api#sensitive' => {} }
          }
          shapes['smithy.ruby.tests#StructureMap']['value']['target'] = 'smithy.ruby.tests#SensitiveStructure'

          filtered = subject.filter(
            input,
            { structure_map: { 'key1' => { string: 'sensitive1' }, 'key2' => { string: 'sensitive2' } } }
          )
          expect(filtered).to eq(structure_map: { 'key1' => '[FILTERED]', 'key2' => '[FILTERED]' })
        end

        it 'filters scalar sensitive map values' do
          shapes['smithy.ruby.tests#String'] = { 'type' => 'string', 'traits' => { 'smithy.api#sensitive' => {} } }
          shapes['smithy.ruby.tests#Map']['value']['target'] = 'smithy.ruby.tests#String'
          filtered = subject.filter(input, { map: { 'key1' => 'sensitive1', 'key2' => 'sensitive2' } })
          expect(filtered).to eq(map: { 'key1' => '[FILTERED]', 'key2' => '[FILTERED]' })
        end

        it 'filters sensitive unions as a hash' do
          shapes['smithy.ruby.tests#Union']['traits'] = { 'smithy.api#sensitive' => {} }
          filtered = subject.filter(input, { union: { string: 'sensitive' } })
          expect(filtered).to eq(union: '[FILTERED]')
        end

        it 'filters sensitive unions as a type' do
          shapes['smithy.ruby.tests#Union']['traits'] = { 'smithy.api#sensitive' => {} }
          union = input.shape.member(:union).shape.member_type(:string)
          filtered = subject.filter(input, { union: union.new(string: 'sensitive') })
          expect(filtered).to eq(union: '[FILTERED]')
        end

        it 'filters complex sensitive union members' do
          shapes['smithy.ruby.tests#SensitiveStructure'] = {
            'type' => 'structure',
            'members' => { 'string' => { 'target' => 'smithy.api#String' } },
            'traits' => { 'smithy.api#sensitive' => {} }
          }
          shapes['smithy.ruby.tests#Union']['members']['structure']['target'] = 'smithy.ruby.tests#SensitiveStructure'

          filtered = subject.filter(input, { union: { structure: { string: 'sensitive' } } })
          expect(filtered).to eq(union: { structure: '[FILTERED]' })
        end

        it 'filters scalar sensitive union members' do
          shapes['smithy.ruby.tests#String'] = { 'type' => 'string', 'traits' => { 'smithy.api#sensitive' => {} } }
          shapes['smithy.ruby.tests#Union']['members']['string']['target'] = 'smithy.ruby.tests#String'
          filtered = subject.filter(input, { union: { string: 'sensitive' } })
          expect(filtered).to eq(union: { string: '[FILTERED]' })
        end

        it 'does not filter scalars without sensitive trait' do
          filtered = subject.filter(input, { string: 'string' })
          expect(filtered).to eq(string: 'string')
        end

        it 'does not filter sensitive shapes when disabled' do
          shapes['smithy.ruby.tests#String'] = { 'type' => 'string', 'traits' => { 'smithy.api#sensitive' => {} } }
          shapes['smithy.ruby.tests#Structure']['members']['string']['target'] = 'smithy.ruby.tests#String'
          subject = LogParamFilter.new(filter_sensitive_params: false)
          filtered = subject.filter(input, { string: 'sensitive' })
          expect(filtered).to eq(string: 'sensitive')
        end
      end
    end
  end
end
