# frozen_string_literal: true

module Hearth
  describe Interceptor do
    describe '#apply' do
      let(:interceptor_class) do
        Class.new do
          def read_before_execution(_ctx); end
        end
      end

      let(:interceptor1) { interceptor_class.new }
      let(:interceptor2) { interceptor_class.new }
      let(:logger) { double('logger') }
      let(:input) { double('input') }
      let(:output) { double('output', error: nil) }
      let(:request) { double('request') }
      let(:response) { double('response') }
      let(:context) do
        double(
          'context',
          request: request,
          response: response,
          logger: logger
        )
      end
      let(:i_ctx) { double('interceptor_context') }
      let(:error) { StandardError.new }

      let(:interceptors) do
        InterceptorList.new([interceptor1, interceptor2])
      end
      let(:hook) { :read_before_execution }

      it 'calls each interceptor hook with context' do
        expect(Interceptor::Context).to receive(:new).with(
          input: input,
          request: request,
          response: response,
          output: output
        ).and_return(i_ctx)

        expect(interceptor1).to receive(hook).with(i_ctx)
        expect(interceptor2).to receive(hook).with(i_ctx)

        out = Interceptor.apply(
          interceptors: interceptors,
          hook: hook,
          input: input,
          context: context,
          output: output
        )

        expect(out).to be_nil
      end

      it 'sets the error on output' do
        expect(interceptor1).to receive(hook).and_raise(error)
        expect(output).to receive(:error=).with(error)

        Interceptor.apply(
          interceptors: interceptors,
          hook: hook,
          input: input,
          context: context,
          output: output
        )
      end

      context 'previous error on output' do
        let(:previous_error) { StandardError.new('previous') }
        let(:output) { double('output', error: previous_error) }

        it 'sets the new error on output and logs the previous' do
          expect(interceptor1).to receive(hook).and_raise(error)
          expect(logger).to receive(:error).with(previous_error)
          expect(output).to receive(:error=).with(error)

          Interceptor.apply(
            interceptors: interceptors,
            hook: hook,
            input: input,
            context: context,
            output: output
          )
        end
      end

      context 'aggregate_errors: false' do
        let(:aggregate_errors) { false }

        it 'returns the first error immediately' do
          expect(interceptor1).to receive(hook).and_raise(error)
          expect(interceptor2).not_to receive(hook)

          out = Interceptor.apply(
            interceptors: interceptors,
            hook: hook,
            input: input,
            context: context,
            output: nil,
            aggregate_errors: aggregate_errors
          )
          expect(out).to eq(error)
        end
      end

      context 'aggregate_errors: true' do
        let(:aggregate_errors) { true }
        let(:error1) { StandardError.new('error 1') }
        let(:error2) { StandardError.new('error 2') }

        it 'calls all interceptors and returns the last error' do
          expect(interceptor1).to receive(hook).and_raise(error1)
          expect(interceptor2).to receive(hook).and_raise(error2)
          expect(logger).to receive(:error).with(error1)

          out = Interceptor.apply(
            interceptors: interceptors,
            hook: hook,
            input: input,
            context: context,
            output: nil,
            aggregate_errors: aggregate_errors
          )

          expect(out).to eq(error2)
        end
      end
    end
  end
end
