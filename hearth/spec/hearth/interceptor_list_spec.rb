# frozen_string_literal: true

module Hearth
  describe InterceptorList do
    let(:interceptor) do
      Interceptor.new(read_before_execution: proc { |_context| })
    end

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

      it 'raises when interceptor does not implement hook methods' do
        expect do
          subject.append(Interceptor.new(foo: proc { |_context| }))
        end.to raise_error(ArgumentError, /Invalid interceptor/)
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
