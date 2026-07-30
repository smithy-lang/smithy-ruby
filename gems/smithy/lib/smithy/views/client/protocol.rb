# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # A typed data-holder over a weld's protocol registry entry
      # (name/class_name/require_path/require_relative), analogous to the plugin view.
      # @api private
      class Protocol
        def initialize(options = {})
          @name = options[:name]
          @class_name = options[:class_name]
          @require_path = options[:require_path]
          @require_relative = options.fetch(:require_relative, false)
        end

        attr_accessor :name, :class_name, :require_path

        def require_relative?
          @require_relative
        end
      end
    end
  end
end
