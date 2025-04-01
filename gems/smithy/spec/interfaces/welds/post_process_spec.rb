# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Post Process' do
  before(:all) do
    Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#Weather'
      end

      def post_process(artifacts)
        file = artifacts.find { |f| f.include?('/types.rb') }
        inject_into_module(file, 'Types') do
          "    OtherWeld = Struct.new(keyword_init: true)\n"
        end
      end
    end
  end

  ['generated client gem', 'generated schema gem'].each do |context|
    context context do
      include_context context, 'Weather'

      it 'can post process files' do
        other_weld = Weather::Types::OtherWeld.new
        expect(other_weld).to be_a(Struct)
      end
    end
  end
end
