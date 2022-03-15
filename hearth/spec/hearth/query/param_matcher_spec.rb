# frozen_string_literal: true

# not included in lib
require_relative '../../../lib/hearth/query/param_matcher'

module Hearth
  module Query
    describe :match_query_params do
      it 'is true when the node is self' do
        cgi = CGI.parse('Param=Value')
        expect(cgi).to match_query_params(cgi)
      end

      it 'is true for the same parsed params' do
        actual = CGI.parse('Param=Value')
        expected = CGI.parse('Param=Value')

        expect(actual).to match_query_params(expected)
      end

      it 'is false when number of keys differs' do
        actual = CGI.parse('Param=Value')
        expected = CGI.parse('Param=Value&Other=Value')

        expect(actual).not_to match_query_params(expected)
      end

      it 'is false when number of values differs' do
        actual = CGI.parse('Param=Value')
        expected = CGI.parse('Param=Value&Param=Other')

        expect(actual).not_to match_query_params(expected)
      end

      it 'is false when param names differs' do
        actual = CGI.parse('Param1=Value1&Other=Value2')
        expected = CGI.parse('Param1=Value1&Param2=Value2')

        expect(actual).not_to match_query_params(expected)
      end

      it 'compares floats with precision' do
        actual = CGI.parse('Param=Value&Time=123')
        expected = CGI.parse('Param=Value&Time=123.0')

        expect(actual).to match_query_params(expected)
      end
    end
  end
end
