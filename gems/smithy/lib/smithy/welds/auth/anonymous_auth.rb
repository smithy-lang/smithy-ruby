# frozen_string_literal: true

require 'smithy-client/plugins/anonymous_auth'

module Smithy
  module Welds
    # Adds default Anonymous (optional) auth.
    class AnonymousAuth < Weld
      def for?(_service)
        say_status :insert, 'Adding the AnonymousAuth plugin', :yellow unless @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::AnonymousAuth => { require_path: 'smithy-client/plugins/anonymous_auth' }
        }
      end
    end
  end
end
