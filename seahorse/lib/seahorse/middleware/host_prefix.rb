# frozen_string_literal: true

module Seahorse
  module Middleware
    class HostPrefix

      def initialize(app, disable_host_prefix:, host_prefix:)
        @app = app
        @disable_host_prefix = disable_host_prefix
        @host_prefix = host_prefix
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        unless @disable_host_prefix
          prefix = apply_labels(@host_prefix, input)
          context.request.prefix_host(prefix)
        end
        @app.call(input, context)
      end

      private

      def apply_labels(host_prefix, input)
        host_prefix.gsub(/\{.+?\}/) do |host_label|
          key = host_label.delete('{}')
          value = input[key.to_sym]

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
