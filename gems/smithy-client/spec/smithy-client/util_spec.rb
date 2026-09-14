# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe Util do
      describe '.escape' do
        it 'uses RFC 3986 query escaping' do
          expect(described_class.escape('a value~')).to eq('a%20value~')
        end
      end

      describe '.str_to_bool' do
        it 'accepts values that stringify to a supported boolean' do
          expect(described_class.str_to_bool(true)).to be(true)
        end
      end
    end
  end
end
