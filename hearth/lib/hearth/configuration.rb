# frozen_string_literal: true

module Hearth
  # A module mixed into Config structs that resolves default value providers.
  module Configuration
    def initialize(**options)
      @options = options.dup
      Hearth::Config::Resolver.resolve(self, options, _defaults)
      super
    end

    # @return [Hash<Symbol, Object>] The original configuration options.
    attr_reader :options

    def merge(configuration)
      self.class.new(**to_h.merge(configuration.to_h))
    end
  end
end
