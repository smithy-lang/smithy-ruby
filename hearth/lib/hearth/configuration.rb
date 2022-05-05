# frozen_string_literal: true

module Hearth
  # A module mixed into Config structs that resolves default value providers.
  module Configuration
    def initialize(*args)
      Hearth::Config::Resolver.resolve(self, *args, self.class.defaults)
      validate!
    end
  end
end
