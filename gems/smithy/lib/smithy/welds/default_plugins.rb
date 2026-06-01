# frozen_string_literal: true

require 'smithy-client/plugins/checksum_required'
require 'smithy-client/plugins/content_length'
require 'smithy-client/plugins/default_params'
require 'smithy-client/plugins/host_prefix'
require 'smithy-client/plugins/idempotency_token'
require 'smithy-client/plugins/logging'
require 'smithy-client/plugins/net_http'
require 'smithy-client/plugins/pageable_response'
require 'smithy-client/plugins/param_converter'
require 'smithy-client/plugins/param_validator'
require 'smithy-client/plugins/raise_response_errors'
require 'smithy-client/plugins/request_compression'
require 'smithy-client/plugins/resolve_auth'
require 'smithy-client/plugins/response_target'
require 'smithy-client/plugins/retry_errors'
require 'smithy-client/plugins/sign_requests'
require 'smithy-client/plugins/stub_responses'
require 'smithy-client/plugins/transfer_encoding'
require 'smithy-client/plugins/user_agent'

module Smithy
  module Welds
    # Provides default plugins.
    class DefaultPlugins < Weld
      def for?(_service)
        say_status :insert, 'Adding default plugins', :yellow unless @plan.quiet
        true
      end

      def add_plugins # rubocop:disable Metrics/MethodLength
        base_path = 'smithy-client/plugins'
        {
          Smithy::Client::Plugins::ChecksumRequired => { require_path: "#{base_path}/checksum_required" },
          Smithy::Client::Plugins::ContentLength => { require_path: "#{base_path}/content_length" },
          Smithy::Client::Plugins::DefaultParams => { require_path: "#{base_path}/default_params" },
          Smithy::Client::Plugins::HostPrefix => { require_path: "#{base_path}/host_prefix" },
          Smithy::Client::Plugins::IdempotencyToken => { require_path: "#{base_path}/idempotency_token" },
          Smithy::Client::Plugins::Logging => { require_path: "#{base_path}/logging" },
          Smithy::Client::Plugins::NetHTTP => { require_path: "#{base_path}/net_http" },
          Smithy::Client::Plugins::PageableResponse => { require_path: "#{base_path}/pageable_response" },
          Smithy::Client::Plugins::ParamConverter => { require_path: "#{base_path}/param_converter" },
          Smithy::Client::Plugins::ParamValidator => { require_path: "#{base_path}/param_validator" },
          Smithy::Client::Plugins::RaiseResponseErrors => { require_path: "#{base_path}/raise_response_errors" },
          Smithy::Client::Plugins::RequestCompression => { require_path: "#{base_path}/request_compression" },
          Smithy::Client::Plugins::ResolveAuth => { require_path: "#{base_path}/resolve_auth" },
          Smithy::Client::Plugins::ResponseTarget => { require_path: "#{base_path}/response_target" },
          Smithy::Client::Plugins::RetryErrors => { require_path: "#{base_path}/retry_errors" },
          Smithy::Client::Plugins::SignRequests => { require_path: "#{base_path}/sign_requests" },
          Smithy::Client::Plugins::StubResponses => { require_path: "#{base_path}/stub_responses" },
          Smithy::Client::Plugins::TransferEncoding => { require_path: "#{base_path}/transfer_encoding" },
          Smithy::Client::Plugins::UserAgent => { require_path: "#{base_path}/user_agent" }
        }
      end
    end
  end
end
