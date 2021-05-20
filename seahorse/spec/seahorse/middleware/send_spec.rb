# frozen_string_literal: true

module Seahorse
  module Middleware

    describe Send do
      let(:app) { double('app') }
      let(:client) { double('client') }
      let(:operation) { :operation }
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
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { { api_method: operation } }

        it 'sends the request and returns an output object' do
          expect(client).to receive(:transmit).with(
            request: request,
            response: response
          )

          expect(
            subject.call(
              request: request,
              response: response,
              context: context
            )
          ).to be_a Seahorse::Output
        end

        context 'stub_responses is true' do
          let(:stub_responses) { true }

          it 'gets the next stub and applies it' do
            expect(stubs).to receive(:next)
              .with(:operation).and_return(Exception)
            output = subject.call(
              request: request,
              response: response,
              context: context
            )
            expect(output.error).to be_a(Exception)
          end

          context 'stub is a proc' do
            let(:exception) { Exception.new }
            let(:stub_proc) { proc { exception } }

            before { stubs.add_stubs(operation, [stub_proc]) }
            it 'calls the stub and applies it' do
              expect(stub_proc).to receive(:call).and_call_original
              output = subject.call(
                request: request,
                response: response,
                context: context
              )
              expect(output.error).to be(exception)
            end
          end

          context 'stub is an Exception' do
            let(:exception) { Exception.new }
            before { stubs.add_stubs(operation, [exception]) }
            it 'sets the output error to a new instance of the class' do
              output = subject.call(
                request: request,
                response: response,
                context: context
              )
              expect(output.error).to be(exception)
            end
          end

          context 'stub is a class' do
            before { stubs.add_stubs(operation, [Exception]) }
            it 'sets the output error to a new instance of the class' do
              output = subject.call(
                request: request,
                response: response,
                context: context
              )
              expect(output.error).to be_a(Exception)
            end
          end

          context 'stub is a hash' do
            let(:stub_hash) { {param1: 'value'} }
            before { stubs.add_stubs(operation, [stub_hash]) }

            it 'uses the stub class to stub the response' do
              expect(stub_class).to receive(:stub).with(response, stub_hash)
              subject.call(
                request: request,
                response: response,
                context: context
              )
            end
          end

          context 'stub is something else' do
            before { stubs.add_stubs(operation, ['some string']) }

            it 'raises a ArgumentError' do
              expect do
                subject.call(
                  request: request,
                  response: response,
                  context: context
                )
              end.to raise_error(ArgumentError)
            end
          end
        end
      end
    end

  end
end
