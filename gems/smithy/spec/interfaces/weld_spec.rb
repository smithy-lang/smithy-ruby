# frozen_string_literal: true

describe 'Types: Welding' do
  Class.new(Smithy::Weld) do
    # TODO: test for? method

    def preprocess(model)
      model['shapes']['example.weather#Weld'] = { 'type' => 'structure', 'members' => {} }
    end
  end

  before(:all) do
    @tmpdir = SpecHelper.generate(['Weather'], :types)
  end

  after(:all) do
    SpecHelper.cleanup(['Weather'], @tmpdir)
  end

  it 'can preprocess the model' do
    weld = Weather::Types::Weld.new
    expect(weld).to be_a(Struct)
    expect(weld.members).to be_empty
  end
end
