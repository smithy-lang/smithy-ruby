# frozen_string_literal: true

require 'stringio'

module Smithy
  module Client
    describe Response do
      let(:body) { 'body' }

      subject { Response.new(body: body) }

      describe '#initialize' do
        it 'sets the body as a StringIO' do
          expect(subject.body).to be_a(StringIO)
        end
      end

      describe '#body=' do
        it 'sets a string body as a StringIO' do
          subject.body = 'string'
          expect(subject.body.string).to eq('string')
        end

        it 'sets a nil body as a StringIO' do
          subject.body = nil
          expect(subject.body.string).to eq('')
        end

        it 'sets anything else to the body' do
          io = StringIO.new('body')
          subject.body = io
          expect(subject.body.string).to eq('body')
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
    end
  end
end
