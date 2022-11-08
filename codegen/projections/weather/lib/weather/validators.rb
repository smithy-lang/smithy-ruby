# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'time'

module Weather
  module Validators

    class Announcements
      def self.validate!(input, context:)
        case input
        when Types::Announcements::Police
          Message.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Announcements::Fire
          Message.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Announcements::Health
          Message.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::Announcements, got #{input.class}."
        end
      end

      class Police
        def self.validate!(input, context:)
          Validators::Message.validate!(input, context: context) unless input.nil?
        end
      end

      class Fire
        def self.validate!(input, context:)
          Validators::Message.validate!(input, context: context) unless input.nil?
        end
      end

      class Health
        def self.validate!(input, context:)
          Validators::Message.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class Baz
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Baz, context: context)
        Hearth::Validator.validate_types!(input[:baz], ::String, context: "#{context}[:baz]")
        Hearth::Validator.validate_types!(input[:bar], ::String, context: "#{context}[:bar]")
      end
    end

    class CityCoordinates
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::CityCoordinates, context: context)
        Hearth::Validator.validate_required!(input[:latitude], context: "#{context}[:latitude]")
        Hearth::Validator.validate_types!(input[:latitude], ::Float, context: "#{context}[:latitude]")
        Hearth::Validator.validate_required!(input[:longitude], context: "#{context}[:longitude]")
        Hearth::Validator.validate_types!(input[:longitude], ::Float, context: "#{context}[:longitude]")
      end
    end

    class CitySummaries
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          CitySummary.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class CitySummary
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::CitySummary, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
        Hearth::Validator.validate_required!(input[:name], context: "#{context}[:name]")
        Hearth::Validator.validate_types!(input[:name], ::String, context: "#{context}[:name]")
        Hearth::Validator.validate_types!(input[:number], ::String, context: "#{context}[:number]")
        Hearth::Validator.validate_types!(input[:case], ::String, context: "#{context}[:case]")
      end
    end

    class Foo
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Foo, context: context)
        Hearth::Validator.validate_types!(input[:baz], ::String, context: "#{context}[:baz]")
        Hearth::Validator.validate_types!(input[:bar], ::String, context: "#{context}[:bar]")
      end
    end

    class GetCityAnnouncementsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityAnnouncementsInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetCityAnnouncementsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityAnnouncementsOutput, context: context)
        Hearth::Validator.validate_types!(input[:last_updated], ::Time, context: "#{context}[:last_updated]")
        Announcements.validate!(input[:announcements], context: "#{context}[:announcements]") unless input[:announcements].nil?
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

    class GetCityImageOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityImageOutput, context: context)
        Hearth::Validator.validate_required!(input[:image], context: "#{context}[:image]")
        unless input[:image].respond_to?(:read) || input[:image].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:image].class}"
        end
      end
    end

    class GetCityInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetCityOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCityOutput, context: context)
        Hearth::Validator.validate_required!(input[:name], context: "#{context}[:name]")
        Hearth::Validator.validate_types!(input[:name], ::String, context: "#{context}[:name]")
        Hearth::Validator.validate_required!(input[:coordinates], context: "#{context}[:coordinates]")
        CityCoordinates.validate!(input[:coordinates], context: "#{context}[:coordinates]") unless input[:coordinates].nil?
        CitySummary.validate!(input[:city], context: "#{context}[:city]") unless input[:city].nil?
      end
    end

    class GetCurrentTimeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCurrentTimeInput, context: context)
      end
    end

    class GetCurrentTimeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetCurrentTimeOutput, context: context)
        Hearth::Validator.validate_required!(input[:time], context: "#{context}[:time]")
        Hearth::Validator.validate_types!(input[:time], ::Time, context: "#{context}[:time]")
      end
    end

    class GetForecastInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetForecastInput, context: context)
        Hearth::Validator.validate_required!(input[:city_id], context: "#{context}[:city_id]")
        Hearth::Validator.validate_types!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetForecastOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetForecastOutput, context: context)
        Hearth::Validator.validate_types!(input[:chance_of_rain], ::Float, context: "#{context}[:chance_of_rain]")
        Precipitation.validate!(input[:precipitation], context: "#{context}[:precipitation]") unless input[:precipitation].nil?
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

    class ListCitiesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ListCitiesOutput, context: context)
        Hearth::Validator.validate_types!(input[:next_token], ::String, context: "#{context}[:next_token]")
        Hearth::Validator.validate_types!(input[:some_enum], ::String, context: "#{context}[:some_enum]")
        Hearth::Validator.validate_types!(input[:a_string], ::String, context: "#{context}[:a_string]")
        Hearth::Validator.validate_types!(input[:default_bool], ::TrueClass, ::FalseClass, context: "#{context}[:default_bool]")
        Hearth::Validator.validate_types!(input[:boxed_bool], ::TrueClass, ::FalseClass, context: "#{context}[:boxed_bool]")
        Hearth::Validator.validate_types!(input[:default_number], ::Integer, context: "#{context}[:default_number]")
        Hearth::Validator.validate_types!(input[:boxed_number], ::Integer, context: "#{context}[:boxed_number]")
        Hearth::Validator.validate_required!(input[:items], context: "#{context}[:items]")
        CitySummaries.validate!(input[:items], context: "#{context}[:items]") unless input[:items].nil?
        SparseCitySummaries.validate!(input[:sparse_items], context: "#{context}[:sparse_items]") unless input[:sparse_items].nil?
      end
    end

    class Message
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Message, context: context)
        Hearth::Validator.validate_types!(input[:message], ::String, context: "#{context}[:message]")
        Hearth::Validator.validate_types!(input[:author], ::String, context: "#{context}[:author]")
      end
    end

    class NoSuchResource
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoSuchResource, context: context)
        Hearth::Validator.validate_required!(input[:resource_type], context: "#{context}[:resource_type]")
        Hearth::Validator.validate_types!(input[:resource_type], ::String, context: "#{context}[:resource_type]")
        Hearth::Validator.validate_types!(input[:message], ::String, context: "#{context}[:message]")
      end
    end

    class OtherStructure
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OtherStructure, context: context)
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

    class Precipitation
      def self.validate!(input, context:)
        case input
        when Types::Precipitation::Rain
          Hearth::Validator.validate_types!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::Precipitation::Sleet
          Hearth::Validator.validate_types!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::Precipitation::Hail
          StringMap.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Precipitation::Snow
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::Precipitation::Mixed
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::Precipitation::Other
          OtherStructure.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Precipitation::Blob
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::Precipitation::Foo
          Foo.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Precipitation::Baz
          Baz.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::Precipitation, got #{input.class}."
        end
      end

      class Rain
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class Sleet
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class Hail
        def self.validate!(input, context:)
          Validators::StringMap.validate!(input, context: context) unless input.nil?
        end
      end

      class Snow
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class Mixed
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class Other
        def self.validate!(input, context:)
          Validators::OtherStructure.validate!(input, context: context) unless input.nil?
        end
      end

      class Blob
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class Foo
        def self.validate!(input, context:)
          Validators::Foo.validate!(input, context: context) unless input.nil?
        end
      end

      class Baz
        def self.validate!(input, context:)
          Validators::Baz.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class SparseCitySummaries
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          CitySummary.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class StringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
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

    class Struct____789BadNameOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Struct____789BadNameOutput, context: context)
        Hearth::Validator.validate_required!(input[:member___123abc], context: "#{context}[:member___123abc]")
        Hearth::Validator.validate_types!(input[:member___123abc], ::String, context: "#{context}[:member___123abc]")
        Struct____456efg.validate!(input[:member], context: "#{context}[:member]") unless input[:member].nil?
      end
    end

  end
end
