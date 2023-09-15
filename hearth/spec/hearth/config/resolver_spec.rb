# frozen_string_literal: true

module Hearth
  module Config
    describe Resolver do
      subject { Resolver }

      let(:config_class) do
        Struct.new(
          :option1,
          :option2,
          keyword_init: true
        )
      end

      it 'cannot be initialized' do
        expect { subject.new }.to raise_error(NoMethodError)
      end

      describe '.resolve' do
        let(:config) { config_class.new }

        it 'creates the config with provided options' do
          defaults = { option1: ['should not be used'] }
          options = { option1: 'test1', option2: 'test2' }
          subject.resolve(config, options, defaults)
          expect(config.option1).to eq('test1')
          expect(config.option2).to eq('test2')
        end

        it 'resolves defaults with static values' do
          options = { option1: 'test1' }
          defaults = { option2: [nil, 'default2'] }
          subject.resolve(config, options, defaults)
          expect(config.option1).to eq('test1')
          expect(config.option2).to eq('default2')
        end

        it 'resolves default values using the callable interface' do
          ENV['TEST'] = 'default2'
          defaults = {
            option1: [proc { |_cfg| 'default1' }],
            option2: [EnvProvider.new('TEST')]
          }
          subject.resolve(config, {}, defaults)
          expect(config.option1).to eq('default1')
          expect(config.option2).to eq('default2')
          ENV.clear
        end

        it 'resolves default values dependent on other config' do
          defaults = {
            option1: [
              proc { |cfg| 'default1' if cfg[:option2] == 'default2' },
              'should not be reached'
            ],
            option2: ['default2']
          }
          subject.resolve(config, {}, defaults)
          expect(config.option1).to eq('default1')
          expect(config.option2).to eq('default2')
        end
      end
    end
  end
end
