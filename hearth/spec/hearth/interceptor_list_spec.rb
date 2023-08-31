# frozen_string_literal: true

module Hearth
  describe InterceptorList do
    let(:interceptor_class) do
      Class.new(Interceptor) do
        def read_before_execution(_ctx); end
      end
    end

    let(:interceptor) { interceptor_class.new }

    it 'is enumerable' do
      expect(InterceptorList).to include(Enumerable)
      expect(InterceptorList.new).to respond_to(:each)
    end

    describe '#initialize' do
      it 'can be initialized with a list of Interceptor' do
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

    describe '#append' do
      it 'appends the interceptor' do
        subject.append(interceptor)
        expect(subject.to_a).to eq([interceptor])
      end

      context 'not an Interceptor' do
        let(:invalid_interceptor_class) do
          Class.new do
            def read_before_execution(_ctx); end
          end
        end

        it 'raises an argument error' do
          expect do
            subject.append(invalid_interceptor_class.new)
          end.to raise_error(ArgumentError)
        end
      end
    end

    describe '#concat' do
      let(:other_list) { InterceptorList.new([interceptor]) }

      it 'appends all interceptors from the list' do
        subject.concat(other_list)
        expect(subject.to_a).to eq([interceptor])
      end

      it 'returns self' do
        expect(subject.concat(other_list)).to be(subject)
      end
    end

    describe '#dup' do
      it 'creates a deep copy' do
        orig = InterceptorList.new
        copy = orig.dup
        copy.append(interceptor)

        expect(orig.to_a).to be_empty
      end
    end
  end
end
