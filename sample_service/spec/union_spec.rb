# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  describe Types::EventStream do
    let(:message) { 'message' }
    let(:structured_event) { Types::StructuredEvent.new(message: message) }

    describe Types::EventStream::Start do
      let(:event) { Types::EventStream::Start.new(structured_event) }

      describe '#to_h' do
        it 'adds the member name' do
          expect(event.to_h).to eq({start: {message: message}})
        end
      end
    end

    describe Types::EventStream::Log do
      let(:event) { Types::EventStream::Log.new(message) }

      describe '#to_h' do
        it 'adds the member name and adds the string member to the hash' do
          expect(event.to_h).to eq({log: message})
        end
      end
    end

    describe Types::EventStream::SimpleList do
      let(:simple_list) { ['item1', 'item2'] }
      let(:event) { Types::EventStream::SimpleList.new(simple_list) }

      describe '#to_h' do
        it 'adds the member name and adds the list' do
          expect(event.to_h).to eq({simple_list: simple_list})
        end
      end
    end

    describe Types::EventStream::ComplexList do
      let(:high_score) { Types::HighScoreAttributes.new(id: 'id') }
      let(:complex_list) { [high_score] }
      let(:event) { Types::EventStream::ComplexList.new(complex_list) }

      describe '#to_h' do
        it 'adds the member name and adds the list' do
          expect(event.to_h).to eq({complex_list: [{id: 'id'}]})
        end
      end
    end

    describe Parsers::EventStream do
      context 'start event' do
        let(:json) { {'start' => {'message' => message} } }
        it 'parses a Types::EventStream::Start with the StructuredEvent' do
          out = Parsers::EventStream.parse(json)
          expect(out).to be_a(Types::EventStream::Start)
          expect(out.message).to eq message
        end
      end

      context 'simple list event' do
        let(:simple_list) { ['item1', 'item2'] }
        let(:json) { {'simple_list' => simple_list } }
        it 'parses a Types::EventStream::SimpleList' do
          out = Parsers::EventStream.parse(json)
          expect(out).to be_a(Types::EventStream::SimpleList)
          expect(out).to eq simple_list
        end
      end

      context 'complex list event' do
        let(:high_score) { {'id' => 'id'} }
        let(:json) { {'complex_list' => [high_score] } }
        it 'parses a Types::EventStream::ComplexList' do
          out = Parsers::EventStream.parse(json)
          expect(out).to be_a(Types::EventStream::ComplexList)
          expect(out.first).to be_a(Types::HighScoreAttributes)
          expect(out.first.id).to eq('id')
        end
      end
    end
  end
end
