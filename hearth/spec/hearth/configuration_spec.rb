# frozen_string_literal: true

module Hearth
  describe Configuration do
    let(:config_class) do
      Struct.new(
        :option,
        :complex_option,
        keyword_init: true
      ) do
        include Hearth::Configuration

        private

        def validate!
          Hearth::Validator.validate_types!(
            option, String, context: 'options[:option]'
          )
        end

        def self.defaults
          @defaults ||= {}
        end
      end
    end

    describe '#initialize' do
      it 'uses the config resolver and validates the config object' do
        options = { option: 'test' }
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(an_instance_of(config_class), options, config_class.defaults)
        expect_any_instance_of(config_class).to receive(:validate!)
          .and_call_original

        config_class.new(**options)
      end

      it 'resolves correctly when not passed any options' do
        expect(Hearth::Config::Resolver).to receive(:resolve)
          .with(an_instance_of(config_class), {}, config_class.defaults)
        expect_any_instance_of(config_class).to receive(:validate!)
          .and_call_original

        config_class.new
      end
    end

    describe '#dup' do
      let(:complex_option) { double }
      let(:orig) { config_class.new(complex_option: complex_option) }

      it 'deep copies' do
        expect(complex_option).to receive(:dup)
        orig.dup
      end
    end
  end
end
