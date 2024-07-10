# frozen_string_literal: true

module Hearth
  module EventStream
    module Middleware
      # A middleware that sets ContentType for EventStream requests
      class ContentType
        include Middleware::Logging

        # @param [Class] app The next middleware in the stack.
        # @param [Module] message_encoding_module Module with protocol specific
        #   message encoders/decoders and content_type method.
        #  arguments.
        def initialize(app, message_encoding_module:)
          @app = app
          @message_encoding_module = message_encoding_module
        end

        # @param input
        # @param context
        # @return [Output]
        def call(input, context)
          request = context.request
          if !request.headers.key?('Content-Type')
            content_type = @message_encoding_module
                             .send(:content_type)
            request.headers['Content-Type'] = content_type
            log_debug(context, "Set Content-Type to #{content_type}")
          end

          @app.call(input, context)
        end
      end
    end
  end
end
