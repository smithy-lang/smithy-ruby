# frozen_string_literal: true

module Hearth
  module Middleware
    module TestStubs
      module Types
        class StubData
          include Hearth::Structure

          MEMBERS = %i[member].freeze

          attr_accessor(*MEMBERS)
        end

        class StubErrorData
          include Hearth::Structure

          MEMBERS = %i[message].freeze

          attr_accessor(*MEMBERS)
        end
      end

      module Errors
        class StubError < StandardError; end
        class OtherError < StandardError; end
      end

      module Stubs
        class StubData
          def self.build(params, context:); end
          def self.validate!(output, context:); end
          def self.default(visited = []); end
          def self.stub(resp, stub:); end
          def self.default_event(visited = []); end
          def self.validate_event!(event, context:); end
          def self.stub_event(stub); end
        end

        class StubError
          def self.build(params, context:); end
          def self.validate!(output, context:); end
          def self.default(visited = []); end
          def self.stub(resp, stub:); end
        end
      end
    end

    describe Send do
      let(:app) { double('app') }
      let(:input) { double('input') }
      let(:output) { Hearth::Output.new }
      let(:client) { double('client') }
      let(:stub_responses) { false }
      let(:stubs) { Hearth::Stubs.new }
      let(:message_encoder) { double('encoder') }
      let(:response_events) { false }

      subject do
        Send.new(
          app,
          client: client,
          stub_responses: stub_responses,
          stub_data_class: TestStubs::Stubs::StubData,
          stub_error_classes: [TestStubs::Stubs::StubError],
          stub_message_encoder: message_encoder,
          response_events: response_events,
          stubs: stubs
        )
      end

      describe '#call' do
        let(:body) { StringIO.new }
        let(:request) { Hearth::HTTP::Request.new(body: body) }
        let(:response) { Hearth::HTTP::Response.new(body: body) }
        let(:operation) { :operation }
        let(:logger) { Logger.new(IO::NULL) }
        let(:interceptors) { double('interceptors', each: []) }
        let(:config) do
          double('config', logger: logger, interceptors: interceptors)
        end
        let(:tracer) { Hearth::Telemetry::NoOpTracer.new }
        let(:context) do
          Hearth::Context.new(
            operation_name: operation,
            request: request,
            response: response,
            config: config,
            tracer: tracer
          )
        end

        context 'no error' do
          before do # satisfy test coverage
            request.headers['Content-Length'] = body.size
            response.headers['Content-Length'] = body.size
          end

          it 'sends the request and returns an output object' do
            expect(client).to receive(:transmit).with(
              request: request,
              response: response,
              logger: logger
            ).and_return(response)
            output = subject.call(input, context)
            expect(output).to be_a(Hearth::Output)
          end
        end

        context 'error' do
          it 'sets output error to NetworkingError if the request fails' do
            error = Hearth::HTTP::NetworkingError.new(StandardError.new)
            expect(client).to receive(:transmit).with(
              request: request,
              response: response,
              logger: logger
            ).and_raise(error)

            output = subject.call(input, context)
            expect(output).to be_a(Hearth::Output)
            expect(output.error).to be_a(Hearth::NetworkingError)
          end
        end

        context 'interceptors' do
          it 'calls all hooks' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(hook: Interceptor::MODIFY_BEFORE_TRANSMIT))
              .ordered
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(hook: Interceptor::READ_BEFORE_TRANSMIT))
              .ordered

            expect(client).to receive(:transmit)
              .and_return(response).ordered

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(hook: Interceptor::READ_AFTER_TRANSMIT))
              .ordered

            subject.call(input, context)
          end

          context 'modify_before_transmit error' do
            let(:interceptor_error) { StandardError.new }

            it 'returns output with the error and does not call app' do
              expect(Interceptors).to receive(:invoke)
                .with(hash_including(hook: Interceptor::MODIFY_BEFORE_TRANSMIT))
                .and_return(interceptor_error)
              expect(app).not_to receive(:call)

              out = subject.call(input, context)
              expect(out.error).to eq(interceptor_error)
            end
          end

          context 'read_before_transmit error' do
            let(:interceptor_error) { StandardError.new }

            it 'returns output with the error and does not call app' do
              expect(Interceptors).to receive(:invoke)
                .with(hash_including(hook: Interceptor::MODIFY_BEFORE_TRANSMIT))
              expect(Interceptors).to receive(:invoke)
                .with(hash_including(hook: Interceptor::READ_BEFORE_TRANSMIT))
                .and_return(interceptor_error)

              expect(client).not_to receive(:transmit)

              out = subject.call(input, context)
              expect(out.error).to eq(interceptor_error)
            end
          end

          context 'read_after_transmit error' do
            let(:interceptor_error) { StandardError.new }

            it 'returns output with the error and calls app' do
              expect(Interceptors).to receive(:invoke)
                .with(hash_including(hook: Interceptor::MODIFY_BEFORE_TRANSMIT))
              expect(Interceptors).to receive(:invoke)
                .with(hash_including(hook: Interceptor::READ_BEFORE_TRANSMIT))

              expect(Output).to receive(:new).and_return(output)
              expect(client).to receive(:transmit).and_return(response)

              expect(Interceptors).to receive(:invoke)
                .with(hash_including(hook: Interceptor::READ_AFTER_TRANSMIT))
                .and_return(interceptor_error)

              out = subject.call(input, context)
              expect(out).to eq(output)
            end
          end
        end

        context 'stub_responses is true' do
          let(:stub_responses) { true }

          it 'gets the next stub and applies it' do
            expect(stubs).to receive(:next)
              .with(:operation).and_return(Exception.new)
            output = subject.call(input, context)
            expect(output.error).to be_a(Exception)
          end

          it 'rewinds the body' do
            expect(stubs).to receive(:next)
              .with(:operation).and_return(Exception.new)
            expect(body).to receive(:rewind)
            subject.call(input, context)
          end

          context 'stub is an Exception' do
            let(:error) { Exception.new }

            before { stubs.set_stubs(operation, [error]) }

            it 'sets the output error as the exception' do
              output = subject.call(input, context)
              expect(output.error).to be(error)
            end

            context 'as a proc' do
              let(:stub_proc) { proc { error } }

              before { stubs.set_stubs(operation, [stub_proc]) }

              it 'sets the output error as the exception' do
                output = subject.call(input, context)
                expect(output.error).to be(error)
              end
            end
          end

          context 'stub is an ApiError' do
            let(:error) { Hearth::ApiError.new(error_code: 'error') }

            before { stubs.set_stubs(operation, [error]) }

            it 'sets the output error as the error' do
              output = subject.call(input, context)
              expect(output.error).to be(error)
            end

            context 'as a proc' do
              let(:stub_proc) { proc { error } }

              before { stubs.set_stubs(operation, [stub_proc]) }

              it 'sets the output error as the error' do
                output = subject.call(input, context)
                expect(output.error).to be(error)
              end
            end
          end

          context 'stub is a hash' do
            context 'data stub' do
              let(:stub_hash) { { member: 'value' } }
              let(:stub_data) { TestStubs::Types::StubData.new(**stub_hash) }

              before { stubs.set_stubs(operation, [{ data: stub_hash }]) }

              it 'uses the data hash to stub the response' do
                expect(TestStubs::Stubs::StubData).to receive(:build)
                  .with(stub_hash, context: 'stub')
                  .and_return(stub_data)
                expect(TestStubs::Stubs::StubData).to receive(:validate!)
                  .with(stub_data, context: 'stub')
                expect(TestStubs::Stubs::StubData).to receive(:stub)
                  .with(response, stub: stub_data)
                subject.call(input, context)
              end

              context 'as a proc' do
                let(:stub_proc) { proc { { data: stub_hash } } }

                before { stubs.set_stubs(operation, [stub_proc]) }

                it 'uses the data hash to stub the response' do
                  expect(TestStubs::Stubs::StubData).to receive(:build)
                    .with(stub_hash, context: 'stub')
                    .and_return(stub_data)
                  expect(TestStubs::Stubs::StubData).to receive(:validate!)
                    .with(stub_data, context: 'stub')
                  expect(TestStubs::Stubs::StubData).to receive(:stub)
                    .with(response, stub: stub_data)
                  subject.call(input, context)
                end
              end
            end

            context 'error stub' do
              let(:stub_hash) do
                { class: TestStubs::Errors::StubError, data: stub_error_data }
              end
              let(:stub_error_data) { { message: 'error' } }
              let(:stub_error) do
                TestStubs::Types::StubErrorData.new(**stub_error_data)
              end

              before { stubs.set_stubs(operation, [{ error: stub_hash }]) }

              it 'uses the error hash to stub the response' do
                expect(TestStubs::Stubs::StubError).to receive(:build)
                  .with(stub_error_data, context: 'stub')
                  .and_return(stub_error)
                expect(TestStubs::Stubs::StubError).to receive(:validate!)
                  .with(stub_error, context: 'stub')
                expect(TestStubs::Stubs::StubError).to receive(:stub)
                  .with(response, stub: stub_error)
                subject.call(input, context)
              end

              context 'as a proc' do
                let(:stub_proc) { proc { { error: stub_hash } } }

                before { stubs.set_stubs(operation, [stub_proc]) }

                it 'uses the error hash to stub the response' do
                  expect(TestStubs::Stubs::StubError).to receive(:build)
                    .with(stub_error_data, context: 'stub')
                    .and_return(stub_error)
                  expect(TestStubs::Stubs::StubError).to receive(:validate!)
                    .with(stub_error, context: 'stub')
                  expect(TestStubs::Stubs::StubError).to receive(:stub)
                    .with(response, stub: stub_error)
                  subject.call(input, context)
                end
              end

              it 'raises when missing an error class' do
                stub_hash.delete(:class)
                expect do
                  subject.call(input, context)
                end.to raise_error(
                  ArgumentError,
                  /Missing stub error class/
                )
              end

              it 'raises when error is not a class' do
                stub_hash[:class] = stub_error_data
                expect do
                  subject.call(input, context)
                end.to raise_error(
                  ArgumentError,
                  /Stub error class must be a class/
                )
              end

              it 'raises with unknown error class' do
                stub_hash[:class] = TestStubs::Errors::OtherError
                expect do
                  subject.call(input, context)
                end.to raise_error(
                  ArgumentError,
                  /Unsupported stub error class/
                )
              end
            end

            context 'neither' do
              it 'raises an error' do
                stubs.set_stubs(operation, [{ member: 'value' }])
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError, /:data or :error/)
              end
            end

            context 'both' do
              it 'raises an error' do
                stubs.set_stubs(operation, [{ data: {}, error: {} }])
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError, /:data or :error/)
              end
            end
          end

          context 'stub is nil' do
            let(:stub_hash) { { member: 'value' } }
            let(:stub_data) { TestStubs::Types::StubData.new(**stub_hash) }

            before { stubs.set_stubs(operation, [nil]) }

            it 'uses the stub class default' do
              expect(TestStubs::Stubs::StubData).to receive(:default)
                .and_return(stub_hash)
              expect(TestStubs::Stubs::StubData).to receive(:build)
                .with(stub_hash, context: 'stub')
                .and_return(stub_data)
              expect(TestStubs::Stubs::StubData).to receive(:validate!)
              expect(TestStubs::Stubs::StubData).to receive(:stub)
                .with(response, stub: stub_data)
              subject.call(input, context)
            end

            context 'as a proc' do
              let(:stub_proc) { proc {} }

              before { stubs.set_stubs(operation, [stub_proc]) }

              it 'uses the stub class default' do
                expect(TestStubs::Stubs::StubData).to receive(:default)
                  .and_return(stub_hash)
                expect(TestStubs::Stubs::StubData).to receive(:build)
                  .with(stub_hash, context: 'stub')
                  .and_return(stub_data)
                expect(TestStubs::Stubs::StubData).to receive(:validate!)
                expect(TestStubs::Stubs::StubData).to receive(:stub)
                  .with(response, stub: stub_data)
                subject.call(input, context)
              end
            end
          end

          context 'stub is a Hearth::Structure' do
            let(:stub_data) { TestStubs::Types::StubData.new(member: 'value') }

            before { stubs.set_stubs(operation, [stub_data]) }

            it 'uses the stub class to stub the response' do
              expect(TestStubs::Stubs::StubData).to receive(:validate!)
                .with(stub_data, context: 'stub')
              expect(TestStubs::Stubs::StubData).to receive(:stub)
                .with(response, stub: stub_data)
              subject.call(input, context)
            end

            context 'as a proc' do
              let(:stub_proc) { proc { stub_data } }

              before { stubs.set_stubs(operation, [stub_proc]) }

              it 'uses the stub class to stub the response' do
                expect(TestStubs::Stubs::StubData).to receive(:validate!)
                  .with(stub_data, context: 'stub')
                expect(TestStubs::Stubs::StubData).to receive(:stub)
                  .with(response, stub: stub_data)
                subject.call(input, context)
              end
            end
          end

          context 'stub is a Hearth::Response' do
            let(:stub_response) { Hearth::Response.new(body: body) }

            before { stubs.set_stubs(operation, [stub_response]) }

            it 'sets the response to the stub' do
              expect(context.response)
                .to receive(:replace).with(stub_response)
              subject.call(input, context)
            end

            context 'as a proc' do
              let(:stub_proc) { proc { stub_response } }

              before { stubs.set_stubs(operation, [stub_proc]) }

              it 'sets the response to the stub' do
                expect(context.response).to receive(:replace)
                  .with(stub_response)
                subject.call(input, context)
              end
            end
          end

          context 'stub is something else' do
            before { stubs.set_stubs(operation, ['some string']) }

            it 'raises a ArgumentError' do
              expect do
                subject.call(input, context)
              end.to raise_error(ArgumentError)
            end

            context 'as a proc' do
              let(:stub_proc) { proc { 'some string' } }

              before { stubs.set_stubs(operation, [stub_proc]) }

              it 'raises a ArgumentError' do
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError)
              end
            end
          end
        end

        context 'response_events and stub_responses' do
          let(:stub_responses) { true }
          let(:response_events) { true }

          context 'stub is a proc' do
            let(:stub_proc) { proc {} }
            let(:stub_error) { Exception.new }
            before { stubs.set_stubs(operation, [stub_proc]) }

            it 'calls the proc and applies the returned stub' do
              expect(stub_proc).to receive(:call)
                .with(input).and_return(stub_error)
              output = subject.call(input, context)
              expect(output.error).to be(stub_error)
            end
          end

          context 'stub is an APIError' do
            let(:error) { ApiError.new(error_code: 'error') }
            let(:handler) { double }
            before do
              stubs.set_stubs(operation, [error])
              context.metadata[:event_handler] = handler
            end

            it 'calls emit_error on the handler' do
              expect(handler).to receive(:emit_error).with(error)
              subject.call(input, context)
            end
          end

          context 'stub is an Exception' do
            let(:error) { Exception.new }
            before { stubs.set_stubs(operation, [error]) }

            it 'sets the output error as the error' do
              output = subject.call(input, context)
              expect(output.error).to be(error)
            end
          end

          context 'stub is a hash' do
            context 'event is a message' do
              let(:message) { EventStream::Message.new }
              let(:encoded) { 'encoded' }

              before do
                stubs.set_stubs(operation, [{ events: [message] }])
              end

              it 'encodes and sends the event' do
                expect(message_encoder).to receive(:encode).with(message)
                                                           .and_return(encoded)
                decoder = response.body
                expect(decoder).to receive(:write).with(encoded)
                subject.call(input, context)
              end
            end

            context 'event is a Structure' do
              let(:event) do
                TestStubs::Types::StubData.new(member: 'event')
              end
              let(:message) { EventStream::Message.new }
              let(:encoded) { 'encoded' }

              before do
                stubs.set_stubs(operation, [{ events: [event] }])
              end

              it 'stubs, encodes and sends the event' do
                expect(TestStubs::Stubs::StubData).to receive(:stub_event)
                  .and_return(message)
                expect(message_encoder).to receive(:encode).with(message)
                                                           .and_return(encoded)
                decoder = response.body
                expect(decoder).to receive(:write).with(encoded)
                subject.call(input, context)
              end
            end

            context 'event is unsupported' do
              before do
                stubs.set_stubs(operation, [{ events: ['invalid'] }])
              end

              it 'raises a ArgumentError' do
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError)
              end
            end

            context 'initial_response is a Structure' do
              let(:stub_data) do
                TestStubs::Types::StubData.new(member: 'value')
              end
              let(:message) { EventStream::Message.new }
              let(:encoded) { 'encoded' }

              before do
                stubs.set_stubs(operation, [{ initial_response: stub_data }])
              end

              it 'validates, encodes and sends the initial response event' do
                expect(TestStubs::Stubs::StubData).to receive(:validate!)
                  .with(stub_data, context: 'stub')
                expect(TestStubs::Stubs::StubData).to receive(:stub)
                  .with(response, stub: stub_data) do |resp, _ctx|
                  resp.body = message
                end
                expect(message_encoder).to receive(:encode).with(message)
                                                           .and_return(encoded)
                decoder = response.body
                expect(decoder).to receive(:write).with(encoded)
                subject.call(input, context)
                expect(response.body).to be(decoder) # does not replace body
              end
            end

            context 'initial_response is a Hash' do
              let(:stub_data) do
                TestStubs::Types::StubData.new(member: 'value')
              end
              let(:message) { EventStream::Message.new }
              let(:encoded) { 'encoded' }

              before do
                stubs.set_stubs(operation, [
                                  { initial_response: { member: 'value' } }
                                ])
              end

              it 'builds, validates, encodes and sends the initial response' do
                expect(TestStubs::Stubs::StubData).to receive(:build)
                  .and_return(stub_data)
                expect(TestStubs::Stubs::StubData).to receive(:validate!)
                  .with(stub_data, context: 'stub')
                expect(TestStubs::Stubs::StubData).to receive(:stub)
                  .with(response, stub: stub_data) do |resp, _ctx|
                  resp.body = message
                end
                expect(message_encoder).to receive(:encode).with(message)
                                                           .and_return(encoded)
                decoder = response.body
                expect(decoder).to receive(:write).with(encoded)
                subject.call(input, context)
                expect(response.body).to be(decoder) # does not replace body
              end
            end

            context 'initial_response is a Response' do
              let(:decoder) { double(truncate: nil, rewind: nil) }
              let(:response) { HTTP2::Response.new(body: decoder) }
              let(:message) { EventStream::Message.new }
              let(:stub_response) { HTTP2::Response.new(body: message) }
              let(:encoded) { 'encoded' }

              before do
                stubs.set_stubs(operation, [
                                  { initial_response: stub_response }
                                ])
              end

              it 'sends the initial response' do
                expect(message_encoder).to receive(:encode).with(message)
                                                           .and_return(encoded)
                decoder = response.body
                expect(decoder).to receive(:write).with(encoded).and_return(0)
                subject.call(input, context)
                expect(response.body).to be(decoder) # does not replace body
              end
            end

            context 'initial_response is unsupported' do
              before do
                stubs.set_stubs(operation, [{ initial_response: 'invalid' }])
              end

              it 'raises a ArgumentError' do
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError)
              end
            end
          end

          context 'stub is nil' do
            let(:default_response) do
              TestStubs::Types::StubData.new(member: 'default initial')
            end
            let(:default_event) do
              TestStubs::Types::StubData.new(member: 'default event')
            end
            let(:initial_message) { EventStream::Message.new }
            let(:encoded_initial) { 'encoded_initial' }
            let(:event_message) { EventStream::Message.new }
            let(:encoded_event) { 'encoded_event' }

            it 'sends a default initial response and event' do
              expect(TestStubs::Stubs::StubData).to receive(:default)
                .and_return(default_response)
              expect(TestStubs::Stubs::StubData).to receive(:validate!)
                .with(default_response, context: 'stub')
              expect(TestStubs::Stubs::StubData).to receive(:stub)
                .with(response, stub: default_response) do |resp, _ctx|
                resp.body = initial_message
              end
              expect(message_encoder)
                .to receive(:encode).with(initial_message)
                                    .and_return(encoded_initial)

              expect(TestStubs::Stubs::StubData).to receive(:default_event)
                .and_return(default_event)
              expect(TestStubs::Stubs::StubData).to receive(:stub_event)
                .and_return(event_message)
              expect(message_encoder).to receive(:encode)
                .with(event_message)
                .and_return(encoded_event)

              decoder = response.body
              expect(decoder).to receive(:write).with(encoded_initial)
              expect(decoder).to receive(:write).with(encoded_event)

              subject.call(input, context)
              expect(response.body).to be(decoder) # does not replace body
            end
          end

          context 'stub is Structure' do
            let(:stub_data) { TestStubs::Types::StubData.new(member: 'value') }
            let(:message) { EventStream::Message.new }
            let(:encoded) { 'encoded' }

            before do
              stubs.set_stubs(operation, [stub_data])
            end

            it 'validates, encodes and sends the initial response event' do
              expect(TestStubs::Stubs::StubData).to receive(:validate!)
                .with(stub_data, context: 'stub')
              expect(TestStubs::Stubs::StubData).to receive(:stub)
                .with(response, stub: stub_data) do |resp, _ctx|
                resp.body = message
              end
              expect(message_encoder).to receive(:encode).with(message)
                                                         .and_return(encoded)
              decoder = response.body
              expect(decoder).to receive(:write).with(encoded)
              subject.call(input, context)
              expect(response.body).to be(decoder) # does not replace body
            end
          end

          context 'stub is a Response' do
            let(:decoder) { double(truncate: nil, rewind: nil) }
            let(:response) { HTTP2::Response.new(body: decoder) }
            let(:message) { EventStream::Message.new }
            let(:stub_response) { HTTP2::Response.new(body: message) }
            let(:encoded) { 'encoded' }

            before do
              stubs.set_stubs(operation, [stub_response])
            end

            it 'sends the initial response' do
              expect(message_encoder).to receive(:encode).with(message)
                                                         .and_return(encoded)
              decoder = response.body
              expect(decoder).to receive(:write).with(encoded).and_return(0)
              subject.call(input, context)
              expect(response.body).to be(decoder) # does not replace body
            end
          end

          context 'stub is unsupported' do
            before do
              stubs.set_stubs(operation, ['invalid'])
            end

            it 'raises a ArgumentError' do
              expect do
                subject.call(input, context)
              end.to raise_error(ArgumentError)
            end
          end
        end
      end
    end
  end
end
