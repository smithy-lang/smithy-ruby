# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class UserAgent < Plugin
        option(
          :user_agent_suffix,
          doc_type: String,
          docstring: <<~DOCS)
            An optional string that is appended to the User-Agent header.
            The default User-Agent includes the smithy-client version, 
            the ruby platform and version, and host OS information.
          DOCS

        # @api private
        class Handler < Client::Handler
          def call(context)
            context.http_request.headers['User-Agent'] = UserAgent.new(context).to_s
            @handler.call(context)
          end

          # @api private
          class UserAgent
            def initialize(context)
              @context = context
            end

            def to_s
              ua = "smithy-ruby/#{Smithy::Client::VERSION}"
              ua += " (#{os_metadata};"
              ua += " #{language_metadata})"
              ua += " #{@context.config.user_agent_suffix}" if @context.config.user_agent_suffix
              ua.strip
            end

            private

            def os_metadata
              os =
                case RbConfig::CONFIG['host_os']
                when /mac|darwin/
                  'macos'
                when /linux|cygwin/
                  'linux'
                when /mingw|mswin/
                  'windows'
                else
                  'other'
                end
              metadata = os.to_s
              local_version = Gem::Platform.local.version
              metadata += " #{local_version}" if local_version
              metadata + "; #{RbConfig::CONFIG['host_cpu']}"
            end

            def language_metadata
              "ruby/#{RUBY_VERSION}"
            end
          end
        end

        handler(Handler, step: :sign, priority: 5)
      end
    end
  end
end
