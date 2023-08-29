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
