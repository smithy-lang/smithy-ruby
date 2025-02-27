# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Pre Process' do
  before(:all) do
    Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#Weather'
      end

      def pre_process(model)
        model['shapes']['smithy.ruby.tests#Weld'] = { 'type' => 'structure', 'members' => {} }
        model['shapes']['smithy.ruby.tests#GetForecastOutput']['members']['chanceOfWelds'] =
          { 'target' => 'smithy.ruby.tests#Weld' }
      end
    end
  end

  ['generated client gem',
   'generated schema gem',
   'generated client from source code',
   'generated schema from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      it 'can pre process the model' do
        weld = Weather::Types::Weld.new
        expect(weld).to be_a(Struct)
        expect(weld.members).to be_empty
        get_forecast_output = Weather::Types::GetForecastOutput.new
        expect(get_forecast_output.members).to include(:chance_of_welds)
      end
    end
  end
end
