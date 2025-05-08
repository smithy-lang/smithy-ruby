# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    module Document
      describe Data do
        subject { Data.new({ 'foo' => 'bar' }) }

        describe '#initialize' do
          it 'sets data' do
            expect(subject.data).to eq('foo' => 'bar')
          end

          it 'defaults discriminator to nil' do
            expect(subject.discriminator).to be_nil
          end
        end

        describe '#[]' do
          it 'returns member value' do
            expect(subject['foo']).to eq('bar')
          end

          it 'returns nil when member is not applicable' do
            expect(subject['bar']).to be_nil
          end
        end

        describe '#discriminator' do
          it 'is not set' do
            expect(subject.discriminator).to be_nil
          end
        end
      end
    end
  end
end
