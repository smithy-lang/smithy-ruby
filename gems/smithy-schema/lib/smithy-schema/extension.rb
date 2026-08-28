# frozen_string_literal: true

module Smithy
  module Schema
    # Lookup helpers for protocol-agnostic serde using modeled member names.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module only provides generic modeled-name lookup
    # helpers and memoizes shape-level indexes in metadata when that
    # meaningfully avoids rebuilding them.
    # - +shape[:wire_index]+ caches the modeled wire-name lookup index for a shape
    # - +shape[:member_index]+ caches the modeled build lookup index for a shape
    # - +shape[:timestamp_format]+ caches the resolved explicit timestamp format
    #   for a member or target shape, or +:default+ when the model does not
    #   override the protocol default
    # @api private
    module Extension
      class << self
        # Returns the modeled member lookup index cached on the shape as
        # +shape[:wire_index]+.
        #
        # The index maps:
        # - modeled member name
        # - to [ruby_member_name, member_shape]
        def wire_index(shape)
          shape[:wire_index] ||= build_wire_index(shape)
        end

        # Returns the modeled build lookup index cached on the shape as
        # +shape[:member_index]+.
        #
        # The index maps:
        # - ruby member name
        # - to [modeled wire name, member_shape]
        def member_index(shape)
          shape[:member_index] ||= build_member_index(shape)
        end

        # Returns the modeled member name for schema lookup.
        def wire_name(member)
          member.name
        end

        # Returns the resolved explicit timestamp format for a member/target
        # shape, or +:default+ when the model does not override the protocol
        # default.
        def timestamp_format(shape)
          shape[:timestamp_format] ||=
            shape.traits['smithy.api#timestampFormat'] ||
            shape.target.traits['smithy.api#timestampFormat'] ||
            :default
        end

        private

        def build_wire_index(shape)
          index = {}
          shape.members.each do |name, member|
            wire_name = wire_name(member)
            next unless wire_name

            index[wire_name] = [name, member]
          end
          index.freeze
        end

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            wire_name = wire_name(member)
            next unless wire_name

            index[name] = [wire_name, member]
          end
          index.freeze
        end
      end
    end
  end
end
