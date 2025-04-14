# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Auth Resolver', rbs_test: true do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_context context, 'NoAuthTrait', fixture: 'auth/no_auth_trait'

      subject { NoAuthTrait::AuthResolver.new }

      describe '#resolve' do
        it 'returns the auth options alphabetically by default' do
          params = NoAuthTrait::AuthParameters.new(operation_name: :operation_a)
          auth_options = subject.resolve(params)
          expected = %w[smithy.api#httpBasicAuth smithy.api#httpBearerAuth smithy.api#httpDigestAuth]
          expect(auth_options.map(&:scheme_id)).to eq(expected)
        end

        it 'returns the auth options for the operation with the auth trait' do
          params = NoAuthTrait::AuthParameters.new(operation_name: :operation_b)
          auth_options = subject.resolve(params)
          expect(auth_options.map(&:scheme_id)).to eq(['smithy.api#httpDigestAuth'])
        end
      end
    end

    context context do
      include_context context, 'AuthTrait', fixture: 'auth/auth_trait'

      subject { AuthTrait::AuthResolver.new }

      describe '#resolve' do
        it 'returns the auth options with the service auth trait' do
          params = AuthTrait::AuthParameters.new(operation_name: :operation_c)
          auth_options = subject.resolve(params)
          expected = %w[smithy.api#httpBasicAuth smithy.api#httpDigestAuth]
          expect(auth_options.map(&:scheme_id)).to eq(expected)
        end

        it 'returns the auth options for the operation overriding the service auth trait' do
          params = AuthTrait::AuthParameters.new(operation_name: :operation_d)
          auth_options = subject.resolve(params)
          expect(auth_options.map(&:scheme_id)).to eq(['smithy.api#httpBearerAuth'])
        end

        it 'returns a noAuth option when the auth trait is empty' do
          params = AuthTrait::AuthParameters.new(operation_name: :operation_e)
          auth_options = subject.resolve(params)
          expect(auth_options.map(&:scheme_id)).to eq(['smithy.api#noAuth'])
        end
      end
    end
  end
end
