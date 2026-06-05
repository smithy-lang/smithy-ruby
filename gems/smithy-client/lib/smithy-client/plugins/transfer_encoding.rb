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
            payload_member = streaming_member(context)
            # Proceed with TE header logic IFF there's a streaming payload.
            apply_transfer_encoding(context, payload_member.target) if payload_member
            @handler.call(context)
          end

          private

          def apply_transfer_encoding(context, payload_shape)
            return if context.http_request.body.respond_to?(:size)
            if requires_length?(payload_shape)
              raise Smithy::Client::Errors::MissingContentLength
            elsif unsigned_payload?(context)
              context.http_request.headers['Transfer-Encoding'] = 'chunked'
            end
          end

          def streaming_member(context)
            context.operation.input.members.detect do |_, member_shape|
              member_shape.target.traits.key?('smithy.api#streaming')
            end&.last
          end

          def requires_length?(shape)
            shape.traits.key?('smithy.api#requiresLength')
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
