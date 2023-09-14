# frozen_string_literal: true

module Hearth
  describe Configuration do
    let(:config_class) do
      Struct.new(:simple_option, keyword_init: true) do
        include Hearth::Configuration

        def validate!
          Hearth::Validator.validate_types!(
            simple_option, String, context: 'config[:simple_option]'
          )
        end

        private

        def defaults
          { simple_option: ['default'] }
        end
      end
    end

    describe '#initialize' do
      it 'uses the config resolver' do
        options = { simple_option: 'test' }
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(
            an_instance_of(config_class),
            options,
            { simple_option: ['default'] }
          ).and_call_original

        config = config_class.new(**options)
        expect(config.simple_option).to eq('test')
      end

      it 'resolves correctly when not passed any options' do
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(
            an_instance_of(config_class),
            {},
            { simple_option: ['default'] }
          ).and_call_original

        config = config_class.new
        expect(config.simple_option).to eq('default')
      end

      it 'raises on unknown options' do
        expect do
          config_class.new(unknown_option: 'test')
        end.to raise_error(ArgumentError, /unknown_option/)
      end
    end

    describe '#merge' do
      it 'merges the configuration' do
        config = config_class.new(simple_option: 'test')
        merged = config.merge(config_class.new(simple_option: 'test2'))
        expect(merged.simple_option).to eq('test2')
      end
    end
  end
end
