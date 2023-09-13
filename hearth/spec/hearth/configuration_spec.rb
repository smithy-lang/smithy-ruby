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

        def self.defaults
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
    end

    describe '#validate!' do
      it 'raises on invalid types' do
        config = config_class.new(simple_option: 1)
        expect do
          config.validate!
        end.to raise_error(
          ArgumentError,
          'Expected config[:simple_option] to be in [String], got Integer.'
        )
      end
    end
  end
end
