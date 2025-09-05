# frozen_string_literal: true

RSpec.shared_examples 'types module' do |context|
  context 'type classes, modules, and constants' do
    include_context context, 'ShapeService', fixture: 'shapes'

    it 'generates a types module' do
      expect(ShapeService::Types).to be_a(Module)
    end

    it 'has structures as structs that include Structure' do
      expect(ShapeService::Types::Structure).to be < Struct
      expect(ShapeService::Types::Structure).to include(Smithy::Schema::Structure)
    end

    it 'has unions that define member subclasses' do
      expect(ShapeService::Types::Union).to be < Smithy::Schema::Union
      expect(ShapeService::Types::Union::Structure).to be < ShapeService::Types::Union
    end

    it 'supports nested to_h' do
      structure = ShapeService::Types::Structure.new(member: 'member')
      input = ShapeService::Types::OperationInput.new(
        list: ['item'],
        map: { 'key' => 'value' },
        string: 'string',
        union: ShapeService::Types::Union::Structure.new(structure: structure)
      )
      expected = {
        string: 'string',
        union: { structure: { member: 'member' } }
      }
      expect(input.to_h).to include(expected)
    end
  end
end
