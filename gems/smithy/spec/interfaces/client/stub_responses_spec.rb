# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Stub Responses' do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_context context, 'Shapes'

      subject { Shapes::Client.new(stub_responses: true) }

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
          structure: { member: 'string' },
          timestamp: now,
          union: { string: 'string' }
        }
      end

      before do
        Shapes::Client.add_plugin(Smithy::Client::Plugins::RPCv2CBOR)
        allow(Time).to receive(:now).and_return(now)
        allow(Time).to receive(:at).and_return(now)
      end

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

        it 'can stub default data' do
          subject.stub_responses(:operation)
          output = subject.operation
          expect(output.data.to_h).to include(default_stub_data)
          expect(output.data.timestamp).to eq(now)
        end

        it 'validates stubs at request time' do
          data = { not_a_member: 'foo' }
          subject.stub_responses(:operation, data)
          expect { subject.operation }
            .to raise_error(ArgumentError, /unexpected value at params\[:not_a_member\]/)
        end

        it 'can stub procs' do
          subject.stub_responses(:operation, ->(ctx) { { string: ctx.params[:string] } })
          output = subject.operation(string: 'new string')
          expect(output.data.string).to eq('new string')
        end

        it 'can stub nested procs' do
          proc = ->(ctx2) { { string: ctx2.params[:string] } }
          subject.stub_responses(:operation, ->(_ctx1) { proc })
          output = subject.operation(string: 'new string')
          expect(output.data.string).to eq('new string')
        end

        it 'can stub exceptions' do
          error = StandardError.new('error')
          subject.stub_responses(:operation, error)
          expect { subject.operation }.to raise_error(error)
        end

        it 'can stub errors as a class' do
          subject.stub_responses(:operation, Timeout::Error)
          expect { subject.operation }.to raise_error(Timeout::Error)
        end

        it 'can stub modeled errors as strings' do
          subject.stub_responses(:operation, 'Error')
          expect { subject.operation }.to raise_error(Shapes::Errors::Error, 'stubbed-error-message')
        end

        it 'can stub http hashes' do
          headers = { 'header' => 'value' }
          body = Smithy::CBOR.encode({ 'string' => 'value' })
          subject.stub_responses(:operation, { status_code: 200, headers: headers, body: body })
          output = subject.operation
          expect(output.context.response.status_code).to eq(200)
          expect(output.context.response.headers.to_h).to eq(headers)
          expect(output.context.response.body.string).to eq(body.force_encoding('UTF-8'))
        end

        it 'can stub data' do
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

        it 'can stub multiple responses' do
          subject.stub_responses(:operation, { string: 'value-1' }, { string: 'value-2' })
          expect(subject.operation.string).to eq('value-1')
          expect(subject.operation.string).to eq('value-2')
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
