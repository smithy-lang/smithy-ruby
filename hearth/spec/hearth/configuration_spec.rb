# frozen_string_literal: true

module Hearth
  describe Configuration do
    let(:config_class) do
      Struct.new(
        :simple_option,
        :complex_option,
        keyword_init: true
      ) do
        include Hearth::Configuration

        private

        def validate!
          Hearth::Validator.validate_types!(
            simple_option, String, context: 'config[:simple_option]'
          )
          Hearth::Validator.validate_types!(
            complex_option, Hash, context: 'config[:complex_option]'
          )
        end

        def self.defaults
          @defaults ||= {}
        end
      end
    end

    describe '#initialize' do
      it 'uses the config resolver' do
        options = { simple_option: 'test' }
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(an_instance_of(config_class), options, config_class.defaults)

        config_class.new(**options)
      end

      it 'resolves correctly when not passed any options' do
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(an_instance_of(config_class), {}, config_class.defaults)

        config_class.new
      end

      it 'raises on invalid types' do
        expect do
          config_class.new(simple_option: 1)
        end.to raise_error(
          ArgumentError,
          'Expected config[:simple_option] to be in [String], got Integer.'
        )
      end

      it 'raises on unknown options' do
        expect do
          config_class.new(unknown_option: 'test')
        end.to raise_error(
          ArgumentError,
          'Unexpected members: [config[:unknown_option]]'
        )
      end
    end

    describe '#dup' do
      let(:simple_option) { String.new('test') }
      let(:complex_option) { {} }

      it 'deep copies' do
        config = config_class.new(
          simple_option: simple_option,
          complex_option: complex_option
        )
        expect(simple_option).to receive(:dup)
        expect(complex_option).to receive(:dup)
        config.dup
      end
    end
  end
end
