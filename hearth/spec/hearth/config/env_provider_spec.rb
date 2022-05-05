# frozen_string_literal: true

module Hearth
  module Config
    describe EnvProvider do
      let(:env_key) { 'TEST' }
      subject { EnvProvider.new(env_key, type: type) }

      let(:resolver) { double('resolver') }

      after { ENV.clear }

      context 'type should be a float' do
        let(:type) { 'Float' }

        it 'parses the value' do
          ENV[env_key] = '1.0'
          expect(subject.call(resolver)).to eq(1.0)
        end

        it 'raises on unexpected values' do
          ENV[env_key] = 'not 1.0'
          expect { subject.call(resolver) }.to raise_error(ArgumentError)
        end
      end

      context 'type should be a integer' do
        let(:type) { 'Integer' }

        it 'parses the value' do
          ENV[env_key] = '1'
          expect(subject.call(resolver)).to eq(1)
        end

        it 'raises on unexpected values' do
          ENV[env_key] = 'not 1'
          expect { subject.call(resolver) }.to raise_error(ArgumentError)
        end
      end

      context 'type should be a boolean' do
        let(:type) { 'Boolean' }

        it 'parses the true value' do
          ENV[env_key] = 'true'
          expect(subject.call(resolver)).to eq(true)
        end

        it 'parses the false value' do
          ENV[env_key] = 'false'
          expect(subject.call(resolver)).to eq(false)
        end

        it 'raises on unexpected values' do
          ENV[env_key] = 'not true or false'
          expect { subject.call(resolver) }.to raise_error(ArgumentError)
        end
      end

      context 'type is something else' do
        let(:type) { 'String' }

        it 'uses the value' do
          ENV[env_key] = 'standard'
          expect(subject.call(resolver)).to eq('standard')
        end
      end
    end
  end
end
