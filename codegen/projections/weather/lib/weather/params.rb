# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Params

    module Announcements
      def self.build(params, context: '')
        return params if params.is_a?(Types::Announcements)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Announcements, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :police
          Types::Announcements::Police.new(
            (Message.build(params[:police], context: "#{context}[:police]") unless params[:police].nil?)
          )
        when :fire
          Types::Announcements::Fire.new(
            (Message.build(params[:fire], context: "#{context}[:fire]") unless params[:fire].nil?)
          )
        when :health
          Types::Announcements::Health.new(
            (Message.build(params[:health], context: "#{context}[:health]") unless params[:health].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :police, :fire, :health set"
        end
      end
    end

    module Baz
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::Baz, context: context)
        type = Types::Baz.new
        type.baz = params[:baz]
        type.bar = params[:bar]
        type
      end
    end

    module CityCoordinates
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::CityCoordinates, context: context)
        type = Types::CityCoordinates.new
        type.latitude = params.key?(:latitude) ? params[:latitude] : 0
        type.longitude = params[:longitude]
        type
      end
    end

    module CitySummaries
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << CitySummary.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module CitySummary
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::CitySummary, context: context)
        type = Types::CitySummary.new
        type.city_id = params[:city_id]
        type.name = params[:name]
        type.number = params[:number]
        type.case = params[:case]
        type
      end
    end

    module Foo
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::Foo, context: context)
        type = Types::Foo.new
        type.baz = params[:baz]
        type.bar = params[:bar]
        type
      end
    end

    module GetCityAnnouncementsInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCityAnnouncementsInput, context: context)
        type = Types::GetCityAnnouncementsInput.new
        type.city_id = params[:city_id]
        type
      end
    end

    module GetCityAnnouncementsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCityAnnouncementsOutput, context: context)
        type = Types::GetCityAnnouncementsOutput.new
        type.last_updated = params[:last_updated]
        type.announcements = Announcements.build(params[:announcements], context: "#{context}[:announcements]") unless params[:announcements].nil?
        type
      end
    end

    module GetCityImageInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCityImageInput, context: context)
        type = Types::GetCityImageInput.new
        type.city_id = params[:city_id]
        type.image_type = ImageType.build(params[:image_type], context: "#{context}[:image_type]") unless params[:image_type].nil?
        type.resolution = params[:resolution]
        type
      end
    end

    module GetCityImageOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCityImageOutput, context: context)
        type = Types::GetCityImageOutput.new
        io = params[:image] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.image = io
        type
      end
    end

    module GetCityInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCityInput, context: context)
        type = Types::GetCityInput.new
        type.city_id = params[:city_id]
        type
      end
    end

    module GetCityOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCityOutput, context: context)
        type = Types::GetCityOutput.new
        type.name = params[:name]
        type.coordinates = CityCoordinates.build(params[:coordinates], context: "#{context}[:coordinates]") unless params[:coordinates].nil?
        type.city = CitySummary.build(params[:city], context: "#{context}[:city]") unless params[:city].nil?
        type
      end
    end

    module GetCurrentTimeInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCurrentTimeInput, context: context)
        type = Types::GetCurrentTimeInput.new
        type
      end
    end

    module GetCurrentTimeOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetCurrentTimeOutput, context: context)
        type = Types::GetCurrentTimeOutput.new
        type.time = params[:time]
        type
      end
    end

    module GetForecastInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetForecastInput, context: context)
        type = Types::GetForecastInput.new
        type.city_id = params[:city_id]
        type
      end
    end

    module GetForecastOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetForecastOutput, context: context)
        type = Types::GetForecastOutput.new
        type.chance_of_rain = params[:chance_of_rain]
        type.precipitation = Precipitation.build(params[:precipitation], context: "#{context}[:precipitation]") unless params[:precipitation].nil?
        type
      end
    end

    module ImageType
      def self.build(params, context: '')
        return params if params.is_a?(Types::ImageType)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ImageType, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :raw
          Types::ImageType::Raw.new(
            params[:raw]
          )
        when :png
          Types::ImageType::Png.new(
            (PNGImage.build(params[:png], context: "#{context}[:png]") unless params[:png].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :raw, :png set"
        end
      end
    end

    module ListCitiesInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::ListCitiesInput, context: context)
        type = Types::ListCitiesInput.new
        type.next_token = params[:next_token]
        type.a_string = params[:a_string]
        type.default_bool = params[:default_bool]
        type.boxed_bool = params[:boxed_bool]
        type.default_number = params[:default_number]
        type.boxed_number = params[:boxed_number]
        type.some_enum = params[:some_enum]
        type.page_size = params[:page_size]
        type
      end
    end

    module ListCitiesOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::ListCitiesOutput, context: context)
        type = Types::ListCitiesOutput.new
        type.next_token = params[:next_token]
        type.some_enum = params[:some_enum]
        type.a_string = params[:a_string]
        type.default_bool = params[:default_bool]
        type.boxed_bool = params[:boxed_bool]
        type.default_number = params[:default_number]
        type.boxed_number = params[:boxed_number]
        type.items = CitySummaries.build(params[:items], context: "#{context}[:items]") unless params[:items].nil?
        type.sparse_items = SparseCitySummaries.build(params[:sparse_items], context: "#{context}[:sparse_items]") unless params[:sparse_items].nil?
        type
      end
    end

    module Message
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::Message, context: context)
        type = Types::Message.new
        type.message = params[:message]
        type.author = params[:author]
        type
      end
    end

    module NoSuchResource
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoSuchResource, context: context)
        type = Types::NoSuchResource.new
        type.resource_type = params[:resource_type]
        type.message = params[:message]
        type
      end
    end

    module OtherStructure
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::OtherStructure, context: context)
        type = Types::OtherStructure.new
        type
      end
    end

    module PNGImage
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::PNGImage, context: context)
        type = Types::PNGImage.new
        type.height = params[:height]
        type.width = params[:width]
        type
      end
    end

    module Precipitation
      def self.build(params, context: '')
        return params if params.is_a?(Types::Precipitation)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Precipitation, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :rain
          Types::Precipitation::Rain.new(
            params[:rain]
          )
        when :sleet
          Types::Precipitation::Sleet.new(
            params[:sleet]
          )
        when :hail
          Types::Precipitation::Hail.new(
            (StringMap.build(params[:hail], context: "#{context}[:hail]") unless params[:hail].nil?)
          )
        when :snow
          Types::Precipitation::Snow.new(
            params[:snow]
          )
        when :mixed
          Types::Precipitation::Mixed.new(
            params[:mixed]
          )
        when :other
          Types::Precipitation::Other.new(
            (OtherStructure.build(params[:other], context: "#{context}[:other]") unless params[:other].nil?)
          )
        when :blob
          Types::Precipitation::Blob.new(
            params[:blob]
          )
        when :foo
          Types::Precipitation::Foo.new(
            (Foo.build(params[:foo], context: "#{context}[:foo]") unless params[:foo].nil?)
          )
        when :baz
          Types::Precipitation::Baz.new(
            (Baz.build(params[:baz], context: "#{context}[:baz]") unless params[:baz].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :rain, :sleet, :hail, :snow, :mixed, :other, :blob, :foo, :baz set"
        end
      end
    end

    module SparseCitySummaries
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << (CitySummary.build(element, context: "#{context}[#{index}]") unless element.nil?)
        end
        data
      end
    end

    module StringMap
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module Struct____456efg
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::Struct____456efg, context: context)
        type = Types::Struct____456efg.new
        type.member___123foo = params[:member___123foo]
        type
      end
    end

    module Struct____789BadNameInput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::Struct____789BadNameInput, context: context)
        type = Types::Struct____789BadNameInput.new
        type.member___123abc = params[:member___123abc]
        type.member = Struct____456efg.build(params[:member], context: "#{context}[:member]") unless params[:member].nil?
        type
      end
    end

    module Struct____789BadNameOutput
      def self.build(params, context: '')
        Hearth::Validator.validate_types!(params, ::Hash, Types::Struct____789BadNameOutput, context: context)
        type = Types::Struct____789BadNameOutput.new
        type.member___123abc = params[:member___123abc]
        type.member = Struct____456efg.build(params[:member], context: "#{context}[:member]") unless params[:member].nil?
        type
      end
    end

  end
end
