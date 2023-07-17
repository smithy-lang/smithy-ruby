# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  # @api private
  module Validators

    class GetCityAnnouncementsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityAnnouncementsInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetCityImageInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityImageInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
        Hearth::Validator.validate_required!(input[:image_type], context: "#{context}[:image_type]")
        ImageType.validate!(input[:image_type], context: "#{context}[:image_type]") unless input[:image_type].nil?
        Hearth::Validator.validate_required!(input[:resolution], context: "#{context}[:resolution]")
        Hearth::Validator.validate_types!(input[:resolution], ::Integer, context: "#{context}[:resolution]")
      end
    end

    class GetCityInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetCurrentTimeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCurrentTimeInput, context: context)
      end
    end

    class GetForecastInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetForecastInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class ImageType
      def self.validate!(input, context:)
        case input
        when Types::ImageType::Raw
          Hearth::Validator.validate_types!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::ImageType::Png
          PNGImage.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::ImageType, got #{input.class}."
        end
      end

      class Raw
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class Png
        def self.validate!(input, context:)
          Validators::PNGImage.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class ListCitiesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ListCitiesInput, context: context)
        Hearth::Validator.validate_types!(input[:next_token], ::String, context: "#{context}[:next_token]")
        Hearth::Validator.validate_types!(input[:a_string], ::String, context: "#{context}[:a_string]")
        Hearth::Validator.validate_types!(input[:default_bool], ::TrueClass, ::FalseClass, context: "#{context}[:default_bool]")
        Hearth::Validator.validate_types!(input[:boxed_bool], ::TrueClass, ::FalseClass, context: "#{context}[:boxed_bool]")
        Hearth::Validator.validate_types!(input[:default_number], ::Integer, context: "#{context}[:default_number]")
        Hearth::Validator.validate_types!(input[:boxed_number], ::Integer, context: "#{context}[:boxed_number]")
        Hearth::Validator.validate_types!(input[:some_enum], ::String, context: "#{context}[:some_enum]")
        Hearth::Validator.validate_types!(input[:page_size], ::Integer, context: "#{context}[:page_size]")
      end
    end

    class PNGImage
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PNGImage, context: context)
        Hearth::Validator.validate_required!(input[:height], context: "#{context}[:height]")
        Hearth::Validator.validate_types!(input[:height], ::Integer, context: "#{context}[:height]")
        Hearth::Validator.validate_required!(input[:width], context: "#{context}[:width]")
        Hearth::Validator.validate_types!(input[:width], ::Integer, context: "#{context}[:width]")
      end
    end

    class Struct____456efg
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Struct____456efg, context: context)
        Hearth::Validator.validate_types!(input[:member___123foo], ::String, context: "#{context}[:member___123foo]")
      end
    end

    class Struct____789BadNameInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Struct____789BadNameInput, context: context)
        Hearth::Validator.validate_required!(input[:member___123abc], context: "#{context}[:member___123abc]")
        Hearth::Validator.validate_types!(input[:member___123abc], ::String, context: "#{context}[:member___123abc]")
        Struct____456efg.validate!(input[:member], context: "#{context}[:member]") unless input[:member].nil?
      end
    end

  end
end
