# frozen_string_literal: true

module Smithy
  module Client
    module RPCv2CBOR
      # @api private
      class BuildHandler < Handler
        def call(context)
          build_request(context)
          @handler.call(context)
        end

        private

        def build_request(context)
          context.request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          context.request.http_method = 'POST'
          context.request.body = build_body(context)
          apply_content_type_header(context)
          apply_accept_header(context)
          build_url(context)
        end

        def build_body(context)
          Codecs::CBOR.new.serialize(context.operation.input, context.params)
        end

        def apply_content_type_header(context)
          return if context.operation.input == Schema::Shapes::Prelude::Unit
          return if event_stream?(context.operation.input)

          context.request.headers['Content-Type'] = 'application/cbor'
        end

        def apply_accept_header(context)
          return if event_stream?(context.operation.output)

          context.request.headers['Accept'] = 'application/cbor'
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
