# frozen_string_literal: true

module Smithy
  module Welds
    # Adds default Anonymous (optional) auth.
    class AnonymousAuth < Weld
      def for?(_service)
        say_status :insert, 'Adding the AnonymousAuth plugin', :yellow unless @plan.quiet
        true
      end

      def add_auth_schemes
        ['smithy.api#noAuth']
      end
    end
  end
end
