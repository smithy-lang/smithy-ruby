# # frozen_string_literal: true
#
# require_relative '../../spec_helper'
#
# describe 'Welds: Auth Schemes' do
#   before(:all) do
#     Object.const_set(:AuthSchemeA, Class.new)
#     Object.const_set(:AuthSchemeB, Class.new)
#
#     Class.new(Smithy::Weld) do
#       def for?(service)
#         service.keys.first == 'smithy.ruby.tests#Weather'
#       end
#
#       def add_auth_schemes
#         {
#           'authSchemeA' => {
#             auth_scheme_config_option: :auth_scheme_a,
#             identity_provider_config_option: :identity_provider_a,
#             identity_type: Class
#           },
#           'authSchemeB' => {
#             auth_scheme_config_option: :auth_scheme_b,
#             identity_provider_config_option: :identity_provider_b,
#             identity_type: Class
#           }
#         }
#       end
#
#       def remove_auth_schemes
#         ['authSchemeB']
#       end
#     end
#   end
#
#   ['generated client gem', 'generated client from source code'].each do |context|
#     context context do
#       include_context context, 'Weather'
#
#       let(:client) { Weather::Client.new }
#
#       it 'adds plugins to the client' do
#         expect(client.config.auth_schemes).to include('authSchemeA')
#       end
#
#       it 'removes plugins from the client' do
#         expect(client.config.auth_schemes).not_to include('authSchemeB')
#       end
#     end
#   end
# end
