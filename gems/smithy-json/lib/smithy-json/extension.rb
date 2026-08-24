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
    # - +shape[:json_index]+ caches the JSON wire-name lookup index for a shape
    # @api private
    module Extension
      class << self
        # Returns the JSON member lookup index cached on the shape as
        # +shape[:json_index]+.
        #
        # The index maps:
        # - resolved JSON wire name
        # - to [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:json_index] ||= build_member_index(shape)
        end

        # Returns the resolved JSON wire name for the member, cached as
        # +member[:json_name]+ and preferring the Smithy @jsonName trait.
        def wire_name(member)
          cached = member[:json_name]
          return cached unless cached.nil?

          member[:json_name] = member.traits['smithy.api#jsonName'] || member.name
        end

        # Delegates generic sparse handling to the schema extension.
        def sparse?(shape)
          Smithy::Schema::Extension.sparse?(shape)
        end

        private

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            next unless member.name

            index[wire_name(member)] = [name, member]
          end
          index.freeze
        end
      end
    end
  end
end
