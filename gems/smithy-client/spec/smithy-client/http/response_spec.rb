# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Http
      describe Response do
        subject { Response.new }

        describe '#status_code' do
          it 'defaults to 0' do
            expect(subject.status_code).to eq(0)
          end

          it 'can be set' do
            subject.status_code = 500
            expect(subject.status_code).to eq(500)
          end
        end

        describe '#headers' do
          it 'is a Http::Headers' do
            expect(subject.headers).to be_kind_of(Headers)
          end

          it 'defaults to a empty hash' do
            expect(subject.headers.to_h).to eq({})
          end
        end

        describe '#body' do
          it 'defaults to an empty IO-like object' do
            expect(subject.body.read).to eq('')
          end

          it 'can be set in the constructor' do
            body = StringIO.new('body')
            expect(Response.new(body: body).body).to be(body)
          end

          it 'converts nil bodies into empty io objects' do
            subject.body = nil
            expect(subject.body.read).to eq('')
          end

          it 'can be set as a string in the accessor' do
            subject.body = 'body'
            expect(subject.body).to be_a(StringIO)
            expect(subject.body.read).to eq('body')
          end

          it 'can set a string io in the accessor' do
            subject.body = StringIO.new('body')
            expect(subject.body.read).to eq('body')
          end
        end

        describe '#reset' do
          it 'resets the body' do
            body = StringIO.new
            body << 'data'
            response = Response.new(
              body: body,
              headers: Headers.new('Content-Length' => '4'),
              status_code: 200,
              error: StandardError.new('error')
            )
            response.reset
            expect(response.body.read).to eq('')
            expect(response.headers.to_h).to eq({})
            expect(response.status_code).to eq(0)
            expect(response.error).to be_nil
          end

          it 'rewinds the body position so subsequent writes start at the beginning' do
            subject.signal_data('first response body')
            subject.signal_done
            subject.body.read
            subject.reset
            subject.signal_data('second response body')
            subject.signal_done
            expect(subject.body.read).to eq('second response body')
          end

          it 're-arms the done terminal so a re-driven response can emit :done again' do
            count = 0
            subject.on_done { count += 1 }
            subject.signal_done
            subject.reset
            subject.signal_done
            expect(count).to eq(2)
          end
        end

        describe '#signal_headers' do
          it 'sets the status code' do
            subject.signal_headers(200, {})
            expect(subject.status_code).to eq(200)
          end

          it 'sets the headers' do
            headers = { 'content-length' => '4' }
            subject.signal_headers(200, headers)
            expect(subject.headers['content-length']).to eq('4')
          end

          it 'ignores headers and listeners after completion' do
            observed = []
            subject.on_headers { |status, _headers| observed << status }
            subject.signal_done(status_code: 200, headers: { 'x-original' => 'yes' }, body: 'data')
            subject.signal_headers(503, { 'x-late' => 'yes' })
            expect(subject.status_code).to eq(200)
            expect(subject.headers.to_h).to eq('x-original' => 'yes')
            expect(observed).to eq([200])
          end
        end

        describe '#signal_data' do
          it 'sets the data' do
            subject.signal_data('data')
            subject.signal_done
            expect(subject.body.read).to eq('data')
          end

          it 'does not write empty data' do
            subject.signal_data('')
            subject.signal_done
            expect(subject.body.read).to eq('')
          end

          it 'ignores data and listeners after an error terminal' do
            observed = []
            subject.on_data { |chunk| observed << chunk }
            subject.signal_data('original')
            subject.signal_error(RuntimeError.new('failed'))
            subject.signal_data('late')
            expect(subject.body.read).to eq('original')
            expect(observed).to eq(['original'])
          end

          it 'records a body write failure without labelling it as a network error' do
            error = IOError.new('destination failed')
            allow(subject.body).to receive(:write).and_raise(error)
            subject.signal_data('data')
            expect(subject.error).to be(error)
          end
        end

        describe '#signal_done' do
          it 'raises when the response does not have all of the required keys' do
            expect { subject.signal_done(foo: 'bar') }.to raise_error(ArgumentError)
          end

          it 'emits done without arguments' do
            done = false
            subject.on_done { |_response| done = true }
            subject.signal_done
            expect(done).to be(true)
          end

          it 'emits :done at most once' do
            count = 0
            subject.on_done { count += 1 }
            subject.signal_done
            subject.signal_done
            expect(count).to eq(1)
          end

          it 'does not re-emit :done via a subsequent signal_error' do
            count = 0
            subject.on_done { count += 1 }
            subject.signal_done
            subject.signal_error(StandardError.new('late'))
            expect(count).to eq(1)
          end

          it 'records an error after a successful terminal has fired' do
            error = StandardError.new('late')
            subject.signal_done
            subject.signal_error(error)
            expect(subject.error).to be(error)
          end

          it 'rewinds the body' do
            body = StringIO.new('data')
            subject.body = body
            subject.signal_done
            expect(subject.body.read).to eq('data')
          end

          it 'emits status code, headers, and body' do
            subject.signal_done(
              status_code: 200,
              headers: { 'content-length' => 4 },
              body: 'data'
            )
            expect(subject.status_code).to eq(200)
            expect(subject.headers['content-length']).to eq('4')
            expect(subject.body.read).to eq('data')
          end

          it 'ignores a second completion with replacement response contents' do
            subject.signal_done(status_code: 200, headers: {}, body: 'original')
            subject.signal_done(status_code: 503, headers: {}, body: 'late')
            expect(subject.status_code).to eq(200)
            expect(subject.body.read).to eq('original')
          end

          it 'records a rewind failure and completes without rewinding again' do
            error = Errno::EIO.new('rewind failed')
            completed = 0
            observed = []
            subject.on_done { completed += 1 }
            subject.on_error { |e| observed << e }
            expect(subject.body).to receive(:rewind).once.and_raise(error)
            subject.signal_done
            subject.signal_error(RuntimeError.new('later failure'))
            expect(subject.error).to be(error)
            expect(completed).to eq(1)
            expect(observed).to eq([error])
          end
        end

        describe '#signal_error' do
          it 'sets the error' do
            error = StandardError.new('error')
            subject.signal_error(error)
            expect(subject.error).to be(error)
          end

          it 'preserves the original error when completion cleanup also fails' do
            error = EOFError.new('connection closed')
            allow(subject.body).to receive(:rewind).and_raise(Errno::EIO)
            subject.on_done { raise 'cleanup failed' }
            subject.signal_error(error)
            expect(subject.error).to be(error)
          end
        end

        describe '#on_headers' do
          it 'yields the status code and headers' do
            headers = nil
            subject.on_headers { |_status_code, h| headers = h }
            subject.signal_headers(200, { 'content-length' => 4 })
            expect(headers['content-length']).to eq('4')
          end
        end

        describe '#on_data' do
          it 'yields the data' do
            data = nil
            subject.on_data { |d| data = d }
            subject.signal_data('data')
            expect(data).to eq('data')
          end
        end

        describe '#on_done' do
          it 'yields when the response is done' do
            done = false
            subject.on_done { done = true }
            subject.signal_done
            expect(done).to be(true)
          end

          it 'continues remaining completion listeners after a listener fails' do
            error = RuntimeError.new('listener failed')
            completed = []
            subject.on_done { raise error }
            subject.on_done { completed << :cleanup }
            subject.signal_done
            expect(subject.error).to be(error)
            expect(completed).to eq([:cleanup])
          end
        end

        describe '#on_success' do
          it 'yields when the response is done and does not have an error' do
            success = false
            subject.on_success { success = true }
            subject.signal_done(status_code: 200, headers: {}, body: '')
            expect(success).to be(true)
          end

          it 'does not yield when the response has an error' do
            success = false
            subject.signal_error(StandardError.new('error'))
            subject.on_success { success = true }
            subject.signal_done
            expect(success).to be(false)
          end
        end

        describe '#on_error' do
          it 'yields when the response has an error' do
            error = nil
            subject.on_error { |e| error = e }
            subject.signal_error(StandardError.new('error'))
            expect(error).to be_kind_of(StandardError)
          end

          it 'does not yield when the response does not have an error' do
            error = nil
            subject.on_error { |e| error = e }
            subject.signal_done
            expect(error).to be_nil
          end

          it 'observes a completion listener failure even when registered first' do
            error = RuntimeError.new('listener failed')
            observed = []
            subject.on_error { |e| observed << e }
            subject.on_done { raise error }
            subject.signal_done
            expect(observed).to eq([error])
          end

          it 'notifies existing listeners once when a late failure is recorded' do
            error = RuntimeError.new('late failure')
            observed = []
            subject.on_error { |e| observed << e }
            subject.signal_done
            subject.signal_error(error)
            subject.signal_error(RuntimeError.new('another failure'))
            expect(observed).to eq([error])
          end

          it 'notifies listeners registered after a failure' do
            error = RuntimeError.new('failed')
            subject.signal_error(error)
            expect { |block| subject.on_error(&block) }.to yield_with_args(error)
          end

          it 'calls an error listener registered during notification only once' do
            observed = []
            subject.on_error do
              subject.on_error { |e| observed << e }
            end
            error = RuntimeError.new('failed')
            subject.signal_error(error)
            expect(observed).to eq([error])
          end

          it 'continues error listeners without replacing the original failure' do
            error = RuntimeError.new('original failure')
            observed = []
            subject.on_error { raise 'error listener failed' }
            subject.on_error { |e| observed << e }
            subject.signal_error(error)
            expect(subject.error).to be(error)
            expect(observed).to eq([error])
          end

          it 're-arms error notification after reset' do
            errors = [RuntimeError.new('first'), RuntimeError.new('second')]
            observed = []
            subject.on_error { |e| observed << e }
            subject.signal_error(errors.first)
            subject.reset
            subject.signal_error(errors.last)
            expect(observed).to eq(errors)
          end
        end
      end
    end
  end
end
