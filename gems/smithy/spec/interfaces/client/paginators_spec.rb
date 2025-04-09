# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Paginators' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      it 'generates paginators only for paginated operations' do
        expect(Weather::Paginators.constants).to eq([:ListCities])
      end

      it 'defines paginator methods' do
        paginator = Weather::Paginators::ListCities.new
        expect(paginator).to respond_to(:next_tokens)
        expect(paginator).to respond_to(:prev_tokens)
        expect(paginator).to respond_to(:items)
      end
    end
  end
end
