# frozen_string_literal: true

describe 'Types: Welding' do
  weld = Class.new(Smithy::Weld) do
    def self.preprocess(model)
      model['shapes']['example.weather#Weld'] = { "type" => "structure", "members" => {} }
    end
  end

  before(:all) do
    SpecHelper.generate(['Weather'], :types)
  end

  after(:all) do
    SpecHelper.cleanup(['Weather'])
  end

  it 'loads the weld' do
    expect(Smithy::Weld.descendants).to include(weld)
  end

  it 'can preprocess the model' do
    weld = Weather::Types::Weld.new
    expect(weld).to be_a(Struct)
    expect(weld.members).to be_empty
  end
end
