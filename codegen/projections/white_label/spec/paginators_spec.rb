# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Paginators
    describe PaginatorsTest do
      let(:client) { double('Client') }
      let(:params) { { param: 'param' } }
      let(:options) { { stub_responses: true } }

      subject { PaginatorsTest.new(client, params, options) }
      let(:response1) do
        Types::PaginatorsTestOperationOutput.new(next_token: 'foo',
                                                 items: %w[
                                                   a b c
                                                 ])
      end
      let(:response2) do
        Types::PaginatorsTestOperationOutput.new(next_token: 'bar',
                                                 items: %w[
                                                   1 2 3
                                                 ])
      end
      let(:response3) do
        Types::PaginatorsTestOperationOutput.new(items: ['the end'])
      end

      describe '#pages' do
        it 'yields page responses' do
          expect(client).to receive(:paginators_test)
            .with({ param: 'param' }, options).and_return(response1)
          expect(client).to receive(:paginators_test)
            .with({ param: 'param',
                    next_token: 'foo' }, options).and_return(response2)
          expect(client).to receive(:paginators_test)
            .with({ param: 'param',
                    next_token: 'bar' }, options).and_return(response3)

          paginator = subject.pages
          expect(paginator).to be_a(Enumerator)
          page = paginator.next
          expect(page).to eq(response1)
          page = paginator.next
          expect(page).to eq(response2)
          page = paginator.next
          expect(page).to eq(response3)
          expect { paginator.next }.to raise_error(StopIteration)
        end

        it 'does not modify original params' do
          expect(client).to receive(:paginators_test)
            .with({ param: 'param' }, options).and_return(response1)

          original_params = params
          paginator = subject.pages
          paginator.next
          expect(original_params).to be params
        end
      end

      describe '#items' do
        it 'is not implemented' do
          expect { subject.items }.to raise_error(NoMethodError)
        end
      end
    end

    describe PaginatorsTestWithItems do
      let(:client) { double('Client') }
      let(:params) { { param: 'param' } }
      let(:options) { { stub_responses: true } }

      subject { PaginatorsTestWithItems.new(client, params, options) }
      let(:response1) do
        Types::PaginatorsTestOperationOutput.new(next_token: 'foo',
                                                 items: %w[
                                                   a b c
                                                 ])
      end
      let(:response2) do
        Types::PaginatorsTestOperationOutput.new(next_token: 'bar',
                                                 items: %w[
                                                   1 2 3
                                                 ])
      end
      let(:response3) do
        Types::PaginatorsTestOperationOutput.new(items: ['the end'])
      end

      describe '.pages' do
        # skip, already tested with PaginatorsTest.pages
      end

      describe '#items' do
        it 'yields items from paged response data' do
          expect(client).to receive(:paginators_test_with_items)
            .with({ param: 'param' }, options).and_return(response1)
          expect(client).to receive(:paginators_test_with_items)
            .with({ param: 'param',
                    next_token: 'foo' }, options).and_return(response2)
          expect(client).to receive(:paginators_test_with_items)
            .with({ param: 'param',
                    next_token: 'bar' }, options).and_return(response3)

          paginator = subject.items
          expect(paginator).to be_a(Enumerator)
          items = paginator.to_a
          expect(items).to eq(['a', 'b', 'c', '1', '2', '3', 'the end'])
        end
      end
    end

    describe Operation____PaginatorsTestWithBadNames do
      let(:client) { double('Client') }
      let(:params) { { param: 'param' } }
      let(:options) { { stub_responses: true } }

      subject do
        Operation____PaginatorsTestWithBadNames.new(client, params, options)
      end
      let(:response1) do
        Types::Struct____PaginatorsTestWithBadNamesOutput.new(
          member___wrapper: Types::ResultWrapper.new(
            member___123next_token: 'foo'
          ), member___items: %w[a b c]
        )
      end
      let(:response2) do
        Types::Struct____PaginatorsTestWithBadNamesOutput.new(
          member___wrapper: Types::ResultWrapper.new(
            member___123next_token: 'bar'
          ), member___items: %w[1 2 3]
        )
      end
      let(:response3) do
        Types::Struct____PaginatorsTestWithBadNamesOutput.new(
          member___items: ['the end']
        )
      end

      describe '.pages' do
        # skip, already tested with PaginatorsTest.pages
      end

      describe '#items' do
        it 'yields items from paged response data' do
          expect(client)
            .to receive(:operation____paginators_test_with_bad_names)
            .with({ param: 'param' }, options)
            .and_return(response1)
          expect(client)
            .to receive(:operation____paginators_test_with_bad_names)
            .with({ param: 'param',
                    member___next_token: 'foo' }, options)
            .and_return(response2)
          expect(client)
            .to receive(:operation____paginators_test_with_bad_names)
            .with({ param: 'param',
                    member___next_token: 'bar' }, options)
            .and_return(response3)

          paginator = subject.items
          expect(paginator).to be_a(Enumerator)
          items = paginator.to_a
          expect(items).to eq(['a', 'b', 'c', '1', '2', '3', 'the end'])
        end
      end
    end
  end
end
