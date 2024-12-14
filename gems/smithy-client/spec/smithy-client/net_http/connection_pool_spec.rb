# frozen_string_literal: true

module Smithy
  module Client
    module NetHTTP
      describe ConnectionPool do
        let(:options) { { logger: Logger.new(IO::NULL), http_debug_output: true } }

        describe '#session_for' do
          after { ConnectionPool.pools.each(&:empty!) }

          it 're-uses session for endpoints that share port, scheme, and host' do
            session = double(
              'Net::HTTPSession',
              last_used: Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond),
              keep_alive_timeout: 2,
            ).as_null_object
            pool = ConnectionPool.for({})
            expect(pool).to receive(:start_session)
              .exactly(1).times
              .with('https://example.com')
              .and_return(session)
            endpoint1 = URI.parse('https://example.com/path?query')
            endpoint2 = URI.parse('https://example.com/different')
            endpoint3 = URI.parse('https://example.com')
            sessions = []
            pool.session_for(endpoint1) { |https| sessions << https }
            pool.session_for(endpoint2) { |https| sessions << https }
            pool.session_for(endpoint3) { |https| sessions << https }
            expect(sessions).to eq([session, session, session])
          end

          it 're-uses session for slow request that are taking more time than the configured idle timeout' do
            session = double(
              'Net::HTTPSession',
              keep_alive_timeout: 0.5
            ).as_null_object
            allow(session).to receive(:request) { Thread.new { sleep 1 } }
            pool = ConnectionPool.for({})
            expect(pool).to receive(:start_session)
              .exactly(1).times
              .and_return(ConnectionPool::ExtendedSession.new(session))
            endpoint = URI.parse('https://example.com')
            sessions = []
            pool.session_for(endpoint) do |http|
              http.request
              sessions << http
            end
            pool.session_for(endpoint) do |http|
              http.request
              sessions << http
            end
            expect(sessions).to eq([session, session])
          end
        end

        describe '#size' do
          it 'returns the size' do
            pool = ConnectionPool.for({})
            expect(pool.size).to eq(0)
          end
        end

        describe '#clean!' do
          it 'cleans stale sessions' do
            session = double(
              'Net::HTTPSession',
              last_used: Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond) - 1000,
              keep_alive_timeout: 0.5
            ).as_null_object
            pool = ConnectionPool.for({})
            expect(pool).to receive(:start_session)
              .exactly(2).times
              .with('https://example.com')
              .and_return(session)
            pool.session_for(URI.parse('https://example.com'), &:request)
            pool.clean!
            pool.session_for(URI.parse('https://example.com'), &:request)
            pool.clean!
          end
        end

        context 'proxies' do
          let(:net_req) { Net::HTTP::Get.new('/') }

          it 'with a regular URI' do
            stub_request(:get, 'https://example.com')
            http_proxy = 'http://proxy.com:8080'
            pool = ConnectionPool.for(http_proxy: http_proxy)
            expect(Net::HTTP)
              .to receive(:new).with(anything, anything, 'proxy.com', 8080)
              .and_call_original
            pool.session_for(URI.parse('https://example.com')) { |http| http.request(net_req) }
          end

          it 'with a URI with username and password' do
            stub_request(:get, 'https://example.com')
            http_proxy = 'http://username:password@proxy.com:8080'
            pool = ConnectionPool.for(http_proxy: http_proxy)
            expect(Net::HTTP)
              .to receive(:new).with(anything, anything, 'proxy.com', 8080, 'username', 'password')
              .and_call_original
            pool.session_for(URI.parse('https://example.com')) { |http| http.request(net_req) }
          end

          it 'with a URI with username and password with special characters' do
            stub_request(:get, 'https://example.com')
            http_proxy = 'http://%3A%40%2Fusername:password%3A%40%2F@proxy.com:8080'
            pool = ConnectionPool.for(http_proxy: http_proxy)
            expect(Net::HTTP)
              .to receive(:new).with(anything, anything, 'proxy.com', 8080, ':@/username', 'password:@/')
              .and_call_original
            pool.session_for(URI.parse('https://example.com')) { |http| http.request(net_req) }
          end
        end

        describe '.for' do
          it 'returns a connection pool' do
            expect(ConnectionPool.for(options)).to be_a(ConnectionPool)
          end

          it 'returns the same connection pool for the same options' do
            expect(ConnectionPool.for(options)).to eq(ConnectionPool.for(options))
          end

          it 'returns a different connection pool for different options' do
            expect(ConnectionPool.for(options)).not_to eq(ConnectionPool.for({}))
          end
        end

        describe '.pools' do
          it 'returns a list of the constructed connection pools' do
            expect(ConnectionPool.pools).to be_a(Array)
          end

          it 'returns the same list of constructed connection pools' do
            ConnectionPool.for(options)
            expect(ConnectionPool.pools).to eq(ConnectionPool.pools)
          end
        end
      end
    end
  end
end
