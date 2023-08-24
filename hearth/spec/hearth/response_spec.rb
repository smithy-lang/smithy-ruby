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
        expect(response.body.string).to eq('')
      end

      it 'does not truncate IO' do
        read, write = IO.pipe
        write.write('foo')
        response = Response.new(body: read)
        response.reset
        write.close
        expect(read.read).to eq('foo')
        read.close
      end
    end
  end
end
