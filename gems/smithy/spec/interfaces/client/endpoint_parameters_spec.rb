# frozen_string_literal: true

describe 'Component: EndpointParameters' do
  before(:all) do
    @tmpdir = SpecHelper.generate(['Defaults'], :client, fixture: 'endpoints/default-values')
  end

  after(:all) do
    SpecHelper.cleanup(['Defaults'], @tmpdir)
  end

  subject { Defaults::EndpointParameters.new }

  describe '#initialize' do
    it 'initializes with default values' do
      expect(subject.baz).to eq('baz')
      expect(subject.endpoint).to eq('asdf')
      expect(subject.bar).to be_nil
    end
  end

  describe '.create' do
    it 'creates with default values and values from config' do
      # need to get a config structure
      client = Defaults::Client.new(bar: 'config_bar', endpoint: 'config_endpoint')
      config = client.config
      parameters = Defaults::EndpointParameters.create(config)
      expect(parameters.baz).to eq('baz')
      expect(parameters.endpoint).to eq('config_endpoint')
      expect(parameters.bar).to eq('config_bar')
    end
  end
end
