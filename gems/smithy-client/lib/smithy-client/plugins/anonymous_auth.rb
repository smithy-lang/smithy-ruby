# frozen_string_literal: true

require_relative '../anonymous_provider'
require_relative '../identities/anonymous'
require_relative '../signers/anonymous'

module Smithy
  module Client
    module Plugins
      # @api private
      class AnonymousAuth < Plugin
        option(:anonymous_provider) do |_config|
          AnonymousProvider.new
        end

        class Handler < Client::Handler
          def call(context)
            Smithy::Client::Signers::Anonymous.new.sign(context)
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
