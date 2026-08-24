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
          Smithy::Schema::Extension.member_index(shape, json_name: true)
        end

        # Returns the resolved JSON wire name for the member, cached as
        # +member[:json_name]+ and preferring the Smithy @jsonName trait.
        def wire_name(member)
          Smithy::Schema::Extension.wire_name(member, json_name: true)
        end

        # Delegates generic sparse handling to the schema extension.
        def sparse?(shape)
          Smithy::Schema::Extension.sparse?(shape)
        end
      end
    end
  end
end
