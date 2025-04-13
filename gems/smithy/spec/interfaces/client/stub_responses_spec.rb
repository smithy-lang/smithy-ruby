# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: rpcv2Cbor Protocol; Stub Responses' do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_context context, 'Shapes'

      let(:now) { Time.now }
      let(:default_stub_data) do
        {
          big_decimal: 0.0,
          big_integer: 0,
          blob: String.new('blob'),
          boolean: false,
          byte: 0,
          double: 0.0,
          enum: 'enum',
          float: 0.0,
          int_enum: 0,
          integer: 0,
          list: [],
          long: 0,
          map: {},
          short: 0,
          string: 'string',
          timestamp: now,
          union: { string: 'string' }
        }
      end

      before do
        allow(Time).to receive(:now).and_return(now)
        allow(Time).to receive(:at).and_return(now)
      end

      subject { Shapes::Client.new(stub_responses: true) }

      describe '#stub_data' do
        it 'returns the correct type' do
          stub = subject.stub_data(:operation)
          expect(stub).to be_a(Shapes::Types::OperationInputOutput)
        end

        it 'can return default stubbed data' do
          stub = subject.stub_data(:operation)
          expect(stub.to_h).to include(default_stub_data)
        end

        it 'can set stubbed data mixed with defaults' do
          data = default_stub_data.merge(string: 'new string')
          stub = subject.stub_data(:operation, { string: 'new string' })
          expect(stub.to_h).to include(data)
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
