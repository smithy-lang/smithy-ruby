# frozen_string_literal: true

require_relative '../spec_helper'

require 'tempfile'

module Smithy
  module Client
    describe LogParamFormatter do
      let(:client) { ClientHelper.sample_client.const_get(:Client).new }
      let(:input) { client.config.service.operation(:operation).input }

      describe '#summarize' do
        it 'summarizes strings' do
          expect(subject.summarize('short string')).to eq('"short string"')
        end

        it 'truncates long strings' do
          expect(subject.summarize('a' * 1001)).to eq("#<String \"#{'a' * 1000}\" ... (1001 bytes)>")
        end

        it 'can configure max string size' do
          formatter = LogParamFormatter.new(max_string_size: 10)
          expect(formatter.summarize('a' * 15)).to eq("#<String \"#{'a' * 10}\" ... (15 bytes)>")
        end

        it 'summarizes structure hashes with symbol keys' do
          hash = { key1: 'value1', key2: 'value2' }
          expect(subject.summarize(hash)).to eq('{key1:"value1",key2:"value2"}')
        end

        it 'summarizes maps with string keys' do
          hash = { 'key1' => 'value1', 'key2' => 'value2' }
          expect(subject.summarize(hash)).to eq('{"key1"=>"value1","key2"=>"value2"}')
        end

        it 'summarizes arrays' do
          array = %w[value1 value2 value3]
          expect(subject.summarize(array)).to eq('["value1","value2","value3"]')
        end

        it 'handles nested arrays and hashes' do
          nested = {
            string: 'value',
            array: [
              { key: 'value' }
            ],
            hash: {
              key: ['value']
            }
          }
          expected = '{string:"value",array:[{key:"value"}],hash:{key:["value"]}}'
          expect(subject.summarize(nested)).to eq(expected)
        end

        it 'summarizes files' do
          file = File.new('log-param-formatter', 'w')
          file.write('This has 17 bytes')
          file.rewind
          expect(subject.summarize(file)).to eq("#<File:#{file.path} (#{file.size} bytes)>")
        ensure
          file.close
          File.delete(file)
        end

        it 'summarizes tempfiles' do
          tempfile = Tempfile.new('log-param-formatter')
          tempfile.write('This has 17 bytes')
          tempfile.rewind
          expect(subject.summarize(tempfile)).to eq("#<Tempfile:#{tempfile.path} (17 bytes)>")
        ensure
          tempfile.close
          tempfile.unlink
        end

        it 'summarizes file paths' do
          tempfile = Tempfile.new('log-param-formatter')
          tempfile.write('This has 17 bytes')
          tempfile.rewind
          path = Pathname.new(tempfile.path)
          expect(subject.summarize(path)).to eq("#<Pathname:#{path} (17 bytes)>")
        ensure
          tempfile.close
          tempfile.unlink
        end

        it 'inspects other types' do
          expect(subject.summarize(nil)).to eq('nil')
          expect(subject.summarize(false)).to eq('false')
          expect(subject.summarize(3.14)).to eq('3.14')
        end
      end
    end
  end
end
