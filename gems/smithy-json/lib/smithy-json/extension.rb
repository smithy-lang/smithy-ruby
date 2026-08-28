# frozen_string_literal: true

module Smithy
  module Json
    # Lookup helpers for JSON serde using Smithy traits that affect JSON
    # wire names.
    #
    # Raw Smithy trait data remains on +member.traits+ with string keys. This
    # module resolves JSON-specific serde behavior on demand and stores the
    # resolved values in metadata:
    # - +member[:json_name]+ caches the resolved JSON wire name for a member
    # - +shape[:json_wire_index]+ caches the JSON wire-name lookup index for a shape
    # - +shape[:json_member_index]+ caches the JSON build lookup index for a shape
    # @api private
    module Extension
      class << self
        # Returns the JSON member lookup index cached on the shape as
        # +shape[:json_wire_index]+.
        #
        # The index maps:
        # - resolved JSON wire name
        # - to [ruby_member_name, member_shape]
        def wire_index(shape)
          shape[:json_wire_index] ||= build_wire_index(shape)
        end

        # Returns the JSON build lookup index cached on the shape as
        # +shape[:json_member_index]+.
        #
        # The index maps:
        # - ruby member name
        # - to [resolved JSON wire name, member_shape]
        def member_index(shape)
          shape[:json_member_index] ||= build_member_index(shape)
        end

        # Returns the resolved JSON wire name for the member, cached as
        # +member[:json_name]+ and preferring the Smithy @jsonName trait.
        def wire_name(member)
          member[:json_name] ||= member.traits['smithy.api#jsonName'] || member.name
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
