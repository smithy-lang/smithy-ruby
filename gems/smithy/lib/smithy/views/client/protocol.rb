# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # A typed data-holder over a weld's protocol registry entry
      # (name/class_name/require_path). Protocols ship in an installed gem, so
      # unlike the plugin view there is no require_relative variant.
      # @api private
      class Protocol
        def initialize(options = {})
          @name = options[:name]
          @class_name = options[:class_name]
          @require_path = options[:require_path]
        end

        attr_accessor :name, :class_name, :require_path
      end
    end
  end
end
