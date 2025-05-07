# frozen_string_literal: true

RSpec.shared_examples 'types module' do |context|
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
    input_output = ShapeService::Types::OperationInputOutput.new(
      list: ['item'],
      map: { 'key' => 'value' },
      string: 'string',
      union: ShapeService::Types::Union::Structure.new(structure)
    )
    expected = {
      string: 'string',
      union: { structure: { member: 'member' } }
    }
    expect(input_output.to_h).to include(expected)
  end

  it 'has default values' do
    input_output = ShapeService::Types::OperationInputOutput.new
    expected = {
      big_decimal: 0.0,
      big_integer: 0,
      blob: 'YmxvYg==',
      boolean: true,
      byte: 0,
      double: 0.0,
      enum: 'bar',
      float: 0.0,
      int_enum: 1,
      integer: 0,
      list: [],
      long: 0,
      map: {},
      short: 0,
      string: 'string',
      timestamp: '1985-04-12T23:20:50.52Z'
    }
    expect(input_output.to_h).to eq(expected)
  end
end
