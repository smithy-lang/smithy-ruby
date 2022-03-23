# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Validators

    class Announcements
      def self.validate!(input, context:)
        case input
        when Types::Announcements::Police
          Validators::Message.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Announcements::Fire
          Validators::Message.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Announcements::Health
          Validators::Message.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
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
        Hearth::Validator.validate!(input, Types::Baz, context: context)
        Hearth::Validator.validate!(input[:baz], ::String, context: "#{context}[:baz]")
        Hearth::Validator.validate!(input[:bar], ::String, context: "#{context}[:bar]")
      end
    end

    class CityCoordinates
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::CityCoordinates, context: context)
        Hearth::Validator.validate!(input[:latitude], ::Float, context: "#{context}[:latitude]")
        Hearth::Validator.validate!(input[:longitude], ::Float, context: "#{context}[:longitude]")
      end
    end

    class CitySummaries
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::CitySummary.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class CitySummary
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::CitySummary, context: context)
        Hearth::Validator.validate!(input[:city_id], ::String, context: "#{context}[:city_id]")
        Hearth::Validator.validate!(input[:name], ::String, context: "#{context}[:name]")
        Hearth::Validator.validate!(input[:number], ::String, context: "#{context}[:number]")
        Hearth::Validator.validate!(input[:case], ::String, context: "#{context}[:case]")
      end
    end

    class Foo
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Foo, context: context)
        Hearth::Validator.validate!(input[:baz], ::String, context: "#{context}[:baz]")
        Hearth::Validator.validate!(input[:bar], ::String, context: "#{context}[:bar]")
      end
    end

    class GetCityAnnouncementsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCityAnnouncementsInput, context: context)
        Hearth::Validator.validate!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetCityAnnouncementsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCityAnnouncementsOutput, context: context)
        Hearth::Validator.validate!(input[:last_updated], ::Time, context: "#{context}[:last_updated]")
        Validators::Announcements.validate!(input[:announcements], context: "#{context}[:announcements]") unless input[:announcements].nil?
      end
    end

    class GetCityImageInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCityImageInput, context: context)
        Hearth::Validator.validate!(input[:city_id], ::String, context: "#{context}[:city_id]")
        Validators::ImageType.validate!(input[:image_type], context: "#{context}[:image_type]") unless input[:image_type].nil?
      end
    end

    class GetCityImageOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCityImageOutput, context: context)
        Hearth::Validator.validate!(input[:image], ::String, context: "#{context}[:image]")
      end
    end

    class GetCityInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCityInput, context: context)
        Hearth::Validator.validate!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetCityOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCityOutput, context: context)
        Hearth::Validator.validate!(input[:name], ::String, context: "#{context}[:name]")
        Validators::CityCoordinates.validate!(input[:coordinates], context: "#{context}[:coordinates]") unless input[:coordinates].nil?
        Validators::CitySummary.validate!(input[:city], context: "#{context}[:city]") unless input[:city].nil?
      end
    end

    class GetCurrentTimeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCurrentTimeInput, context: context)
      end
    end

    class GetCurrentTimeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetCurrentTimeOutput, context: context)
        Hearth::Validator.validate!(input[:time], ::Time, context: "#{context}[:time]")
      end
    end

    class GetForecastInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetForecastInput, context: context)
        Hearth::Validator.validate!(input[:city_id], ::String, context: "#{context}[:city_id]")
      end
    end

    class GetForecastOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetForecastOutput, context: context)
        Hearth::Validator.validate!(input[:chance_of_rain], ::Float, context: "#{context}[:chance_of_rain]")
        Validators::Precipitation.validate!(input[:precipitation], context: "#{context}[:precipitation]") unless input[:precipitation].nil?
      end
    end

    class ImageType
      def self.validate!(input, context:)
        case input
        when Types::ImageType::Raw
          Hearth::Validator.validate!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::ImageType::Png
          Validators::PNGImage.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::ImageType, got #{input.class}."
        end
      end

      class Raw
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::TrueClass, ::FalseClass, context: context)
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
        Hearth::Validator.validate!(input, Types::ListCitiesInput, context: context)
        Hearth::Validator.validate!(input[:next_token], ::String, context: "#{context}[:next_token]")
        Hearth::Validator.validate!(input[:a_string], ::String, context: "#{context}[:a_string]")
        Hearth::Validator.validate!(input[:default_bool], ::TrueClass, ::FalseClass, context: "#{context}[:default_bool]")
        Hearth::Validator.validate!(input[:boxed_bool], ::TrueClass, ::FalseClass, context: "#{context}[:boxed_bool]")
        Hearth::Validator.validate!(input[:default_number], ::Integer, context: "#{context}[:default_number]")
        Hearth::Validator.validate!(input[:boxed_number], ::Integer, context: "#{context}[:boxed_number]")
        Hearth::Validator.validate!(input[:some_enum], ::String, context: "#{context}[:some_enum]")
        Hearth::Validator.validate!(input[:page_size], ::Integer, context: "#{context}[:page_size]")
      end
    end

    class ListCitiesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ListCitiesOutput, context: context)
        Hearth::Validator.validate!(input[:next_token], ::String, context: "#{context}[:next_token]")
        Hearth::Validator.validate!(input[:some_enum], ::String, context: "#{context}[:some_enum]")
        Hearth::Validator.validate!(input[:a_string], ::String, context: "#{context}[:a_string]")
        Hearth::Validator.validate!(input[:default_bool], ::TrueClass, ::FalseClass, context: "#{context}[:default_bool]")
        Hearth::Validator.validate!(input[:boxed_bool], ::TrueClass, ::FalseClass, context: "#{context}[:boxed_bool]")
        Hearth::Validator.validate!(input[:default_number], ::Integer, context: "#{context}[:default_number]")
        Hearth::Validator.validate!(input[:boxed_number], ::Integer, context: "#{context}[:boxed_number]")
        Validators::CitySummaries.validate!(input[:items], context: "#{context}[:items]") unless input[:items].nil?
        Validators::SparseCitySummaries.validate!(input[:sparse_items], context: "#{context}[:sparse_items]") unless input[:sparse_items].nil?
      end
    end

    class Message
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Message, context: context)
        Hearth::Validator.validate!(input[:message], ::String, context: "#{context}[:message]")
        Hearth::Validator.validate!(input[:author], ::String, context: "#{context}[:author]")
      end
    end

    class NoSuchResource
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NoSuchResource, context: context)
        Hearth::Validator.validate!(input[:resource_type], ::String, context: "#{context}[:resource_type]")
        Hearth::Validator.validate!(input[:message], ::String, context: "#{context}[:message]")
      end
    end

    class OtherStructure
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::OtherStructure, context: context)
      end
    end

    class PNGImage
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::PNGImage, context: context)
        Hearth::Validator.validate!(input[:height], ::Integer, context: "#{context}[:height]")
        Hearth::Validator.validate!(input[:width], ::Integer, context: "#{context}[:width]")
      end
    end

    class Precipitation
      def self.validate!(input, context:)
        case input
        when Types::Precipitation::Rain
          Hearth::Validator.validate!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::Precipitation::Sleet
          Hearth::Validator.validate!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::Precipitation::Hail
          Validators::StringMap.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Precipitation::Snow
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::Precipitation::Mixed
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::Precipitation::Other
          Validators::OtherStructure.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Precipitation::Blob
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::Precipitation::Foo
          Validators::Foo.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Precipitation::Baz
          Validators::Baz.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::Precipitation, got #{input.class}."
        end
      end

      class Rain
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class Sleet
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class Hail
        def self.validate!(input, context:)
          Validators::StringMap.validate!(input, context: context) unless input.nil?
        end
      end

      class Snow
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
        end
      end

      class Mixed
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
        end
      end

      class Other
        def self.validate!(input, context:)
          Validators::OtherStructure.validate!(input, context: context) unless input.nil?
        end
      end

      class Blob
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
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
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::CitySummary.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class StringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class Struct____456efg
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____456efg, context: context)
        Hearth::Validator.validate!(input[:member____123foo], ::String, context: "#{context}[:member____123foo]")
      end
    end

    class Struct____789BadNameInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____789BadNameInput, context: context)
        Hearth::Validator.validate!(input[:member____123abc], ::String, context: "#{context}[:member____123abc]")
        Validators::Struct____456efg.validate!(input[:member], context: "#{context}[:member]") unless input[:member].nil?
      end
    end

    class Struct____789BadNameOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____789BadNameOutput, context: context)
        Hearth::Validator.validate!(input[:member____123abc], ::String, context: "#{context}[:member____123abc]")
        Validators::Struct____456efg.validate!(input[:member], context: "#{context}[:member]") unless input[:member].nil?
      end
    end

  end
end
