# frozen_string_literal: true

module Smithy
  module Client
    module RpcV2Cbor
      # @api private
      class Handler < Client::Handler
        def call(context)
          build_request(context)
          response = @handler.call(context)
          response.on_done(200..299) { |resp| resp.data = parse_body(context) }
          response
        end

        private

        def build_request(context)
          context.http_request.http_method = 'POST'
          apply_headers(context)
          apply_body(context)
          apply_url_path(context)
        end

        def parse_body(context)
          context.config.cbor_codec.parse(context.operation.output, context.http_response.body.read)
        end

        def apply_headers(context)
          context.http_request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          apply_content_type_header(context)
          apply_accept_header(context)
        end

        def apply_content_type_header(context)
          input = context.operation.input
          content_type =
            if event_stream?(input)
              'application/vnd.amazon.eventstream'
            elsif input.shape != Schema::Shapes::Prelude::Unit
              'application/cbor'
            end

          context.http_request.headers['Content-Type'] ||= content_type if content_type
        end

        def apply_accept_header(context)
          accept =
            if event_stream?(context.operation.output)
              'application/vnd.amazon.eventstream'
            else
              'application/cbor'
            end

          context.http_request.headers['Accept'] ||= accept
        end

        def apply_body(context)
          context.http_request.body = context.config.cbor_codec.build(context.operation.input, context.params)
        end

        def apply_url_path(context)
          base = context.http_request.endpoint
          service_name = context.config.service.name
          base.path += "/service/#{service_name}/operation/#{context.operation.name}"
        end

        def event_stream?(ref)
          ref.shape.members.each_value do |member_ref|
            shape = member_ref.shape
            return true if shape.traits.key?('smithy.api#streaming') && shape.is_a?(Schema::Shapes::UnionShape)
          end
          false
        end
      end
    end
  end
end
