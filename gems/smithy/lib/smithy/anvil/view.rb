# frozen_string_literal: true

require 'erb'

module Smithy
  # @api private
  module Anvil
    class View
      TEMPLATE_DIR = File.expand_path('../templates', __FILE__)

      class << self
        def inherited(subclass)
          parts = (subclass.name || '').split('::')
          parts.shift #=> remove Smithy
          parts.shift #=> remove Anvil
          parts.shift #=> remove Views
          path = File.join(parts.map { |part| Tools::Underscore.underscore(part) })
          subclass.template_file = File.join(TEMPLATE_DIR, "#{path}.erb")
        end

        attr_accessor :template_file
      end

      def hammer
        ERB.new(File.read(self.class.template_file), trim_mode: '-').result(binding)
      end
    end
  end
end
