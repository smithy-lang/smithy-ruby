# frozen_string_literal: true

require 'erb'

module Smithy
  # @api private
  module Anvil
    class View
      TEMPLATE_DIR = File.expand_path('../templates', __FILE__)

      class << self
        def inherited(subclass)
          parts = subclass.name.split('::')
          parts.shift #=> remove Smithy
          parts.shift #=> remove Anvil
          parts.shift #=> remove Views
          path = parts.map { |part| Underscore.underscore(part) }.join('/')
          subclass.template_path = TEMPLATE_DIR
          subclass.template_file = "#{TEMPLATE_DIR}/#{path}.erb"
        end

        attr_accessor :template_path, :template_file
      end

      def render
        file = File.read(self.class.template_file)
        erb = ERB.new(file, trim_mode: '<>')
        erb.result(binding)
      end
    end
  end
end
