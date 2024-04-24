# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module DefaultValues
  # @api private
  module Validators

    class GetThingInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetThingInput, context: context)
      end
    end

    class GetThingOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetThingOutput, context: context)
      end
    end

  end
end
