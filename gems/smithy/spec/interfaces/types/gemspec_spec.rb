# frozen_string_literal: true

describe 'Types: Gemspec' do
  context 'single module' do
    before(:all) do
      @tmpdir = SpecHelper.generate(['Weather'], :types)
    end

    after(:all) do
      SpecHelper.cleanup(['Weather'], @tmpdir)
    end

    it 'generates a gemspec with types suffix' do
      gemspec = File.join(@tmpdir, 'weather-types.gemspec')
      expect(File.exist?(gemspec)).to be(true)
    end

    it 'has a gem specification' do
      gemspec = File.join(@tmpdir, 'weather-types.gemspec')
      gem = Gem::Specification.load(gemspec)
      expect(gem.name).to eq('weather-types')
      expect(gem.version).to eq(Gem::Version.new('1.0.0'))
      expect(gem.summary).to eq('Generated gem using Smithy')
      expect(gem.authors).to eq(['Smithy Ruby'])
      expect(gem.files).to include('lib/weather-types/types.rb')
      expect(gem.dependencies).to include(Gem::Dependency.new('smithy-client', '~> 1'))
    end
  end

  context 'nested module' do
    before(:all) do
      @tmpdir = SpecHelper.generate(%w[SomeOrganization Weather], :types, fixture: 'weather')
    end

    after(:all) do
      SpecHelper.cleanup(%w[SomeOrganization Weather], @tmpdir)
    end

    it 'generates a gemspec with types suffix' do
      gemspec = File.join(@tmpdir, 'some_organization-weather-types.gemspec')
      expect(File.exist?(gemspec)).to be(true)
    end

    it 'has a gem specification' do
      gemspec = File.join(@tmpdir, 'some_organization-weather-types.gemspec')
      gem = Gem::Specification.load(gemspec)
      expect(gem.name).to eq('some_organization-weather-types')
      expect(gem.version).to eq(Gem::Version.new('1.0.0'))
      expect(gem.summary).to eq('Generated gem using Smithy')
      expect(gem.authors).to eq(['Smithy Ruby'])
      expect(gem.files).to include('lib/some_organization-weather-types/types.rb')
      expect(gem.dependencies).to include(Gem::Dependency.new('smithy-client', '~> 1'))
    end
  end
end
