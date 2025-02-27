# frozen_string_literal: true

describe 'Client: Stub Responses' do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_context context, 'Shapes'

      subject { Shapes::Client.new(endpoint: 'https://example.com', stub_responses: true, protocol: Smithy::Client::Protocols::RPCv2.new) }

      let(:now) { Time.now }
      let(:default_stub_data) do
        {
          big_decimal: 0.0,
          big_integer: 0,
          blob: a_kind_of(StringIO),
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
          structure: { member: 'string' },
          timestamp: now,
          union: { string: 'string' }
        }
      end

      before { allow(Time).to receive(:now).and_return(now) }

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
        it 'returns the correct type' do
          subject.stub_responses(:operation)
          output = subject.operation
          expect(output.data).to be_a(Shapes::Types::OperationInputOutput)
        end

        it 'can set stubbed data' do
          data = { string: 'new string' }
          subject.stub_responses(:operation, data)
          output = subject.operation
          expect(output.data.string).to eq('new string')
        end

        it 'does not set defaults when stubbed data is provided' do
          data = { string: 'new string' }
          subject.stub_responses(:operation, data)
          output = subject.operation
          expect(output.data).not_to include(default_stub_data.except(:string))
        end
      end
    end
  end
end
