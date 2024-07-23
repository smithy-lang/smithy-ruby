# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Plugins
    # GlobalConfig plugin sets default values for the {Client}'s config.
    # See {Hearth#config=} for setting default values.
    #
    class GlobalConfig

      def call(config)
        options = config.options
        ::Hearth.config.each do |key, value|
          config.send("#{key}=", value) unless options.key?(key)
        end
      end

    end
  end
end
