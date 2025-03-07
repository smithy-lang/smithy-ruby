# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class ContentLength < Plugin
        # @api private
        class Handler < Client::Handler
          # https://github.com/ruby/net-http/blob/master/lib/net/http/requests.rb
          METHODS_WITH_BODY = Set.new(%w[POST PUT PATCH PROPFIND PROPPATCH MKCOL LOCK UNLOCK])

          def call(context)
            body = context.request.body
            if body.respond_to?(:size) && METHODS_WITH_BODY.include?(context.request.http_method)
              context.request.headers['Content-Length'] = body.size
            end
            @handler.call(context)
          end
        end

        handler(Handler)
      end
    end
  end
end
