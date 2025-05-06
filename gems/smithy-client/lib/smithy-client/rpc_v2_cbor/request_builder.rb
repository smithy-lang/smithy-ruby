# frozen_string_literal: true

module Smithy
  module Client
    module RPCv2CBOR
      # @api private
      class RequestBuilder
        include Schema::Shapes

        def initialize(options = {})
          @codec = CBOR::Codec.new(options)
        end

        def build(context)
          apply_http_method(context)
          apply_headers(context)
          apply_body(context)
          apply_url_path(context)
        end

        private

        def apply_http_method(context)
          context.request.http_method = 'POST'
        end

        def apply_headers(context)
          context.request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          apply_content_type_header(context)
          apply_accept_header(context)
        end

        def apply_content_type_header(context)
          input = context.operation.input
          content_type =
            if event_stream?(input)
              'application/vnd.amazon.eventstream'
            elsif input != Prelude::Unit
              'application/cbor'
            end

          context.request.headers['Content-Type'] ||= content_type if content_type
        end

        def apply_accept_header(context)
          accept =
            if event_stream?(context.operation.output)
              'application/vnd.amazon.eventstream'
            else
              'application/cbor'
            end

          context.request.headers['Accept'] ||= accept
        end

        def apply_body(context)
          context.request.body = @codec.serialize(context.operation.input, context.params)
        end

        def apply_url_path(context)
          base = context.request.endpoint
          service_name = context.config.service.name
          base.path += "/service/#{service_name}/operation/#{context.operation.name}"
        end

        def event_stream?(ref)
          ref.shape.members.each_value do |member_ref|
            shape = member_ref.shape
            return true if shape.traits.include?('smithy.api#streaming') && shape.is_a?(UnionShape)
          end
          false
        end
      end
    end
  end
end
