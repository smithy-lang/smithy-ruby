# frozen_string_literal: true

module Hearth
  describe AnonymousAuthResolver do
    let(:error_code) { 'error_code' }
    let(:metadata) { { key: 'value' } }
    let(:message) { 'message' }

    subject do
      AnonymousAuthResolver.new
    end

    describe '#resolve' do
      it 'returns a list with anonymous/noAuth' do
        res = subject.resolve({})
        expect(res.size).to eq(1)
        expect(res.first.scheme_id).to eq('smithy.api#noAuth')
      end
    end
  end
end
