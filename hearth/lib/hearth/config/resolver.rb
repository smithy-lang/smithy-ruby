# frozen_string_literal: true

module Hearth
  # @api private
  module Config
    # Resolves configuration options.
    class Resolver
      private_class_method :new

      # @param config [Struct]
      # @param options [Hash]
      # @param defaults [Hash<Array<Proc>>]
      # @return [Struct]
      def self.resolve(config, options, defaults = {})
        new(config).send(:resolve, options, defaults)
      end

      def [](key)
        @options[key] = resolve_default(key) unless @options.key?(key)
        @options[key]
      end

      private

      # @param config [Struct]
      def initialize(config)
        @config = config
      end

      def resolve(options, defaults)
        @options = options
        @defaults = defaults
        @config.members.each do |key|
          @config[key] = self[key]
        end
      end

      def resolve_default(key)
        @defaults[key]&.each do |default|
          value =
            if default.respond_to?(:call)
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
