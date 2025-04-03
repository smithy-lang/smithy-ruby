# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Plugins' do
  before(:all) do
    Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#Weather'
      end

      def add_plugins
        {
          Smithy::Client::Plugins::ParamConverter => { require_path: 'smithy-client/plugins/param_converter' },
          Smithy::Client::Plugins::ParamValidator => { require_path: 'smithy-client/plugins/param_validator' }
        }
      end

      def remove_plugins
        [Smithy::Client::Plugins::ParamValidator]
      end
    end
  end

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      it 'adds plugins to the client' do
        expect(Weather::Client.plugins).to include(Smithy::Client::Plugins::ParamConverter)
      end

      it 'removes plugins from the client' do
        expect(Weather::Client.plugins).not_to include(Smithy::Client::Plugins::ParamValidator)
      end
    end
  end
end
