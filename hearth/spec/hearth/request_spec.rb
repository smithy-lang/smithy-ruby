# frozen_string_literal: true

module Hearth
  describe Request do
    let(:uri) { URI('http://example.com') }
    let(:body) { 'body' }

    subject { Request.new(uri: uri, body: body) }

    describe '#initialize' do
      it 'sets empty defaults' do
        request = Request.new
        expect(request.body).to be_a(StringIO)
        expect(request.uri).to be_a(URI)
      end
    end

    describe '#dup' do
      it 'duplicates the request' do
        request = subject.dup
        expect(request.uri).to eq(uri)
        expect(request.uri).not_to equal(uri)
        # Body is not copied
        expect(request.body).to eq(body)
      end
    end
  end
end
