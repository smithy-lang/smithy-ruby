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
    end

    # @api private
    def initialize
      @pool_mutex = Mutex.new
      @pool = {}
    end

    # @param [URI::HTTP, URI::HTTPS] endpoint The HTTP(S) endpoint
    #   to connect to (e.g. 'https://domain.com').
    # @param [Proc] block A block that returns a new connection if
    #   there are no connections present.
    # @return [Object, nil]
    def connection_for(endpoint, &block)
      connection = nil
      endpoint = remove_path_and_query(endpoint)
      # attempt to recycle an already open connection
      @pool_mutex.synchronize do
        clean
        connection = @pool[endpoint].shift if @pool.key?(endpoint)
        puts "using connection from pool: #{connection}\n" if connection
      end
      connection || block.call
    end

    # @param [URI::HTTP, URI::HTTPS] endpoint The HTTP(S) endpoint
    # @param [Object] connection The connection to check back into the pool.
    # @return [nil]
    def offer(endpoint, connection)
      endpoint = remove_path_and_query(endpoint)
      @pool_mutex.synchronize do
        @pool[endpoint] = [] unless @pool.key?(endpoint)
        @pool[endpoint] << connection
      end
    end

    private

    # Removes stale connections from the pool.  This method *must* be called
    # @note **Must** be called behind a `@pool_mutex` synchronize block.
    def clean
      @pool.each_pair do |_endpoint, connections|
        connections.delete_if(&:stale?)
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
