# frozen_string_literal: true

module Hearth
  describe InterceptorList do
    let(:interceptor_class) do
      Class.new do
        def read_before_execution(_ctx); end
      end
    end

    let(:interceptor) { interceptor_class.new }

    it 'is enumerable' do
      expect(InterceptorList).to include(Enumerable)
      expect(InterceptorList.new).to respond_to(:each)
    end

    describe '#initialize' do
      it 'raises when given a non enumerable' do
        expect do
          InterceptorList.new('bad_arg')
        end.to raise_error(ArgumentError)
      end

      it 'can be initialized with a list of interceptors' do
        interceptors = InterceptorList.new([interceptor])
        expect(interceptors.to_a).to eq([interceptor])
      end

      it 'can be initialized from an InterceptorList' do
        interceptors = InterceptorList.new(
          InterceptorList.new([interceptor])
        )
        expect(interceptors.to_a).to eq([interceptor])
      end
    end

    describe '#add' do
      let(:interceptors) { InterceptorList.new }

      it 'adds the interceptor' do
        interceptors.add(interceptor)
        expect(interceptors.to_a).to eq([interceptor])
      end

      context 'interceptor list' do
        let(:other_list) { InterceptorList.new([interceptor]) }

        it 'adds all interceptors from the list' do
          interceptors.add(other_list)
          expect(interceptors.to_a).to eq([interceptor])
        end
      end

      context 'does not implement any hooks' do
        let(:invalid_interceptor) do
          Class.new.new
        end

        it 'raises an argument error' do
          expect do
            interceptors.add(invalid_interceptor)
          end.to raise_error(ArgumentError)
        end
      end
    end

    describe '#apply' do
      let(:interceptor1) { interceptor_class.new }
      let(:interceptor2) { interceptor_class.new }
      let(:logger) { double('logger') }
      let(:input) { double('input') }
      let(:output) { double('output') }
      let(:context) { double('context', logger: logger) }
      let(:ictx) { double('interceptor_context') }
      let(:error) { StandardError.new }

      let(:interceptors) do
        InterceptorList.new([interceptor1, interceptor2])
      end
      let(:hook) { :read_before_execution }

      before(:each) do
        allow(context).to receive(:interceptor_context).and_return(ictx)
      end

      it 'calls each interceptor hook with context' do
        expect(context).to receive(:interceptor_context)
          .with(input, output).and_return(ictx)
        expect(interceptor1).to receive(hook).with(ictx)
        expect(interceptor2).to receive(hook).with(ictx)

        out = interceptors.apply(
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

        interceptors.apply(
          hook: hook,
          input: input,
          context: context,
          output: output
        )
      end

      context 'aggregate_errors: false' do
        let(:aggregate_errors) { false }

        it 'returns the first error immediately' do
          expect(interceptor1).to receive(hook).and_raise(error)
          expect(interceptor2).not_to receive(hook)

          out = interceptors.apply(
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

          out = interceptors.apply(
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

    describe '#dup' do
      it 'creates a deep copy' do
        orig = InterceptorList.new
        copy = orig.dup
        copy.add(interceptor)

        expect(orig.to_a).to be_empty
      end
    end
  end
end
