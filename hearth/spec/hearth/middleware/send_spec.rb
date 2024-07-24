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

      subject do
        Send.new(
          app,
          client: client,
          stub_responses: stub_responses,
          stub_data_class: TestStubs::Stubs::StubData,
          stub_error_classes: [TestStubs::Stubs::StubError],
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
      end
    end
  end
end
