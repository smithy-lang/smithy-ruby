# frozen_string_literal: true

require 'smithy-client/plugins/content_length'
require 'smithy-client/plugins/logging'
require 'smithy-client/plugins/net_http'
require 'smithy-client/plugins/param_converter'
require 'smithy-client/plugins/param_validator'
require 'smithy-client/plugins/protocols'
require 'smithy-client/plugins/raise_response_errors'
require 'smithy-client/plugins/response_target'
require 'smithy-client/plugins/retry_errors'
require 'smithy-client/plugins/stub_responses'

module Smithy
  module Welds
    # Provides default plugins.
    class Plugins < Weld
      def for?(_service)
        say_status :insert, 'Adding default plugins', @plan.quiet
        true
      end

      def plugins
        base_path = 'smithy-client/plugins'
        {
          Smithy::Client::Plugins::ContentLength => { require_path: "#{base_path}/content_length" },
          Smithy::Client::Plugins::Logging => { require_path: "#{base_path}/logging" },
          Smithy::Client::Plugins::NetHTTP => { require_path: "#{base_path}/net_http" },
          Smithy::Client::Plugins::ParamConverter => { require_path: "#{base_path}/param_converter" },
          Smithy::Client::Plugins::ParamValidator => { require_path: "#{base_path}/param_validator" },
          Smithy::Client::Plugins::Protocols => { require_path: "#{base_path}/protocols" },
          Smithy::Client::Plugins::RaiseResponseErrors => { require_path: "#{base_path}/raise_response_errors" },
          Smithy::Client::Plugins::ResponseTarget => { require_path: "#{base_path}/response_target" },
          Smithy::Client::Plugins::RetryErrors => { require_path: "#{base_path}/retry_errors" },
          Smithy::Client::Plugins::StubResponses => { require_path: "#{base_path}/stub_responses" }
        }
      end
    end
  end
end
