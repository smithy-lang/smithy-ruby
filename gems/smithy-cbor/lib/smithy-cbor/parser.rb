# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # @api private
    class Parser
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def parse(shape, bytes, target = nil)
        return {} if bytes.empty?

        ref = shape.is_a?(MemberShape) ? shape : MemberShape.new(target: shape)
        shape(ref, Cbor.decode(bytes), target)
      end

      private

      def shape(ref, value, target = nil)
        return nil if value.nil?

        case ref.target
        when ListShape then list(ref, value, target)
        when MapShape then map(ref, value, target)
        when StructureShape then structure(ref, value, target)
        when UnionShape then union(ref, value, target)
        else value
        end
      end

      def list(ref, values, target = nil)
        target = [] if target.nil?
        values.each do |value|
          next if value.nil? && !sparse?(ref.target)

          target << shape(ref.target.member, value)
        end
        target
      end

      def map(ref, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(ref.target)

          target[key] = shape(ref.target.value, value)
        end
        target
      end

      def structure(ref, values, target = nil)
        target = ref.target.type.new if target.nil?
        ref.target.members.each do |member_name, member_ref|
          value = values[member_ref.location_name]
          target[member_name] = shape(member_ref, value) unless value.nil?
        end
        target
      end

      def union(ref, values, target = nil) # rubocop:disable Metrics/AbcSize
        ref.target.members.each do |member_name, member_ref|
          value = values[member_ref.location_name]
          next if value.nil?

          target = ref.target.member_type(member_name) if target.nil?
          return target.new(member_name => shape(member_ref, value))
        end

        values.delete('__type')
        key, value = values.first
        ref.target.member_type(:unknown).new(unknown: { key => value })
      end

      def sparse?(shape)
        shape.traits.key?('smithy.api#sparse')
      end
    end
  end
end
