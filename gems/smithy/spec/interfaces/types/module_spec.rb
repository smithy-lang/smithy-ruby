# frozen_string_literal: true

describe 'Types: Module' do
  before(:all) do
    @tmpdir = SpecHelper.generate(['Weather'], :types, generate_files: true)
  end

  after(:all) do
    SpecHelper.cleanup(['Weather'], @tmpdir)
  end

  it 'has a version' do
    expect(Weather::VERSION).to eq('1.0.0')
  end

  it 'requires interfaces' do
    expect(require 'weather-types/types').to eq(false)
  end
end
