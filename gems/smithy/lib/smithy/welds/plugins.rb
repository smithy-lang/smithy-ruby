# frozen_string_literal: true

require 'smithy-client/plugins/checksum_required'
require 'smithy-client/plugins/content_length'
require 'smithy-client/plugins/host_prefix'
require 'smithy-client/plugins/idempotency_token'
require 'smithy-client/plugins/logging'
require 'smithy-client/plugins/net_http'
require 'smithy-client/plugins/pageable_output'
require 'smithy-client/plugins/param_converter'
require 'smithy-client/plugins/param_validator'
require 'smithy-client/plugins/protocol'
require 'smithy-client/plugins/raise_response_errors'
require 'smithy-client/plugins/request_compression'
require 'smithy-client/plugins/response_target'
require 'smithy-client/plugins/retry_errors'
require 'smithy-client/plugins/sign_requests'
require 'smithy-client/plugins/stub_responses'

module Smithy
  module Welds
    # Provides default plugins.
    class Plugins < Weld
      def for?(_service)
        say_status :insert, 'Adding default plugins', @plan.quiet
        true
      end

      def add_plugins
        base_path = 'smithy-client/plugins'
        {
          Smithy::Client::Plugins::ChecksumRequired => { require_path: "#{base_path}/checksum_required" },
          Smithy::Client::Plugins::ContentLength => { require_path: "#{base_path}/content_length" },
          Smithy::Client::Plugins::HostPrefix => { require_path: "#{base_path}/host_prefix" },
          Smithy::Client::Plugins::IdempotencyToken => { require_path: "#{base_path}/idempotency_token" },
          Smithy::Client::Plugins::Logging => { require_path: "#{base_path}/logging" },
          Smithy::Client::Plugins::NetHTTP => { require_path: "#{base_path}/net_http" },
          Smithy::Client::Plugins::PageableOutput => { require_path: "#{base_path}/pageable_output" },
          Smithy::Client::Plugins::ParamConverter => { require_path: "#{base_path}/param_converter" },
          Smithy::Client::Plugins::ParamValidator => { require_path: "#{base_path}/param_validator" },
          Smithy::Client::Plugins::Protocol => { require_path: "#{base_path}/protocol" },
          Smithy::Client::Plugins::RaiseResponseErrors => { require_path: "#{base_path}/raise_response_errors" },
          Smithy::Client::Plugins::RequestCompression => { require_path: "#{base_path}/request_compression" },
          Smithy::Client::Plugins::ResponseTarget => { require_path: "#{base_path}/response_target" },
          Smithy::Client::Plugins::RetryErrors => { require_path: "#{base_path}/retry_errors" },
          Smithy::Client::Plugins::SignRequests => { require_path: "#{base_path}/sign_requests" },
          Smithy::Client::Plugins::StubResponses => { require_path: "#{base_path}/stub_responses" }
        }
      end
    end
  end
end
