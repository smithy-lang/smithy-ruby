# frozen_string_literal: true

module Smithy
  module Client
    module RPCv2CBOR
      # @api private
      class RequestBuilder
        def initialize(options = {})
          @codec = CBOR::Codec.new(options)
        end

        def build(context)
          context.request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          context.request.http_method = 'POST'
          context.request.body = build_body(context)
          apply_content_type_header(context)
          apply_accept_header(context)
          build_url(context)
        end

        private

        def build_body(context)
          @codec.serialize(context.operation.input, context.params)
        end

        def apply_content_type_header(context)
          input = context.operation.input
          content_type =
            if event_stream?(input)
              'application/vnd.amazon.eventstream'
            elsif input != Schema::Shapes::Prelude::Unit
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

        def event_stream?(shape)
          shape.members.each_value do |member_shape|
            return true if event_stream_shape?(member_shape.shape)
          end
          false
        end

        def event_stream_shape?(shape)
          shape.traits.include?('smithy.api#streaming') && shape.is_a?(Shapes::Union)
        end

        def build_url(context)
          base = context.request.endpoint
          service_name = context.config.service.name
          base.path += "/service/#{service_name}/operation/#{context.operation.name}"
        end
      end
    end
  end
end
