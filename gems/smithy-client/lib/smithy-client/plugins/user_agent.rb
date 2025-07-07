# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      class UserAgent < Plugin
        class Handler < Client::Handler
          def call(context)
            set_user_agent(context)
            @handler.call(context)
          end

          def set_user_agent(context)
            context.http_request.headers['User-Agent'] = UserAgent.new(context)
          end

          class UserAgent
            def initialize(context)
              @context = context
            end

            def to_s
              ua = "smithy-ruby/#{Smithy::Client::VERSION}"
              ua += " (#{os_metadata};"
              ua += " #{language_metadata})"
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
