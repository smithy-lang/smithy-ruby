# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HTTPBearerAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HTTPBearerAuth'

      subject { HTTPBearerAuth::Client.new(stub_responses: true) }

      it 'loads the http bearer auth plugin' do
        expect(HTTPBearerAuth::Client.plugins).to include(Smithy::Client::Plugins::HTTPBearerAuth)
        subject.operation
      end
    end
  end
end
