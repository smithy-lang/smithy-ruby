# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Auth
    Params = Struct.new(:operation_name, keyword_init: true)

    SCHEMES = [
      Hearth::AuthSchemes::Anonymous.new
    ].freeze

    Resolver = Hearth::AnonymousAuthResolver
  end
end
