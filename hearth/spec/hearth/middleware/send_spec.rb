# frozen_string_literal: true

module Hearth
  module Middleware
    StubOutput = ::Struct.new(:param1, keyword_init: true) do
      include Hearth::Structure
    end

    describe Send do
      let(:app) { double('app', call: output) }
      let(:client) { double('client') }
      let(:stub_responses) { false }
      let(:stub_class) { double('stub_class') }
      let(:params_class) { double('params_class') }
      let(:stubs) { Hearth::Stubbing::Stubs.new }
      let(:logger) { double('Logger') }

      subject do
        Send.new(
          app,
          client: client,
          stub_responses: stub_responses,
          stub_class: stub_class,
          params_class: params_class,
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
                expect(stub_class).to_not receive(:stub)
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
            let(:stub_hash) { { param1: 'value' } }
            let(:output_type) { StubOutput.new(**stub_hash) }

            before { stubs.add_stubs(operation, [stub_hash]) }

            it 'uses the stub class to stub the response' do
              expect(params_class).to receive(:build)
                .with(stub_hash, context: 'stub')
                .and_return(output_type)
              expect(stub_class).to receive(:stub)
                .with(response, stub: output_type)
              subject.call(input, context)
            end
          end

          context 'stub is nil' do
            let(:stub_hash) { { param1: 'value' } }
            let(:output_type) { StubOutput.new(**stub_hash) }

            before { stubs.add_stubs(operation, [nil]) }

            it 'uses the stub class default' do
              expect(stub_class).to receive(:default)
                .and_return(stub_hash)
              expect(params_class).to receive(:build)
                .with(stub_hash, context: 'stub')
                .and_return(output_type)

              expect(stub_class).to receive(:stub)
                .with(response, stub: output_type)
              subject.call(input, context)
            end
          end

          context 'stub is a Hearth::Structure' do
            let(:output_type) { StubOutput.new(param1: 'value') }

            before { stubs.add_stubs(operation, [output_type]) }

            it 'uses the stub class to stub the response' do
              expect(stub_class).to receive(:stub)
                .with(response, stub: output_type)
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
