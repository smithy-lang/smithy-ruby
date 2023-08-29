# frozen_string_literal: true

module Hearth
  # A module mixed into Config structs that resolves default value providers.
  module Configuration
    def initialize(**options)
      Hearth::Validator.validate_unknown!(self, options, context: 'config')
      Hearth::Config::Resolver.resolve(self, options, self.class.defaults)
      validate!
    end

    def dup
      members.each_with_object(super) do |member, copy|
        copy[member] = self[member].dup
      end
    end
  end
end
