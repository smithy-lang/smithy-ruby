# frozen_string_literal: true

module Smithy
  module Client
    describe Handler do
      let(:context) { double('RequestContext') }
      let(:response) { double('Response') }
      let(:handler) { double('Handler', call: response) }

      subject { Handler.new(handler) }

      describe '#handler' do
        it 'returns the handler' do
          expect(subject.handler).to be(handler)
        end
      end

      describe '#call' do
        it 'calls the handler' do
          expect(handler).to receive(:call).with(context)
          subject.call(context)
        end

        it 'returns the response' do
          expect(subject.call(context)).to be(response)
        end
      end

      describe '#inspect' do
        it 'uses the class name for named handlers' do
          handler = Handler.new
          expect(handler.inspect).to eql '#<Smithy::Client::Handler @handler=nil>'
        end

        it 'overrides class name for anonymous handler' do
          handler = Class.new(Handler).new
          expect(handler.inspect).to eql '#<UnknownHandler @handler=nil>'
        end
      end
    end
  end
end
