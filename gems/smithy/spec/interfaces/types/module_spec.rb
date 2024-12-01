# frozen_string_literal: true

describe 'Types: Module' do
  context 'single module' do
    before(:all) do
      @tmpdir = SpecHelper.generate(['Weather'], :types)
    end

    after(:all) do
      SpecHelper.cleanup(['Weather'], @tmpdir)
    end

    it 'has a version' do
      expect(Weather::VERSION).to eq('1.0.0')
    end

    it 'requires interfaces' do
      expect(require 'weather-types/types').to eq(false)
      expect(Weather::Types).to be_a(Module)
    end
  end

  context 'nested module' do
    before(:all) do
      @tmpdir = SpecHelper.generate(%w[SomeOrganization Weather], :types, fixture: 'weather')
    end

    after(:all) do
      SpecHelper.cleanup(%w[SomeOrganization Weather], @tmpdir)
    end

    it 'has a version' do
      expect(SomeOrganization::Weather::VERSION).to eq('1.0.0')
    end

    it 'requires interfaces' do
      expect(require 'some_organization-weather-types/types').to eq(false)
      expect(SomeOrganization::Weather::Types).to be_a(Module)
    end
  end
end
