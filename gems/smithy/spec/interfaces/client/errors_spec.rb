# frozen_string_literal: true

describe 'Component: Errors' do
  before(:all) do
    @tmpdir = SpecHelper.generate(['Weather'], :client)
  end

  after(:all) do
    SpecHelper.cleanup(['Weather'], @tmpdir)
  end

  it 'generates an errors module' do
    expect(Weather::Errors).to be_a(Module)
  end

  it 'generates an error class' do
    error = Weather::Errors::NoSuchResource.new(nil, nil, nil)
    expect(error).to be_a(Smithy::Client::Errors::ServiceError)
  end

  it 'can return data members' do
    data = Weather::Types::NoSuchResource.new(resource_type: 'foo')
    error = Weather::Errors::NoSuchResource.new(nil, nil, data)
    expect(error.resource_type).to eq('foo')
  end

  it 'generates a dynamic error class' do
    expect(defined?(Weather::Errors::DynamicError)).to be nil
    new_error = Weather::Errors::DynamicError.new(nil, nil, nil)
    expect(new_error).to be_a(Smithy::Client::Errors::ServiceError)
  end
end
