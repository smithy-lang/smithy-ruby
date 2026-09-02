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
            payload_member = Schema::Extension.streaming_member(context.operation.input)
            # Proceed with TE header logic when the input models a streaming member.
            apply_transfer_encoding(context, payload_member.target) if payload_member
            @handler.call(context)
          end

          private

          def apply_transfer_encoding(context, payload_shape)
            return if context.http_request.body.respond_to?(:size)
            if Schema::Extension.requires_length?(payload_shape)
              raise Smithy::Client::Errors::MissingContentLength
            elsif Schema::Extension.unsigned_payload?(context.operation)
              context.http_request.headers['Transfer-Encoding'] = 'chunked'
            end
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
