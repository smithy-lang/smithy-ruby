# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module Util
      def self.str_to_bool(str) # rubocop:disable Naming/PredicateMethod
        case str
        when 'true' then true
        when 'false' then false
        end
      end
    end
  end
end
