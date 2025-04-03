# frozen_string_literal: true

require_relative '../anonymous_provider'
require_relative '../identities/anonymous'
require_relative '../signers/anonymous'
require_relative '../auth_schemes/anonymous'

module Smithy
  module Client
    module Plugins
      # @api private
      class AnonymousAuth < Plugin
        option(:anonymous_provider) do |_config|
          AnonymousProvider.new
        end

        option(:anonymous_auth_scheme) do |_config|
          Smithy::Client::AuthSchemes::Anonymous.new
        end
      end
    end
  end
end
