# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Schema: Types', rbs_test: true do
  ['generated schema gem', 'generated schema from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated schema gem'

    context context do
      include_examples 'types module', context
      if context == 'generated schema gem' && !ENV['SMITHY_RUBY_RBS_TEST']
        include_examples 'types module documentation', context
      end
    end
  end
end
