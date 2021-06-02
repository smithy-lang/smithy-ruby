# frozen_string_literal: true

module Seahorse
  module Middleware

    describe Send do
      let(:app) { double('app', call: output) }
      let(:client) { double('client') }
      let(:stub_responses) { false }
      let(:stub_class) { double('stub_class') }
      let(:stubs) { Seahorse::Stubbing::Stubs.new }

      subject do
        Send.new(
          app,
          client: client,
          stub_responses: stub_responses,
          stub_class: stub_class,
          stubs: stubs
        )
      end

      describe '#call' do
        let(:operation) { :operation }
        let(:input) { double('Type::OperationInput') }

        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:context) do
          Seahorse::Context.new(
            request: request,
            response: response,
            operation_name: operation
          )
        end

        it 'sends the request and returns an output object' do
          expect(client).to receive(:transmit).with(
            request: request,
            response: response
          )

          expect(
            subject.call(input, context)
          ).to be_a Seahorse::Output
        end

        context 'stub_responses is true' do
          let(:stub_responses) { true }

          it 'gets the next stub and applies it' do
            expect(stubs).to receive(:next)
              .with(:operation).and_return(Exception)
            output = subject.call(input, context)
            expect(output.error).to be_a(Exception)
          end

          context 'stub is a proc' do
            before { stubs.add_stubs(operation, [stub_proc]) }

            context 'proc returns a stub' do
              let(:exception) { Exception.new }
              let(:stub_proc) { proc { exception } }

              it 'calls the stub and applies it' do
                expect(stub_proc).to receive(:call)
                  .with(context).and_call_original
                output = subject.call(input, context)
                expect(output.error).to be(exception)
              end
            end

            context 'proc returns nil' do
              let(:url) { 'https://example.com' }
              let(:status) { 418 }
              let(:more_context) { 'more_context' }
              let(:response) { Seahorse::HTTP::Response.new }

              let(:stub_proc) do
                lambda do |ctx|
                  ctx.response.status = status
                  ctx.metadata[:more_context] = more_context
                  nil
                end
              end

              it 'allows stubbing of request, response, and context' do
                expect(stub_proc).to receive(:call)
                  .with(context).and_call_original
                expect(stub_class).to_not receive(:stub)
                subject.call(input, context)
                expect(response.status).to eq status
                expect(context.metadata[:more_context]).to eq(more_context)
              end
            end
          end

          context 'stub is an Exception' do
            let(:exception) { Exception.new }
            before { stubs.add_stubs(operation, [exception]) }
            it 'sets the output error to a new instance of the class' do
              output = subject.call(input, context)
              expect(output.error).to be(exception)
            end
          end

          context 'stub is a class' do
            before { stubs.add_stubs(operation, [Exception]) }
            it 'sets the output error to a new instance of the class' do
              output = subject.call(input, context)
              expect(output.error).to be_a(Exception)
            end
          end

          context 'stub is a hash' do
            let(:stub_hash) { {param1: 'value'} }
            before { stubs.add_stubs(operation, [stub_hash]) }

            it 'uses the stub class to stub the response' do
              expect(stub_class).to receive(:stub).with(response, stub_hash)
              subject.call(input, context)
            end
          end

          context 'stub is nil' do
            let(:stub_hash) { {param1: 'value'} }
            before { stubs.add_stubs(operation, [nil]) }

            it 'uses the stub class default' do
              expect(stub_class).to receive(:default).and_return(stub_hash)
              expect(stub_class).to receive(:stub).with(response, stub_hash)
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
