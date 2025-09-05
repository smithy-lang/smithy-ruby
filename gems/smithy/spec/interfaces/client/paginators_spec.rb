# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Paginators' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      context 'service has the paginated trait' do
        include_context context, 'PaginatedService', fixture: 'paginated_trait/inheritance'

        it 'operation inherits from the service trait' do
          paginator = PaginatedService::Paginators::InheritedTraitOperation.new
          type = PaginatedService::Types::InheritedTraitOperationOutput.new(output_token: 'outputToken')
          expect(paginator.next_tokens(type)).to eq({ input_token: 'outputToken' })
          expect(paginator.prev_tokens({ input_token: 'outputToken', output_token: 'ignored' }))
            .to eq({ input_token: 'outputToken' })
          expect { paginator.items(type) }.to raise_error(NotImplementedError)
        end

        it 'merges service and operation traits' do
          paginator = PaginatedService::Paginators::MergedTraitOperation.new
          type = PaginatedService::Types::MergedTraitOperationOutput.new(input_token: 'inputToken', items: ['item1'])
          expect(paginator.next_tokens(type)).to eq({ output_token: 'inputToken' })
          expect(paginator.prev_tokens({ output_token: 'inputToken', input_token: 'ignored' }))
            .to eq({ output_token: 'inputToken' })
          expect(paginator.items(type)).to eq(type.items)
        end
      end

      context 'service does not have the paginated trait' do
        include_context context, 'PaginatedService', fixture: 'paginated_trait/operation-only'

        it 'generates paginators only for paginated operations' do
          expect(PaginatedService::Paginators.constants).to eq([:PaginatedOperation])
          expect(PaginatedService::Paginators.constants).not_to include(:UnpaginatedOperation)
        end
      end
    end
  end
end
