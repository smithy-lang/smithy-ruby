# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Client' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      subject { Weather::Client.new(stub_responses: true) }

      it 'loads default plugins' do
        expect(Weather::Client.plugins).to include(*Smithy::Welds::Plugins.new(@plan).add_plugins.keys)
      end

      it 'responds to each operation name' do
        subject.operation_names.each do |operation_name|
          expect(subject).to respond_to(operation_name)
        end
      end

      it 'builds and sends a request when it receives a request method' do
        input = subject.send(:build_input, :get_city, { id: '1' })
        expect(subject).to receive(:build_input).with(:get_city, { city_id: '1' }).and_return(input)
        expect(input).to receive(:send_request)
        subject.get_city(city_id: '1')
      end

      # it 'passes block arguments to the request method' do
      #   input = subject.send(:build_input, :get_city, { id: '1' })
      #   expect(subject).to receive(:build_input).with(:get_city, { city_id: '1' }).and_return(input)
      #   allow(input).to receive(:send_request)
      #     .and_yield('chunk1')
      #     .and_yield('chunk2')
      #     .and_yield('chunk3')
      #   chunks = []
      #   subject.get_city(city_id: '1') do |chunk|
      #     chunks << chunk
      #   end
      #   expect(chunks).to eq(%w[chunk1 chunk2 chunk3])
      # end

      it 'can call operations' do
        subject.get_city(city_id: '1')
      end
    end
  end
end
