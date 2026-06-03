# frozen_string_literal: true

require 'securerandom'

module Smithy
  module Client
    module Plugins
      # @api private
      class IdempotencyToken < Plugin
        def add_handlers(handlers, _config)
          handlers.add(Handler, step: :initialize)
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            apply_idempotency_token(context.operation.input, context.params)
            @handler.call(context)
          end

          private

          def apply_idempotency_token(input, params)
            input.target.members.each do |member_name, member_ref|
              next unless member_ref.traits.key?('smithy.api#idempotencyToken')

              params[member_name] ||= SecureRandom.uuid
            end
          end
        end
      end
    end
  end
end
