# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Params

    module Operation1Input

      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::Operation1Input, context: context)
        type = Types::Operation1Input.new
        type.id = params[:id]
        type.simple_list = SimpleList.build(params[:simple_list], context: "#{context}[:simple_list]") if params[:simple_list]
        type
      end
    end

    module SimpleList

      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Array, context: context)

        params.each_with_index.map do |element, index|
          element
        end
      end
    end
  end
end
