# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module DefaultValues
  # @api private
  module Params

    class GetThingInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetThingInput, context: context)
        type = Types::GetThingInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class GetThingOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetThingOutput, context: context)
        type = Types::GetThingOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

  end
end
