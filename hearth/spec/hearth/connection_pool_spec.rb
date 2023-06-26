# frozen_string_literal: true

module Hearth
  describe ConnectionPool do
    # Set instance variable instead of calling empty!
    # to avoid re-use of double rspec error.
    before do
      ConnectionPool.instance_variable_set(:@pools, {})
    end

    let(:config) { { timeout: 1 } }
    let(:pool) { ConnectionPool.for(config) }

    let(:endpoint) { URI('https://example.com') }
    let(:endpoint2) { URI('https://example.org') }
    let(:endpoint_path_query) { URI('https://example.com/path?query') }
    let(:connection) { double('connection', stale?: false, finish: nil) }
    let(:connection2) { double('connection2', stale?: false, finish: nil) }
    let(:stale_connection) { double('stale_connection', stale?: true) }

    describe '.for' do
      it 'returns a connection pool' do
        expect(ConnectionPool.for(config)).to be_a(ConnectionPool)
      end

      it 'returns the same connection pool for the same config' do
        expect(ConnectionPool.for(config)).to eq(ConnectionPool.for(config))
      end

      it 'returns a different connection pool for a different config' do
        expect(ConnectionPool.for(config)).not_to eq(ConnectionPool.for({}))
      end
    end

    describe '.pools' do
      it 'returns a list of the constructed connection pools' do
        expect(ConnectionPool.pools).to be_a(Array)
      end

      it 'returns the same list of constructed connection pools' do
        ConnectionPool.for(config)
        expect(ConnectionPool.pools).to eq(ConnectionPool.pools)
      end
    end

    describe '#offer / #connection_for' do
      it 'returns a new default connection using a block' do
        actual = pool.connection_for(endpoint) { connection }
        expect(actual).to eq(connection)
      end

      it 'ignores the block if there is a connection' do
        pool.offer(endpoint, connection)
        actual = pool.connection_for(endpoint) { connection2 }
        expect(actual).to eq(connection)
      end

      it 'is keyed by endpoint' do
        pool.offer(endpoint, connection)
        pool.offer(endpoint2, connection2)
        actual = pool.connection_for(endpoint)
        actual2 = pool.connection_for(endpoint2)
        expect(actual).to eq(connection)
        expect(actual2).to eq(connection2)
      end

      it 'uses FIFO order' do
        pool.offer(endpoint, connection)
        pool.offer(endpoint, connection2)
        actual = pool.connection_for(endpoint)
        expect(actual).to eq(connection)
        actual = pool.connection_for(endpoint)
        expect(actual).to eq(connection2)
      end

      it 'removes stale connections' do
        pool.offer(endpoint, stale_connection)
        pool.offer(endpoint, connection)
        actual = pool.connection_for(endpoint)
        expect(actual).to eq(connection)
      end

      it 'uses the same endpoint without path and query' do
        pool.offer(endpoint_path_query, connection)
        actual = pool.connection_for(endpoint)
        expect(actual).to eq(connection)
      end
    end

    describe '#empty!' do
      it 'closes and removes all sessions from the pool' do
        pool.offer(endpoint, connection)
        pool.offer(endpoint2, connection2)
        expect(connection).to receive(:finish)
        expect(connection2).to receive(:finish)
        pool.empty!
        expect(pool.connection_for(endpoint)).to be_nil
        expect(pool.connection_for(endpoint2)).to be_nil
      end
    end
  end
end
