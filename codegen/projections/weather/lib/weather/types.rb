# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Types

    class Announcements < Hearth::Union

      class Police < Announcements
        def to_h
          { police: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Police #{__getobj__ || 'nil'}>"
        end
      end

      class Fire < Announcements
        def to_h
          { fire: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Fire #{__getobj__ || 'nil'}>"
        end
      end

      class Health < Announcements
        def to_h
          { health: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Health #{__getobj__ || 'nil'}>"
        end
      end

      # Handles unknown future members
      #
      class Unknown < Announcements
        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!attribute baz
    #
    #   @return [String]
    #
    # @!attribute bar
    #
    #   @return [String]
    #
    Baz = ::Struct.new(
      :baz,
      :bar,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute latitude
    #
    #   @return [Float]
    #
    # @!attribute longitude
    #
    #   @return [Float]
    #
    CityCoordinates = ::Struct.new(
      :latitude,
      :longitude,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute city_id
    #
    #   @return [String]
    #
    # @!attribute member_name
    #
    #   @return [String]
    #
    # @!attribute number
    #
    #   @return [String]
    #
    # @!attribute case
    #
    #   @return [String]
    #
    CitySummary = ::Struct.new(
      :city_id,
      :member_name,
      :number,
      :case,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute baz
    #
    #   @return [String]
    #
    # @!attribute bar
    #
    #   @return [String]
    #
    Foo = ::Struct.new(
      :baz,
      :bar,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute city_id
    #
    #   @return [String]
    #
    GetCityAnnouncementsInput = ::Struct.new(
      :city_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute last_updated
    #
    #   @return [Time]
    #
    # @!attribute announcements
    #
    #   @return [Announcements]
    #
    GetCityAnnouncementsOutput = ::Struct.new(
      :last_updated,
      :announcements,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute city_id
    #
    #   @return [String]
    #
    # @!attribute image_type
    #
    #   @return [ImageType]
    #
    GetCityImageInput = ::Struct.new(
      :city_id,
      :image_type,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute image
    #
    #   @return [String]
    #
    GetCityImageOutput = ::Struct.new(
      :image,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # The input used to get a city.
    #
    # @!attribute city_id
    #
    #   @return [String]
    #
    GetCityInput = ::Struct.new(
      :city_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member_name
    #
    #   @return [String]
    #
    # @!attribute coordinates
    #
    #   @return [CityCoordinates]
    #
    # @!attribute city
    #
    #   @return [CitySummary]
    #
    GetCityOutput = ::Struct.new(
      :member_name,
      :coordinates,
      :city,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    GetCurrentTimeInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute time
    #
    #   @return [Time]
    #
    GetCurrentTimeOutput = ::Struct.new(
      :time,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute city_id
    #
    #   @return [String]
    #
    GetForecastInput = ::Struct.new(
      :city_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute chance_of_rain
    #
    #   @return [Float]
    #
    # @!attribute precipitation
    #
    #   @return [Precipitation]
    #
    GetForecastOutput = ::Struct.new(
      :chance_of_rain,
      :precipitation,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class ImageType < Hearth::Union

      class Raw < ImageType
        def to_h
          { raw: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Raw #{__getobj__ || 'nil'}>"
        end
      end

      class Png < ImageType
        def to_h
          { png: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Png #{__getobj__ || 'nil'}>"
        end
      end

      # Handles unknown future members
      #
      class Unknown < ImageType
        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!attribute next_token
    #
    #   @return [String]
    #
    # @!attribute a_string
    #
    #   @return [String]
    #
    # @!attribute default_bool
    #
    #   @return [Boolean]
    #
    # @!attribute boxed_bool
    #
    #   @return [Boolean]
    #
    # @!attribute default_number
    #
    #   @return [Integer]
    #
    # @!attribute boxed_number
    #
    #   @return [Integer]
    #
    # @!attribute some_enum
    #
    #   @return [String]
    #
    # @!attribute page_size
    #
    #   @return [Integer]
    #
    ListCitiesInput = ::Struct.new(
      :next_token,
      :a_string,
      :default_bool,
      :boxed_bool,
      :default_number,
      :boxed_number,
      :some_enum,
      :page_size,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute next_token
    #
    #   @return [String]
    #
    # @!attribute some_enum
    #
    #   @return [String]
    #
    # @!attribute a_string
    #
    #   @return [String]
    #
    # @!attribute default_bool
    #
    #   @return [Boolean]
    #
    # @!attribute boxed_bool
    #
    #   @return [Boolean]
    #
    # @!attribute default_number
    #
    #   @return [Integer]
    #
    # @!attribute boxed_number
    #
    #   @return [Integer]
    #
    # @!attribute items
    #
    #   @return [Array<CitySummary>]
    #
    # @!attribute sparse_items
    #
    #   @return [Array<CitySummary>]
    #
    ListCitiesOutput = ::Struct.new(
      :next_token,
      :some_enum,
      :a_string,
      :default_bool,
      :boxed_bool,
      :default_number,
      :boxed_number,
      :items,
      :sparse_items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute message
    #
    #   @return [String]
    #
    # @!attribute author
    #
    #   @return [String]
    #
    Message = ::Struct.new(
      :message,
      :author,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Error encountered when no resource could be found.
    #
    # @!attribute resource_type
    #   The type of resource that was not found.
    #
    #   @return [String]
    #
    # @!attribute message
    #
    #   @return [String]
    #
    NoSuchResource = ::Struct.new(
      :resource_type,
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    OtherStructure = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute height
    #
    #   @return [Integer]
    #
    # @!attribute width
    #
    #   @return [Integer]
    #
    PNGImage = ::Struct.new(
      :height,
      :width,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Precipitation < Hearth::Union

      class Rain < Precipitation
        def to_h
          { rain: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Rain #{__getobj__ || 'nil'}>"
        end
      end

      class Sleet < Precipitation
        def to_h
          { sleet: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Sleet #{__getobj__ || 'nil'}>"
        end
      end

      class Hail < Precipitation
        def to_h
          { hail: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Hail #{__getobj__ || 'nil'}>"
        end
      end

      class Snow < Precipitation
        def to_h
          { snow: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Snow #{__getobj__ || 'nil'}>"
        end
      end

      class Mixed < Precipitation
        def to_h
          { mixed: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Mixed #{__getobj__ || 'nil'}>"
        end
      end

      class Other < Precipitation
        def to_h
          { other: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Other #{__getobj__ || 'nil'}>"
        end
      end

      class Blob < Precipitation
        def to_h
          { blob: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Blob #{__getobj__ || 'nil'}>"
        end
      end

      class Foo < Precipitation
        def to_h
          { foo: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Foo #{__getobj__ || 'nil'}>"
        end
      end

      class Baz < Precipitation
        def to_h
          { baz: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Baz #{__getobj__ || 'nil'}>"
        end
      end

      # Handles unknown future members
      #
      class Unknown < Precipitation
        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<Weather::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!attribute member____123foo
    #
    #   @return [String]
    #
    Struct____456efg = ::Struct.new(
      :member____123foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member____123abc
    #
    #   @return [String]
    #
    # @!attribute member
    #
    #   @return [Struct____456efg]
    #
    Struct____789BadNameInput = ::Struct.new(
      :member____123abc,
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member____123abc
    #
    #   @return [String]
    #
    # @!attribute member
    #
    #   @return [Struct____456efg]
    #
    Struct____789BadNameOutput = ::Struct.new(
      :member____123abc,
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
