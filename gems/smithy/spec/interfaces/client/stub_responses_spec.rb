# frozen_string_literal: true

require 'bigdecimal'

require_relative '../../spec_helper'

describe 'Client: Stub Responses' do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_context context, 'Shapes'

      let(:now) { Time.now }
      let(:default_stub_data) do
        {
          blob: String.new('blob'),
          boolean: false,
          string: 'string',
          byte: 0,
          short: 0,
          integer: 0,
          long: 0,
          float: 0.0,
          double: 0.0,
          big_integer: 0,
          big_decimal: BigDecimal(0),
          timestamp: now,
          enum: 'enum',
          int_enum: 0,
          list: [],
          map: {},
          structure: { member: 'member' },
          union: { string: 'string' }
        }
      end

      before(:all) do
        # The Shapes test fixture model has no smithy.protocols#rpcv2Cbor trait,
        # so the Protocols weld never populates the protocol registry. Without
        # this, the Protocol plugin resolves to NoOpProtocol, whose stub_data /
        # stub_error are no-ops - the stub assertions below would get empty data
        # and fail. Fake the registry so stubbing runs through real CBOR. (The
        # Protocol plugin itself is a default plugin now, so it does not need to
        # be added manually.)
        Shapes::Client.define_singleton_method(:protocols) do
          { rpc_v2_cbor: Smithy::Client::RpcV2Cbor }
        end
      end

      before do
        allow(Time).to receive(:now).and_return(now)
        allow(Time).to receive(:at).and_return(now)
      end

      subject { Shapes::Client.new(stub_responses: true, endpoint: 'https://example.com') }

      describe '#stub_data' do
        it 'returns the correct type' do
          stub = subject.stub_data(:operation)
          expect(stub).to be_a(Shapes::Types::OperationOutput)
        end

        it 'can return default stubbed data' do
          stub = subject.stub_data(:operation)
          expect(stub.to_h).to eq(default_stub_data)
        end

        it 'can set stubbed data mixed with defaults' do
          data = default_stub_data.merge(string: 'new string')
          stub = subject.stub_data(:operation, { string: 'new string' })
          expect(stub.to_h).to eq(data)
        end
      end

      describe '#stub_responses' do
        it 'registers the stub' do
          subject.stub_responses(:operation, { string: 'value' })
          expect(subject.config.stubs[:operation].size).to eq(1)
        end

        it 'can register multiple responses' do
          subject.stub_responses(:operation, { string: 'value-1' }, { string: 'value-2' })
          expect(subject.config.stubs[:operation].size).to eq(2)
        end

        it 'resets stubs if applied again to the same operation' do
          subject.stub_responses(:operation, { string: 'value-1' }, { string: 'value-2' })
          expect(subject.config.stubs[:operation].size).to eq(2)
          subject.stub_responses(:operation, { string: 'value' })
          expect(subject.config.stubs[:operation].size).to eq(1)
        end

        it 'does not mix stub data with defaults' do
          data = { string: 'new string' }
          subject.stub_responses(:operation, data)
          stub = subject.operation
          expect(stub.to_h).to eq(data)
        end
      end

      context '#api_requests' do
        it 'returns an array of requests' do
          subject.stub_responses(:operation)
          output1 = subject.operation
          output2 = subject.operation
          requests = subject.config.api_requests
          expect(requests.size).to eq(2)
          expect(requests.first).to be(output1.context)
          expect(requests.last).to be(output2.context)
        end
      end
    end
  end
end
