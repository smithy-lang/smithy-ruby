# frozen_string_literal: true

require 'seahorse/json/engines'
require 'tempfile'

module Seahorse
  module JSON
    describe ParseError do
      let(:original_message) { 'ORIG-MESSAGE' }
      let(:original_error) { StandardError.new(original_message) }

      subject { ParseError.new(original_error) }

      it 'subclasses StandardError' do
        expect(subject).to be_a StandardError
      end

      it 'adds to the original errors message' do
        expect(subject.message).to include(original_message)
      end

      describe '#original_error' do
        it 'gets the original_error field' do
          expect(subject.original_error).to be original_error
        end
      end
    end
  end

  describe JSON do
    it 'has engines' do
      expect(Seahorse::JSON::ENGINES)
        .to eq [JSON::Engines::Oj, JSON::Engines::JSON]
    end

    describe '.load' do
      it 'uses an engine to load the JSON' do
        json = { foo: 'bar' }.to_json
        expect(Seahorse::JSON.singleton_class::ENGINE)
          .to receive(:load).with(json)
        subject.load(json)
      end
    end

    describe '.load_file' do
      it 'uses an engine to load the JSON from a file' do
        file = Tempfile.new('engines')
        json = { foo: 'bar' }.to_json
        file.write(json)
        file.rewind
        expect(Seahorse::JSON.singleton_class::ENGINE)
          .to receive(:load).with(json)
        subject.load_file(file)
        file.close
        file.unlink
      end
    end

    describe '.dump' do
      it 'uses an engine to dump the values to JSON' do
        hash = { foo: 'bar' }
        expect(Seahorse::JSON.singleton_class::ENGINE)
          .to receive(:dump).with(hash)
        subject.dump(hash)
      end
    end
  end
end
