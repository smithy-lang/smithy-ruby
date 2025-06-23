# frozen_string_literal: true

require_relative '../spec_helper'

require 'tempfile'

module Smithy
  module Client
    describe Request do
      let(:handlers) { HandlerList.new }
      let(:context) { HandlerContext.new }

      subject { Request.new(handlers: handlers, context: context) }

      it 'is a HandlerBuilder' do
        expect(subject).to be_kind_of(HandlerBuilder)
      end

      describe '#initialize' do
        it 'defaults handlers to an empty HandlerList' do
          expect(Request.new.handlers).to be_kind_of(HandlerList)
        end

        it 'defaults context to a new HandlerContext' do
          expect(Request.new.context).to be_kind_of(HandlerContext)
        end
      end

      describe '#handlers' do
        it 'returns the handler list' do
          expect(subject.handlers).to be(handlers)
        end
      end

      describe '#context' do
        it 'returns the context' do
          expect(subject.context).to be(context)
        end
      end

      describe '#send_request' do
        it 'constructs a stack from the handler list' do
          expect(handlers).to receive(:to_stack).and_return(->(context) {})
          subject.send_request
        end

        it 'returns the response from the handler stack #call method' do
          response = double('response')
          allow(handlers).to receive(:to_stack).and_return(->(_) { response })
          expect(subject.send_request).to be(response)
        end

        it 'passes the handler context to the handler stack' do
          passed = nil
          allow(handlers).to receive(:to_stack)
            .and_return(->(context) { passed = context })
          subject.send_request
          expect(passed).to be(context)
        end

        it 'can set a response target with the target option' do
          target = double('target')
          expect(context).to receive(:[]=).with(:response_target, target)
          subject.send_request(target: target)
        end

        it 'can set a response target with a block' do
          target = proc {}
          expect(context).to receive(:[]=).with(:response_target, target)
          subject.send_request(&target)
        end
      end
    end
  end
end
