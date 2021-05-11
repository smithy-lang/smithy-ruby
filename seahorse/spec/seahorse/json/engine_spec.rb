# frozen_string_literal: true

require 'seahorse/json/engine'
require 'tempfile'

module Seahorse
  module JSON

    describe Engine do

      # describe '.load' do
      #   it 'uses an engine to load the JSON' do
      #     json = { foo: 'bar' }.to_json
      #     expect(Seahorse::JSON.singleton_class::ENGINE)
      #       .to receive(:load).with(json)
      #     subject.load(json)
      #   end
      # end
      #
      # describe '.load_file' do
      #   it 'uses an engine to load the JSON from a file' do
      #     file = Tempfile.new('engines')
      #     json = { foo: 'bar' }.to_json
      #     file.write(json)
      #     file.rewind
      #     expect(Seahorse::JSON.singleton_class::ENGINE)
      #       .to receive(:load).with(json)
      #     subject.load_file(file)
      #     file.close
      #     file.unlink
      #   end
      # end
      #
      # describe '.dump' do
      #   it 'uses an engine to dump the values to JSON' do
      #     hash = { foo: 'bar' }
      #     expect(Seahorse::JSON.singleton_class::ENGINE)
      #       .to receive(:dump).with(hash)
      #     subject.dump(hash)
      #   end
      # end

    end

  end
end
