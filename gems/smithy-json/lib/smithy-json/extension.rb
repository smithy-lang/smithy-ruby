# frozen_string_literal: true

module Smithy
  module Json
    # JSON-specific lookup helpers and cached serde metadata.
    #
    # Raw Smithy trait data remains on +member.traits+ with string keys.
    # Resolved JSON values are cached as flat, JSON-prefixed keys on their
    # owning shape or member.
    # @api private
    module Extension
      class << self
        # Returns the JSON parse lookup index cached on a structure or union.
        #
        # Example:
        #   Extension.wire_index(shape)['wireName']
        #   # => [:ruby_name, member]
        def wire_index(shape)
          shape[:json_wire_index] || resolve_indexes(shape, :json_wire_index)
        end

        # Returns the JSON build lookup index cached on a structure or union.
        #
        # Example:
        #   Extension.member_index(shape)[:ruby_name]
        #   # => ['wireName', member]
        def member_index(shape)
          shape[:json_member_index] || resolve_indexes(shape, :json_member_index)
        end

        # Returns the effective JSON member name.
        #
        # Example:
        #   Extension.wire_name(member)
        #   # => 'wireName'
        def wire_name(member)
          member.fetch_metadata(:json_name) do
            member.traits['smithy.api#jsonName'] || member.name
          end
        end

        # Returns the resolved timestamp format for JSON serialization.
        #
        # Example:
        #   Extension.timestamp_format(member)
        #   # => 'epoch-seconds'
        def timestamp_format(shape)
          Schema::Extension.timestamp_format(shape)
        end

        private

        def resolve_indexes(shape, result)
          wire_index = {}
          member_index = {}
          Schema::Extension.each_member(shape) do |member_name, member_shape|
            json_name = wire_name(member_shape)
            wire_index[json_name] = [member_name, member_shape].freeze
            member_index[member_name] = [json_name, member_shape].freeze
          end

          wire_index.freeze
          member_index.freeze
          shape[:json_wire_index] = wire_index
          shape[:json_member_index] = member_index
          result == :json_wire_index ? wire_index : member_index
        end
      end
    end
  end
end
