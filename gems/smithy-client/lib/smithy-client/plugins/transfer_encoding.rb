# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class TransferEncoding < Plugin
        # @api private
        class Handler < Client::Handler
          def call(context)
            payload_ref = streaming_member_ref(context)
            # Proceed with TE header logic IFF there's a streaming payload.
            apply_transfer_encoding(context, payload_ref.shape) if payload_ref
            @handler.call(context)
          end

          private

          def apply_transfer_encoding(context, payload)
            return if context.http_request.body.respond_to?(:size)
            if requires_length?(payload)
              raise 'Required `Content-Length` value missing for the request.'
            elsif unsigned_payload?(context)
              context.http_request.headers['Transfer-Encoding'] = 'chunked'
            end
          end

          def streaming_member_ref(context)
            context.operation.input.shape.members.detect do |_, ref|
              ref.shape.traits.key?('smithy.api#streaming')
            end&.last
          end

          def requires_length?(payload)
            payload.traits.key?('smithy.api#requiresLength')
          end

          def unsigned_payload?(context)
            context.operation.traits.key?('aws.auth#unsignedPayload')
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
