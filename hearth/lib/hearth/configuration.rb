# frozen_string_literal: true

module Hearth
  # A module mixed into Config structs that resolves default value providers.
  module Configuration
    def initialize(**options)
      @options = options.dup
      Hearth::Validator.validate_unknown!(self, options, context: 'config')
      Hearth::Config::Resolver.resolve(self, options, _defaults)
    end

    # @return [Hash<Symbol, Object>] The original configuration options.
    attr_reader :options

    # @return [Hash<Symbol, Object>] The configuration options.
    def to_h(obj = self)
      obj.class::MEMBERS.each_with_object({}) do |member, hash|
        hash[member] = obj.send(member)
      end
    end
    alias to_hash to_h

    def merge(configuration)
      self.class.new(**to_h.merge(configuration.to_h))
    end
  end
end
