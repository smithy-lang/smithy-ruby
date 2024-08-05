# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Auth
    class Params
      def initialize(operation_name: nil)
        @operation_name = operation_name
      end

      attr_accessor :operation_name
    end

    SCHEMES = [
      Hearth::AuthSchemes::Anonymous.new
    ].freeze

    Resolver = Hearth::AnonymousAuthResolver
  end
end
