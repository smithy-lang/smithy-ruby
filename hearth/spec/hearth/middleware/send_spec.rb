# frozen_string_literal: true

module Hearth
  module Middleware
    module Types
      StubData = ::Struct.new(:member, keyword_init: true) do
        include Hearth::Structure
      end

      StubErrorData = ::Struct.new(:message, keyword_init: true) do
        include Hearth::Structure
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

    describe Send do
      let(:app) { double('app', call: output) }
      let(:client) { double('client') }
      let(:stub_responses) { false }
      let(:stubs) { Hearth::Stubbing::Stubs.new }
      let(:logger) { double('Logger') }

      subject do
        Send.new(
          app,
          client: client,
          stub_responses: stub_responses,
          stub_data_class: Stubs::StubData,
          stub_error_classes: [Stubs::StubError],
          stubs: stubs
        )
      end

      describe '#call' do
        let(:operation) { :operation }
        let(:input) { double('Type::OperationInput') }

        let(:request) { double('request') }
        let(:body) { StringIO.new }
        let(:response) { double('response', body: body) }
        let(:interceptors) { double('interceptors', apply: nil) }
        let(:context) do
          Hearth::Context.new(
            request: request,
            response: response,
            operation_name: operation,
            logger: logger,
            interceptors: interceptors
          )
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

        it 'calls all of the interceptor hooks' do
          expect(interceptors).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::MODIFY_BEFORE_TRANSMIT
                  )).ordered
          expect(interceptors).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::READ_BEFORE_TRANSMIT
                  )).ordered

          expect(client).to receive(:transmit)
            .and_return(response).ordered

          expect(interceptors).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::READ_AFTER_TRANSMIT
                  )).ordered

          subject.call(input, context)
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

          context 'stub is a proc' do
            before { stubs.add_stubs(operation, [stub_proc]) }

            context 'proc returns a stub' do
              let(:exception) { Exception.new }
              let(:stub_proc) { proc { exception } }

              it 'calls the stub and applies it' do
                expect(stub_proc).to receive(:call)
                  .with(input, context).and_call_original
                output = subject.call(input, context)
                expect(output.error).to be(exception)
              end
            end

            context 'proc returns nil' do
              let(:url) { 'https://example.com' }
              let(:status) { 418 }
              let(:more_context) { 'more_context' }
              let(:response) { Hearth::HTTP::Response.new }

              let(:stub_proc) do
                lambda do |_input, context|
                  context.response.status = status
                  context.metadata[:more_context] = more_context
                  nil
                end
              end

              it 'allows stubbing of request, response, and context' do
                expect(stub_proc).to receive(:call)
                  .with(input, context).and_call_original
                expect(Stubs::StubData).to_not receive(:stub)
                subject.call(input, context)
                expect(response.status).to eq status
                expect(context.metadata[:more_context]).to eq(more_context)
              end
            end
          end

          context 'stub is an Exception' do
            let(:error) { Exception.new }

            before { stubs.add_stubs(operation, [error]) }

            it 'sets the output error as the exception' do
              output = subject.call(input, context)
              expect(output.error).to be(error)
            end
          end

          context 'stub is an ApiError' do
            let(:error) { Hearth::ApiError.new(error_code: 'error') }

            before { stubs.add_stubs(operation, [error]) }

            it 'sets the output error as the error' do
              output = subject.call(input, context)
              expect(output.error).to be(error)
            end
          end

          context 'stub is a hash' do
            context 'data stub' do
              let(:stub_hash) { { member: 'value' } }
              let(:stub_data) { Types::StubData.new(**stub_hash) }

              before { stubs.add_stubs(operation, [{ data: stub_hash }]) }

              it 'uses the data hash to stub the response' do
                expect(Stubs::StubData).to receive(:build)
                  .with(stub_hash, context: 'stub')
                  .and_return(stub_data)
                expect(Stubs::StubData).to receive(:validate!)
                  .with(stub_data, context: 'stub')
                expect(Stubs::StubData).to receive(:stub)
                  .with(response, stub: stub_data)
                subject.call(input, context)
              end
            end

            context 'error stub' do
              let(:stub_hash) do
                { class: Errors::StubError, data: stub_error_data }
              end
              let(:stub_error_data) { { message: 'error' } }
              let(:stub_error) { Types::StubErrorData.new(**stub_error_data) }

              before { stubs.add_stubs(operation, [{ error: stub_hash }]) }

              it 'uses the error hash to stub the response' do
                expect(Stubs::StubError).to receive(:build)
                  .with(stub_error_data, context: 'stub')
                  .and_return(stub_error)
                expect(Stubs::StubError).to receive(:validate!)
                  .with(stub_error, context: 'stub')
                expect(Stubs::StubError).to receive(:stub)
                  .with(response, stub: stub_error)
                subject.call(input, context)
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
                stub_hash[:class] = Errors::OtherError
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
                stubs.add_stubs(operation, [{ member: 'value' }])
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError, /:data or :error/)
              end
            end

            context 'both' do
              it 'raises an error' do
                stubs.add_stubs(operation, [{ data: {}, error: {} }])
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError, /:data or :error/)
              end
            end
          end

          context 'stub is nil' do
            let(:stub_hash) { { member: 'value' } }
            let(:stub_data) { Types::StubData.new(**stub_hash) }

            before { stubs.add_stubs(operation, [nil]) }

            it 'uses the stub class default' do
              expect(Stubs::StubData).to receive(:default)
                .and_return(stub_hash)
              expect(Stubs::StubData).to receive(:build)
                .with(stub_hash, context: 'stub')
                .and_return(stub_data)
              expect(Stubs::StubData).to receive(:stub)
                .with(response, stub: stub_data)
              subject.call(input, context)
            end
          end

          context 'stub is a Hearth::Structure' do
            let(:stub_data) { Types::StubData.new(member: 'value') }

            before { stubs.add_stubs(operation, [stub_data]) }

            it 'uses the stub class to stub the response' do
              expect(Stubs::StubData).to receive(:validate!)
                .with(stub_data, context: 'stub')
              expect(Stubs::StubData).to receive(:stub)
                .with(response, stub: stub_data)
              subject.call(input, context)
            end
          end

          context 'stub is a Hearth::Response' do
            let(:stub_response) { Hearth::Response.new(body: body) }

            before { stubs.add_stubs(operation, [stub_response]) }

            it 'sets the response to the stub' do
              expect(context.response).to receive(:replace)
                .with(stub_response)

              subject.call(input, context)
            end
          end

          context 'stub is something else' do
            before { stubs.add_stubs(operation, ['some string']) }

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
