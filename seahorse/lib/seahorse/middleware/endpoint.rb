# frozen_string_literal: true

module Seahorse
  module Middleware
    class Endpoint

      def initialize(app, disable_host_prefix:, host_prefix:, params:)
        @app = app
        @disable_host_prefix = disable_host_prefix
        @host_prefix = host_prefix
        @params = params
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        unless @disable_host_prefix
          prefix = apply_labels(@host_prefix, @params)
          request.prefix_host(prefix)
        end
        @app.call(
          request: request,
          response: response,
          context: context
        )
      end

      private

      def apply_labels(host_prefix, params)
        host_prefix.gsub(/\{.+?\}/) do |host_label|
          key = host_label.delete('{}')
          value = params[key.to_sym]

          if value.nil? || value.empty?
            raise ArgumentError,
                  "Host label #{key} cannot be nil or empty."
          end

          value
        end
      end

    end
  end
end
