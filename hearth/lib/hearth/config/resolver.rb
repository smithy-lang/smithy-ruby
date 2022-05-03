# frozen_string_literal: true

module Hearth
  module Config
    # @api private
    class Resolver
      def initialize(klass, defaults = nil)
        @values = {}
        @config_class = klass
        @defaults = defaults
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

      def resolve_value(key)
        @defaults[key]&.each do |default|
          value = if default.respond_to?(:call)
                    default.call(self)
                  else
                    default
                  end
          return value unless value.nil?
        end
        nil
      end
    end
  end
end
