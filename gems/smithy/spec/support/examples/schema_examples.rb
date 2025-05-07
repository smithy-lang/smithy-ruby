# frozen_string_literal: true

RSpec.shared_examples 'schema module' do |context|
  include_context context, 'ShapeService', fixture: 'shapes'

  let(:fixture) { JSON.load_file(File.expand_path('../../fixtures/shapes/model.json', __dir__.to_s)) }

  it 'generates a schema module' do
    expect(ShapeService::Schema).to be_a(Module)
  end

  def expect_generated_shape(subject, shape_class, shape_hash)
    id, shape = shape_hash
    expect(subject).to be_a(shape_class)
    expect(subject.id).to eq(id)
    expect(subject.traits).to eq(shape['traits'])
  end

  context 'blob' do
    subject { ShapeService::Schema::Blob }
    let(:shape_class) { Smithy::Schema::Shapes::BlobShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'blob' }
    end

    it 'generates a blob shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'boolean' do
    subject { ShapeService::Schema::Boolean }
    let(:shape_class) { Smithy::Schema::Shapes::BooleanShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'boolean' }
    end

    it 'generates a boolean shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'string' do
    subject { ShapeService::Schema::String }
    let(:shape_class) { Smithy::Schema::Shapes::StringShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'string' }
    end

    it 'generates a string shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'byte' do
    subject { ShapeService::Schema::Byte }
    let(:shape_class) { Smithy::Schema::Shapes::IntegerShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'byte' }
    end

    it 'generates a byte shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'short' do
    subject { ShapeService::Schema::Short }
    let(:shape_class) { Smithy::Schema::Shapes::IntegerShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'short' }
    end

    it 'generates a short shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'integer' do
    subject { ShapeService::Schema::Integer }
    let(:shape_class) { Smithy::Schema::Shapes::IntegerShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'integer' }
    end

    it 'generates an integer shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'long' do
    subject { ShapeService::Schema::Long }
    let(:shape_class) { Smithy::Schema::Shapes::IntegerShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'long' }
    end

    it 'generates a long shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'float' do
    subject { ShapeService::Schema::Float }
    let(:shape_class) { Smithy::Schema::Shapes::FloatShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'float' }
    end

    it 'generates a float shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'double' do
    subject { ShapeService::Schema::Double }
    let(:shape_class) { Smithy::Schema::Shapes::FloatShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'double' }
    end

    it 'generates a double shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'bigInteger' do
    subject { ShapeService::Schema::BigInteger }
    let(:shape_class) { Smithy::Schema::Shapes::IntegerShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'bigInteger' }
    end

    it 'generates a big integer shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'bigDecimal' do
    subject { ShapeService::Schema::BigDecimal }
    let(:shape_class) { Smithy::Schema::Shapes::BigDecimalShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'bigDecimal' }
    end

    it 'generates a big decimal shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'timestamp' do
    subject { ShapeService::Schema::Timestamp }
    let(:shape_class) { Smithy::Schema::Shapes::TimestampShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'timestamp' }
    end

    it 'generates a timestamp shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'document' do
    subject { ShapeService::Schema::Document }
    let(:shape_class) { Smithy::Schema::Shapes::DocumentShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'document' }
    end

    it 'generates a document shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end
  end

  context 'enum' do
    subject { ShapeService::Schema::Enum }
    let(:shape_class) { Smithy::Schema::Shapes::EnumShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'enum' }
    end
    let(:expected_member) do
      _, shape = shape_hash
      shape['members']['FOO']
    end

    it 'generates an enum shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end

    it 'has members' do
      expect(subject.members.keys).to eq(%i[foo])
      expect(subject.members[:foo].shape).to be_a(Smithy::Schema::Shapes::StructureShape)
      expect(subject.members[:foo].traits).to eq(expected_member['traits'])
      expect(subject.members[:foo].shape.id).to eq(expected_member['target'])
    end

    it 'has a member with traits' do
      expect(subject.member(:foo).traits).to eq(expected_member['traits'])
    end
  end

  context 'intEnum' do
    subject { ShapeService::Schema::IntEnum }
    let(:shape_class) { Smithy::Schema::Shapes::IntEnumShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'intEnum' }
    end
    let(:expected_member) do
      _, shape = shape_hash
      shape['members']['BAZ']
    end

    it 'generates an int enum shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end

    it 'has members' do
      expect(subject.members.keys).to eq(%i[baz])
      expect(subject.members[:baz].shape).to be_a(Smithy::Schema::Shapes::StructureShape)
      expect(subject.members[:baz].traits).to eq(expected_member['traits'])
      expect(subject.members[:baz].shape.id).to eq(expected_member['target'])
    end

    it 'has a member with traits' do
      expect(subject.member(:baz).traits).to eq(expected_member['traits'])
    end
  end

  context 'list' do
    subject { ShapeService::Schema::List }
    let(:shape_class) { Smithy::Schema::Shapes::ListShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'list' }
    end
    let(:expected_member) do
      _, shape = shape_hash
      shape['member']
    end

    it 'generates a list shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end

    it 'has a member' do
      expect(subject.member.shape).to be_a(Smithy::Schema::Shapes::StringShape)
      expect(subject.member.shape.id).to eq(expected_member['target'])
    end

    it 'has a member with traits' do
      expect(subject.member.traits).to eq(expected_member['traits'])
    end
  end

  context 'map' do
    subject { ShapeService::Schema::Map }
    let(:shape_class) { Smithy::Schema::Shapes::MapShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'map' }
    end
    let(:expected_shape) do
      _, shape = shape_hash
      shape
    end

    it 'generates a map shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end

    it 'has key and value members' do
      expect(subject.key.shape).to be_a(Smithy::Schema::Shapes::StringShape)
      expect(subject.key.shape.id).to eq(expected_shape['key']['target'])
      expect(subject.value.shape).to be_a(Smithy::Schema::Shapes::StringShape)
      expect(subject.value.shape.id).to eq(expected_shape['value']['target'])
    end

    it 'has keys and values with traits' do
      expect(subject.key.traits).to eq(expected_shape['key']['traits'])
      expect(subject.value.traits).to eq(expected_shape['value']['traits'])
    end
  end

  context 'union' do
    subject { ShapeService::Schema::Union }
    let(:shape_class) { Smithy::Schema::Shapes::UnionShape }
    let(:shape_hash) do
      fixture['shapes'].find { |_, s| s['type'] == 'union' }
    end
    let(:expected_shape) do
      _, shape = shape_hash
      shape
    end

    it 'generates a union shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end

    it 'has members' do
      expected_members = expected_shape['members'].keys.map(&:to_sym)
      expect(subject.members.except(:unknown).keys).to eq(expected_members)
    end

    it 'has members with traits' do
      traits = expected_shape['members'].values.map { |m| m['traits'] }
      expect(subject.members.except(:unknown).values.map(&:traits)).to eq(traits)
    end

    it 'has a type' do
      expect(subject.type).to eq(ShapeService::Types::Union)
    end

    it 'has members with types' do
      expect(subject.member_type(:string)).to eq(ShapeService::Types::Union::String)
      expect(subject.member_type(:structure)).to eq(ShapeService::Types::Union::Structure)
    end

    it 'supports unit types' do
      expect(subject.member(:unit).shape).to eq(Smithy::Schema::Shapes::Prelude::Unit)
      expect(subject.member_type(:unit)).to eq(ShapeService::Types::Union::Unit)
    end

    it 'has an unknown member' do
      expect(subject.member(:unknown).shape).to eq(Smithy::Schema::Shapes::Prelude::Unit)
      expect(subject.member_type(:unknown)).to eq(ShapeService::Types::Union::Unknown)
    end
  end

  context 'structure' do
    subject { ShapeService::Schema::Structure }
    let(:shape_class) { Smithy::Schema::Shapes::StructureShape }
    let(:shape_hash) do
      fixture['shapes'].find { |k, _| k.include?('Structure') }
    end
    let(:expected_shape) do
      _, shape = shape_hash
      shape
    end

    it 'generates a structure shape' do
      expect_generated_shape(subject, shape_class, shape_hash)
    end

    it 'has members' do
      expected_members =
        expected_shape['members']
        .keys
        .map { |m| m.underscore.to_sym }
      expect(subject.members.keys).to eq(expected_members)
    end

    it 'has a member with traits' do
      expected_member =
        expected_shape['members']
        .slice('member')
        .values
        .first
      expect(subject.member(:member).traits).to eq(expected_member['traits'])
    end
  end

  context 'service' do
    subject { ShapeService::Schema::ShapeService }
    let(:shape_class) { Smithy::Schema::Shapes::ServiceShape }
    let(:expected_shape) do
      fixture['shapes'].find { |_k, v| v['type'] == 'service' }
    end
    let(:operation_shapes) { fixture.select { |_k, v| v['type'] == 'operation' } }

    it 'generates a service shape' do
      expect_generated_shape(subject, shape_class, expected_shape)
    end

    it 'has a version' do
      expect(subject.version).to eq(expected_shape[1]['version'])
    end

    it 'has operations' do
      operation_shapes.each do |name, shape|
        generated_shape = subject.operation(name.underscore)
        expect(generated_shape.id).to eq(name)
        expect(generated_shape).to be_a(Smithy::Schema::Shapes::OperationShape)
        expect(generated_shape.input.id).to eq(shape['input'])
        expect(generated_shape.output.id).to eq(shape['output'])
        expect(generated_shape.traits).to eq(shape['traits'])
        expect(generated_shape.errors.map(&:id)).to eq(shape['errors'])
      end
    end
  end

  context 'type registry' do
    subject { ShapeService::Schema::TYPE_REGISTRY }

    let(:typed_shapes) do
      fixture['shapes'].select do |_k, v|
        %w[union structure].include?(v['type']) &&
          !v['traits']&.include?('smithy.api#trait')
      end
    end

    it 'generates a type registry' do
      expect(subject).to be_a(Smithy::Schema::TypeRegistry)
    end

    it 'contains a registry of typed shapes' do
      expect(subject.registry.keys).to match_array(typed_shapes.keys)
    end
  end
end
