# frozen_string_literal: true

module Smithy
  module Schema
    # An empty Struct that includes the {Schema::Structure} module.
    class EmptyStructure < Struct.new(nil) # rubocop:disable Style/StructInheritance
      include Smithy::Schema::Structure
    end
  end
end
