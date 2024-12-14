# frozen_string_literal: true

require 'cgi'
require 'net/http'
require 'net/https'
require 'delegate'
require 'logger'

require_relative 'patches'

Smithy::Client::NetHTTP::Patches.apply!

module Smithy
  module Client
    module NetHTTP
      # @api private
      class ConnectionPool
        @pools_mutex = Mutex.new
        @pools = {}

        OPTIONS = {
          # Connections
          http_continue_timeout: nil,
          http_keep_alive_timeout: nil,
          http_open_timeout: nil,
          http_read_timeout: nil,
          http_ssl_timeout: nil,
          http_write_timeout: nil,
          # Security
          http_ca_file: nil,
          http_ca_path: nil,
          http_cert: nil,
          http_cert_store: nil,
          http_key: nil,
          http_verify_mode: OpenSSL::SSL::VERIFY_PEER,
          # Debugging
          http_debug_output: nil,
          # Proxies
          http_proxy: nil,
          # Other
          logger: Logger.new($stdout)
        }.freeze

        # @api private
        def initialize(options = {})
          OPTIONS.each_pair do |opt_name, default_value|
            value = options[opt_name].nil? ? default_value : options[opt_name]
            instance_variable_set("@#{opt_name}", value)
          end
          @pool_mutex = Mutex.new
          @pool = {}
        end
        private_class_method :new

        OPTIONS.each_key do |attr_name|
          attr_reader(attr_name)
        end

        # @param [URI::HTTP, URI::HTTPS] endpoint The HTTP(S) endpoint
        #    to connect to (e.g. 'https://domain.com').
        #
        # @yieldparam [Net::HTTPSession] session
        #
        # @return [nil]
        def session_for(endpoint)
          endpoint = remove_path_and_query(endpoint)
          session = nil

          # attempt to recycle an already open session
          @pool_mutex.synchronize do
            _clean
            session = @pool[endpoint].shift if @pool.key?(endpoint)
          end

          begin
            session ||= start_session(endpoint)
            session.read_timeout = http_read_timeout if http_read_timeout
            session.continue_timeout = http_continue_timeout if http_continue_timeout
            yield(session)
          rescue StandardError
            session&.finish
            raise
          else
            @pool_mutex.synchronize do
              @pool[endpoint] = [] unless @pool.key?(endpoint)
              @pool[endpoint] << session
            end
          end
          nil
        end

        # @return [Integer] Returns the count of sessions currently in the
        #  pool, not counting those currently in use.
        def size
          @pool_mutex.synchronize do
            @pool.values.flatten.size
          end
        end

        # Removes stale http sessions from the pool (that have exceeded the idle timeout).
        # @return [nil]
        def clean!
          @pool_mutex.synchronize { _clean }
          nil
        end

        # Closes and removes all sessions from the pool. If empty! is called while
        # there are outstanding requests they may get checked back into the pool,
        # leaving the pool in a non-empty state.
        # @return [nil]
        def empty!
          @pool_mutex.synchronize do
            @pool.values.flatten.map(&:finish)
            @pool.clear
          end
          nil
        end

        private

        def remove_path_and_query(endpoint)
          endpoint.dup.tap do |e|
            e.path = ''
            e.query = nil
          end.to_s
        end

        class << self
          # Returns a connection pool constructed from the given options.
          # Calling this method twice with the same options will return
          # the same pool.
          #
          # @option options [Numeric] :http_continue_timeout (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-continue_timeout
          # @option options [Numeric] :http_keep_alive_timeout (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-keep_alive_timeout
          # @option options [Numeric] :http_open_timeout (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-open_timeout
          # @option options [Numeric] :http_read_timeout (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-read_timeout
          # @option options [Numeric] :http_ssl_timeout (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-ssl_timeout
          # @option options [Numeric] :http_write_timeout (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-write_timeout
          # @option options [String] :http_ca_file (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-ca_file
          # @option options [String] :http_ca_path (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-ca_path
          # @option options [OpenSSL::X509::Certificate] :http_cert (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-cert
          # @option options [OpenSSL::X509::Store] :http_cert_store (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-cert_store
          # @option options [OpenSSL::PKey::RSA, OpenSSL::PKey::DSA] :http_key (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-key
          # @option options [Integer] :http_verify_mode (OpenSSL::SSL::VERIFY_PEER)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-verify_mode
          # @option options [Boolean] :http_debug_output (false)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#method-i-set_debug_output
          # @option options [URI::HTTP, String] :http_proxy (nil)
          #  @see https://docs.ruby-lang.org/en/master/Net/HTTP.html#attribute-i-proxy
          # @option options [Logger] :logger (nil) Where debug output is sent.
          #    Defaults to `Logger.new($stdout)` when `:http_wire_trace` is `true`.
          # @return [ConnectionPool]
          def for(options = {})
            options = pool_options(options)
            @pools_mutex.synchronize do
              @pools[options] ||= new(options)
            end
          end

          # @return [Array<ConnectionPool>] Returns a list of the
          #  constructed connection pools.
          def pools
            @pools_mutex.synchronize do
              @pools.values
            end
          end

          private

          # Filters an option hash, merging in default values.
          # @return [Hash]
          def pool_options(options)
            options.delete(:logger) unless options[:http_debug_output]
            options[:http_proxy] = URI.parse(options[:http_proxy].to_s)
            options
          end
        end

        # Extract the parts of the http_proxy URI
        # @return [Array<String>]
        def http_proxy_parts
          [
            http_proxy.host,
            http_proxy.port,
            http_proxy.user && CGI.unescape(http_proxy.user),
            http_proxy.password && CGI.unescape(http_proxy.password)
          ]
        end

        # Starts and returns a new HTTP(S) session.
        # @param [String] endpoint
        # @return [Net::HTTPSession]
        def start_session(endpoint)
          endpoint = URI.parse(endpoint)

          args = []
          args << endpoint.host
          args << endpoint.port
          args += http_proxy_parts

          http = ExtendedSession.new(Net::HTTP.new(*args.compact))
          http.set_debug_output(logger) if http_debug_output
          http.open_timeout = http_open_timeout if http_open_timeout
          http.keep_alive_timeout = http_keep_alive_timeout if http_keep_alive_timeout

          if endpoint.scheme == 'https'
            http.use_ssl = true
            http.http_ssl_timeout = http_ssl_timeout if http_ssl_timeout

            if http_verify_mode == OpenSSL::SSL::VERIFY_PEER
              http.ca_file = http_ca_file if http_ca_file
              http.ca_path = http_ca_path if http_ca_path
              http.cert = http_cert if http_cert
              http.cert_store = http_cert_store if http_cert_store
              http.key = http_key if http_key
            end
          else
            http.use_ssl = false
          end

          http.start
          http
        end

        # Removes stale sessions from the pool. This method *must* be called.
        # @note **Must** be called behind a `@pool_mutex` synchronize block.
        def _clean
          now = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
          @pool.each_value do |sessions|
            sessions.delete_if do |session|
              if session.last_used.nil? ||
                 (now - session.last_used > session.keep_alive_timeout * 1000)
                session.finish
                true
              end
            end
          end
        end

        # Helper methods extended onto Net::HTTPSession objects opened by the
        # connection pool.
        # @api private
        class ExtendedSession < SimpleDelegator
          def initialize(http)
            super
            @http = http
          end

          # @return [Integer, nil]
          attr_reader :last_used

          # Sends the request and tracks that this session has been used.
          def request(...)
            @http.request(...)
            @last_used = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
          end

          # Attempts to close/finish the session without raising an error.
          def finish
            @http.finish
          rescue IOError
            nil
          end
        end
      end
    end
  end
end
