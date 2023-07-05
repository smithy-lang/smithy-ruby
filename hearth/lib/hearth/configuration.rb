# frozen_string_literal: true

module Hearth
  # A module mixed into Config structs that resolves default value providers.
  module Configuration
    def initialize(**options)
      Hearth::Config::Resolver.resolve(self, options, self.class.defaults)
      validate!
    end

    def dup
      copy = super
      members.each do |member|
        copy[member] = self[member].dup
      end
      copy
    end
  end
end
