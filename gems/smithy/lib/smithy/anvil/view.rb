# frozen_string_literal: true

require 'erb'

module Smithy
  module Anvil
    # @api private
    class View
      class << self
        def inherited(subclass)
          parts = (subclass.name || '').split('::')
          parts.shift(2) #=> remove Smithy::Anvil
          type = parts.shift #=> remove Client/Server/Types
          parts.shift #=> remove Views
          parts.unshift(type, 'Templates') #=> add <Type>::Templates
          path = File.join(parts.map(&:underscore))
          subclass.template_file = File.expand_path("#{path}.erb", __dir__)
          super
        end

        attr_accessor :template_file
      end

      def hammer
        ERB.new(File.read(self.class.template_file), trim_mode: '-').result(binding)
      end
    end
  end
end
