# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe Response do
      it 'is a Delegator' do
        expect(subject).to be_kind_of(Delegator)
      end

      it 'delegates to an error with the getter' do
        error = StandardError.new
        subject.error = error
        expect(subject.__getobj__).to be(error)
      end

      it 'delegates to the data with the getter' do
        data = double('data')
        subject.data = data
        expect(subject.__getobj__).to be(data)
      end

      it 'prefers the error over the data' do
        error = StandardError.new
        data = double('data')
        subject.error = error
        subject.data = data
        expect(subject.__getobj__).to be(error)
      end

      it 'sets the delegated error with a setter' do
        error = StandardError.new
        subject.__setobj__(error)
        expect(subject.error).to be(error)
      end

      it 'sets the error with a setter only if the object is a StandardError' do
        error = double('error')
        subject.__setobj__(error)
        expect(subject.error).to be(nil)
      end

      it 'sets the delegated data with a setter' do
        data = double('data')
        subject.__setobj__(data)
        expect(subject.data).to be(data)
      end

      describe '#initialize' do
        it 'defaults the context to a new HandlerContext' do
          expect(Response.new.context).to be_kind_of(HandlerContext)
        end
      end

      describe '#context' do
        it 'returns the context' do
          context = HandlerContext.new
          response = Response.new(context: context)
          expect(response.context).to be(context)
        end
      end

      describe '#data' do
        it 'returns the data' do
          data = double('data')
          subject.data = data
          expect(subject.data).to be(data)
        end
      end

      describe '#error' do
        it 'returns the error' do
          error = StandardError.new
          subject.error = error
          expect(subject.error).to be(error)
        end

        it 'sets error using the http response listener' do
          http_response = Http::Response.new
          response = Response.new(context: HandlerContext.new(http_response: http_response))
          error = StandardError.new
          http_response.signal_error(error)
          expect(response.error).to be(error)
        end
      end

      describe '#on_done' do
        it 'returns and yields self when done' do
          http_response = Http::Response.new
          response = Response.new(context: HandlerContext.new(http_response: http_response))
          yielded = false

          resp = response.on_done(200..299) do |r|
            expect(r).to be(response)
            yielded = true
          end
          http_response.signal_done(status_code: 200, headers: {}, body: '')

          expect(resp).to be(response)
          expect(yielded).to be(true)
        end
      end
    end
  end
end
