# frozen_string_literal: true

module Seahorse
  describe Context do
    let(:params) { { key: 'value' } }
    let(:logger) { Logger.new($stdout) }
    let(:metadata) { { foo: 'bar' } }

    subject { Context.new(metadata.merge({params: params, logger: logger})) }

    describe '#initialize' do
      it 'sets empty defaults' do
        context = Context.new
        expect(context.params).to be_nil
        expect(context.logger).to be_nil
      end
    end

    describe '#params' do
      it 'gets the params field' do
        expect(subject.params).to be params
      end
    end

    describe '#logger' do
      it 'gets the logger field' do
        expect(subject.logger).to be logger
      end
    end

    describe '#[]' do
      it 'delegates to metadata' do
        expect(subject[:foo]).to eq 'bar'
      end

    end

    describe '#[]=' do
      it 'delegates to metadata' do
        subject[:bar] = 'baz'
        expect(subject[:bar]).to eq 'baz'
      end
    end
  end
end
