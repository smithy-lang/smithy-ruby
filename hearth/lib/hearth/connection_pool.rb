# frozen_string_literal: true

module Hearth
  # @api private
  class ConnectionPool
    @pools_mutex = Mutex.new
    @pools = {}

    class << self
      # @return [ConnectionPool]
      def for(config = {})
        @pools_mutex.synchronize do
          puts "using connection pool for #{config}\n" if @pools[config]
          puts "creating connection pool for #{config}\n" unless @pools[config]
          @pools[config] ||= new
        end
      end

      # @return [Array<ConnectionPool>] Returns a list of the
      #   constructed connection pools.
      def pools
        @pools_mutex.synchronize do
          @pools.values
        end
      end
    end

    # @api private
    def initialize
      @pool_mutex = Mutex.new
      @pool = {}
    end

    # @param [URI::HTTP, URI::HTTPS] endpoint The HTTP(S) endpoint
    #    to connect to (e.g. 'https://domain.com').
    # @param [Proc] block A block that returns a new session.
    # @return [Object, nil]
    def session_for(endpoint, &block)
      session = nil
      endpoint = remove_path_and_query(endpoint)
      # attempt to recycle an already open session
      @pool_mutex.synchronize do
        _clean
        session = @pool[endpoint].shift if @pool.key?(endpoint)
        puts "using session from pool: #{session}\n" if session
      end
      session || block.call
    end

    # @param [URI::HTTP, URI::HTTPS] endpoint The HTTP(S) endpoint
    # @param [Object] session The session to check back into the pool.
    # @return [nil]
    def offer(endpoint, session)
      endpoint = remove_path_and_query(endpoint)
      @pool_mutex.synchronize do
        @pool[endpoint] = [] unless @pool.key?(endpoint)
        @pool[endpoint] << session
      end
    end

    # Removes stale http sessions from the pool (that have exceeded
    # the idle timeout).
    # @return [nil]
    def clean!
      @pool_mutex.synchronize { _clean }
      nil
    end

    # Closes and removes all sessions from the pool.
    # If empty! is called while there are outstanding requests they may
    # get checked back into the pool, leaving the pool in a non-empty
    # state.
    # @return [nil]
    def empty!
      @pool_mutex.synchronize do
        @pool.each_pair do |_endpoint, sessions|
          # Requires each session to have a #finish method.
          sessions.each(&:finish)
        end
        @pool.clear
      end
      nil
    end

    private

    # Removes stale sessions from the pool.  This method *must* be called
    # @note **Must** be called behind a `@pool_mutex` synchronize block.
    def _clean
      @pool.each_pair do |_endpoint, sessions|
        sessions.delete_if(&:stale?)
      end
    end

    # Connection pools should be keyed by endpoint and port.
    def remove_path_and_query(endpoint)
      endpoint.dup.tap do |e|
        e.path = ''
        e.query = nil
      end.to_s
    end
  end
end
