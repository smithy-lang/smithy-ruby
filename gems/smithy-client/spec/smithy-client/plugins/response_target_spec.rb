# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe ResponseTarget do
        let(:client_class) do
          client_class = ClientHelper.sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(ResponseTarget)
          client_class.add_plugin(DummySendPlugin)
          client_class
        end

        let(:client) { client_class.new }

        before do
          @tempfile = Tempfile.new('response-target')
        end

        after do
          @tempfile.close
        end

        context 'Block target' do
          it 'streams data' do
            data = []
            expected = client.config.response_body
            proc = proc { |chunk| data << chunk }
            client.operation({}, target: proc)
            expect(data).to eq([expected])
          end

          it 'counts the bytes yielded' do
            proc = proc { |chunk| } # empty
            response = client.operation({}, target: proc)
            expected = client.config.response_body.size
            expect(response.context.http_response.body.size).to eq(expected)
          end

          it 'does not buffer the response chunks' do
            proc = proc { |_chunk| } # empty
            response = client.operation({}, target: proc)
            body = response.context.http_response.body
            expect(body.read).to eq('')
            expect(body).not_to respond_to(:truncate)
          end

          it 'passes the headers to the block' do
            headers = nil
            proc = proc { |_chunk, header| headers = header }
            client.operation({}, target: proc)
            expect(headers).to be_an_instance_of(Http::Headers)
          end
        end

        context 'String path target' do
          let(:target) { @tempfile.path }

          it 'writes to the file name' do
            client.operation({}, target: target)
            expected = client.config.response_body
            expect(File.read(@tempfile.path)).to eq(expected)
          end

          it 'closes the file before returning the response' do
            response = client.operation({}, target: target)
            expect(response.context.http_response.body).to be_closed
          end

          it 'does not write error messages to the target' do
            error = StandardError.new('error')
            client = client_class.new(response_error: error)
            response = client.operation({}, target: target)
            expect(response.context.http_response.body.read).to eq('')
            expect { File.unlink(@tempfile.path) }.to raise_error(Errno::ENOENT)
          end
        end

        context 'Pathname target' do
          let(:target) { Pathname.new(@tempfile.path) }

          it 'writes to the file name' do
            client.operation({}, target: target)
            expected = client.config.response_body
            expect(File.read(@tempfile.path)).to eq(expected)
          end

          it 'closes the file before returning the response' do
            response = client.operation({}, target: target)
            expect(response.context.http_response.body).to be_closed
          end

          it 'does not write error messages to the target' do
            error = StandardError.new('error')
            client = client_class.new(response_error: error)
            response = client.operation({}, target: target)
            expect(response.context.http_response.body.read).to eq('')
            expect { File.unlink(@tempfile.path) }.to raise_error(Errno::ENOENT)
          end
        end

        context 'when a response fails after receiving data' do
          let(:response) { Http::Response.new }
          let(:error) { StandardError.new('download interrupted') }
          let(:body) { response.body }

          before do
            context = HandlerContext.new(http_response: response)
            context[:response_target] = target
            next_handler = Client::Handler.new
            allow(next_handler).to receive(:call).and_return(Response.new(context: context))
            handler = ResponseTarget::Handler.new(next_handler)
            handler.call(context)
            response.signal_headers(200, {})
            response.signal_data('partial')
            body
          end

          shared_examples 'managed file cleanup' do
            after do
              body.close if body.is_a?(ManagedFile) && body.open?
            end

            it 'closes the file before unlinking it' do
              allow(File).to receive(:unlink).and_wrap_original do |unlink, file|
                expect(file).to be_closed
                unlink.call(file)
              end

              response.signal_error(error)

              expect(body).to be_closed
              expect(File).not_to exist(@tempfile.path)
              expect(response.body).to be_a(StringIO)
              expect(response.body.read).to eq('')
              expect(response.error).to be(error)
            end

            it 'creates a fresh file when the response is retried' do
              response.signal_error(error)
              response.reset
              response.signal_headers(200, {})
              response.signal_data('complete')
              response.signal_done

              expect(body).to be_closed
              expect(response.body).not_to equal(body)
              expect(response.body).to be_closed
              expect(File.read(@tempfile.path)).to eq('complete')
              expect(response.error).to be_nil
            end
          end

          context 'with a String path target' do
            let(:target) { @tempfile.path }

            include_examples 'managed file cleanup'
          end

          context 'with a Pathname target' do
            let(:target) { Pathname.new(@tempfile.path) }

            include_examples 'managed file cleanup'
          end

          context 'with a customer-owned file target' do
            let(:target) { @tempfile }

            it 'leaves the file open and preserves the partial data' do
              response.signal_error(error)

              expect(target).not_to be_closed
              expect(response.body).to equal(target)
              expect(target.read).to eq('partial')
              expect(File).to exist(@tempfile.path)
            end
          end

          context 'with a block target' do
            let(:chunks) { [] }
            let(:target) { proc { |chunk| chunks << chunk } }

            it 'preserves chunks already delivered to the block' do
              response.signal_error(error)

              expect(chunks).to eq(['partial'])
              expect(response.body).to equal(body)
              expect(body.size).to eq('partial'.bytesize)
              expect(response.error).to be(error)
            end
          end
        end

        context 'StringIO target' do
          let(:target) { StringIO.new(String.new) }

          it 'writes to the given object' do
            client.operation({}, target: target)
            expected = client.config.response_body
            expect(target.string).to eq(expected)
          end
        end

        context 'File target' do
          let(:target) { @tempfile }

          it 'writes to the file' do
            client.operation({}, target: target)
            expected = client.config.response_body
            expect(File.read(@tempfile.path)).to eq(expected)
          end

          it 'does not unlink the file' do
            error = StandardError.new('error')
            client = client_class.new(response_error: error)
            client.operation({}, target: target)
            expect(File.unlink(@tempfile.path)).to eq(1)
          end
        end
      end
    end
  end
end
