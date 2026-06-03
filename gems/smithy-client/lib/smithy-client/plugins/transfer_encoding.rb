# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # TODO: Verify whether aws.api#awsChunked trait is supported in smithy-ruby's
      # model/codegen. If it is (or once service models adopt it), revisit this plugin to
      # handle AWS chunked transfer encoding alongside the generic HTTP case.
      # @api private
      class TransferEncoding < Plugin
        # @api private
        class Handler < Client::Handler
          def call(context)
            payload_ref = streaming_member_ref(context)
            # Proceed with TE header logic IFF there's a streaming payload.
            apply_transfer_encoding(context, payload_ref.target) if payload_ref
            @handler.call(context)
          end

          private

          def apply_transfer_encoding(context, payload)
            return if context.http_request.body.respond_to?(:size)
            if requires_length?(payload)
              raise Smithy::Client::Errors::MissingContentLength
            elsif unsigned_payload?(context)
              context.http_request.headers['Transfer-Encoding'] = 'chunked'
            end
          end

          def streaming_member_ref(context)
            context.operation.input.target.members.detect do |_, ref|
              ref.target.traits.key?('smithy.api#streaming')
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
