# frozen_string_literal: true

module Hearth
  class TestConfiguration
    MEMBERS = %i[
      simple_option
      complex_option
    ].freeze

    include Hearth::Configuration

    attr_accessor(*MEMBERS)

    def validate!
      Hearth::Validator.validate_types!(
        simple_option, String,
        context: 'config[:simple_option]'
      )
      Hearth::Validator.validate_types!(
        complex_option, Object,
        context: 'config[:complex_option]'
      )
    end

    private

    def _defaults
      {
        simple_option: ['default'],
        complex_option: [Object.new]
      }.freeze
    end
  end

  describe Configuration do
    describe '#initialize' do
      it 'uses the config resolver' do
        options = { simple_option: 'test' }
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(
            an_instance_of(TestConfiguration),
            options,
            {
              simple_option: ['default'],
              complex_option: [an_instance_of(Object)]
            }
          ).and_call_original

        config = TestConfiguration.new(**options)
        expect(config.simple_option).to eq('test')
      end

      it 'resolves correctly when not passed any options' do
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(
            an_instance_of(TestConfiguration),
            {},
            {
              simple_option: ['default'],
              complex_option: [an_instance_of(Object)]
            }
          ).and_call_original

        config = TestConfiguration.new
        expect(config.simple_option).to eq('default')
      end

      it 'raises on unknown options' do
        expect do
          TestConfiguration.new(unknown_option: 'test')
        end.to raise_error(ArgumentError, /config\[:unknown_option\]/)
      end
    end

    describe '#to_h' do
      it 'returns the configuration as a hash' do
        object = Object.new
        config = TestConfiguration.new(
          simple_option: 'test',
          complex_option: object
        )
        expect(config.to_h).to eq(simple_option: 'test', complex_option: object)
      end
    end

    describe '#merge' do
      it 'merges the configuration' do
        config = TestConfiguration.new(simple_option: 'test')
        merged = config.merge(TestConfiguration.new(simple_option: 'test2'))
        expect(merged.simple_option).to eq('test2')
      end
    end
  end
end
