# frozen_string_literal: true

module Hearth
  module Config
    # @api private
    class Resolver
      def initialize(klass, providers = nil)
        @values = {}
        @config_class = klass
        @config_providers = providers
      end

      def build(options = {})
        @values = options
        config = @config_class.new
        config.members.each do |key|
          config[key] = key(key)
        end
        config.freeze
      end

      def key(key)
        @values[key] ||= resolve_value(key)
      end
      alias [] key

      private

      def resolve_value(k)
        @config_providers[k]&.each do |provider|
          value = provider.call(self)
          return value unless value.nil?
        end
        nil
      end
    end
  end
end
