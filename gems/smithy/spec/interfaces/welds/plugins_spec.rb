# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Plugins' do
  before(:all) do
    Object.const_set(:PluginA, Class.new(Smithy::Client::Plugin))
    Object.const_set(:PluginB, Class.new(Smithy::Client::Plugin))

    Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#Weather'
      end

      def add_plugins
        {
          PluginA => { require_path: 'smithy-client' },
          PluginB => { require_path: 'smithy-client' }
        }
      end

      def remove_plugins
        [PluginB]
      end
    end
  end

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      it 'adds plugins to the client' do
        expect(Weather::Client.plugins).to include(PluginA)
      end

      it 'removes plugins from the client' do
        expect(Weather::Client.plugins).not_to include(PluginB)
      end
    end
  end
end
