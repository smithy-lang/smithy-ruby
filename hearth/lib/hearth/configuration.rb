# frozen_string_literal: true

module Hearth
  # A module mixed into Config structs that resolves default value providers.
  module Configuration
    def initialize(**options)
      Hearth::Config::Resolver.resolve(self, options, defaults)
      super
    end
  end
end
