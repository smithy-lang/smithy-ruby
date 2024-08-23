# frozen_string_literal: false

module Hearth
  describe Response do
    describe '#initialize' do
      it 'sets empty defaults' do
        response = Response.new
        expect(response.body).to be_a(StringIO)
      end
    end

    describe '#replace' do
      it 'replaces the response' do
        response = Response.new(body: StringIO.new('foo'))
        other = Response.new(body: StringIO.new('bar'))
        response.replace(other)
        expect(response.body.read).to eq('bar')
      end
    end

    describe '#reset' do
      it 'resets the body' do
        response = Response.new
        response.body.write('foo')
        response.reset
        expect(response.body.size).to eq(0)
      end

      it 'body can be written to again' do
        response = Response.new
        response.body.write('foo')
        response.reset
        response.body.write('bar')
        response.body.rewind
        expect(response.body.read).to eq('bar')
      end

      it 'does not truncate or rewind IO' do
        read, write = IO.pipe
        write.write('foo')
        response = Response.new(body: read)
        response.reset
        write.close
        expect(read.read).to eq('foo')
        read.close
      end
    end

    describe '#span_attributes' do
      it 'returns empty hash' do
        response = Response.new
        expect(response.span_attributes).to be_empty
      end
    end
  end
end
