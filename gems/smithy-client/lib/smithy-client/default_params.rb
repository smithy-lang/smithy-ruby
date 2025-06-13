# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Client
    # @api private
    class DefaultParams
      include Schema::Shapes

      def initialize(ref)
        @ref = ref
      end

      # @param [Hash] params
      # @return [Hash]
      def apply(params)
        structure(@ref, params)
      end

      private

      def shape(ref, value)
        case ref.shape
        when ListShape then list(ref, value)
        when MapShape then map(ref, value)
        when StructureShape then structure(ref, value)
        else value
        end
      end

      def list(ref, values)
        return if values.nil?

        shape = ref.shape
        values.each do |value|
          shape(shape.member, value)
        end
        values
      end

      def map(ref, values)
        return if values.nil?

        shape = ref.shape
        values.each_pair do |_key, value|
          shape(shape.value, value)
        end
        values
      end

      def structure(ref, values)
        return if values.nil?

        ref.shape.members.each do |member_name, member_ref|
          value = values[member_name]
          value ||= default(member_ref) if default?(ref, member_ref.traits)
          next if value.nil?

          values[member_name] = shape(member_ref, value)
        end
        values
      end

      def default?(ref, traits)
        # skip defaults for top level members
        return false if ref == @ref

        traits.include?('smithy.api#default') && !traits.include?('smithy.api#clientOptional')
      end

      def default(ref)
        trait = ref.traits['smithy.api#default']
        case ref.shape
        when BlobShape then Base64.strict_decode64(trait)
        when TimestampShape
          case trait
          when String then Time.parse(trait)
          when Integer then Time.at(trait)
          else raise ArgumentError, "Invalid default value for Timestamp: #{trait.inspect}"
          end
        else trait
        end
      end
    end
  end
end
