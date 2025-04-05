# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Paginated' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      subject { PaginatedService::Client.new(stub_responses: true, protocol: Smithy::Client::RPCv2CBOR::Protocol.new) }

      context 'vanilla' do
        include_context context, 'PaginatedService', fixture: 'paginated_trait/vanilla'

        it 'can paginate with next_page and next_page?' do
          subject.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          pages = []
          output = subject.get_foos
          pages << output
          while output.next_page?
            output = output.next_page
            pages << output
          end
          expect(pages.size).to eq 3
          expect(pages[0].foos).to eq %w[foo1 foo2]
          expect(pages[1].foos).to eq ['foo3']
          expect(pages[2].foos).to eq ['foo4']
        end

        it 'can check with next_page? and last_page?' do
          subject.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          output = subject.get_foos
          expect(output.next_page?).to be true
          expect(output.last_page?).to be false
          output = output.next_page
          expect(output.next_page?).to be true
          expect(output.last_page?).to be false
          output = output.next_page
          expect(output.next_page?).to be false
          expect(output.last_page?).to be true
        end

        it 'can paginate with each_page' do
          subject.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          pages = []
          subject.get_foos.each_page do |page|
            pages << page
          end
          expect(pages.size).to eq 3
          expect(pages[0].foos).to eq %w[foo1 foo2]
          expect(pages[1].foos).to eq ['foo3']
          expect(pages[2].foos).to eq ['foo4']
        end

        it 'handles tail style truncation' do
          subject.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: 'next_token2', foos: ['foo4'] }
          )

          pages = []
          subject.get_foos.each_page do |page|
            pages << page
          end
          expect(pages.size).to eq 3
          expect(pages[0].foos).to eq %w[foo1 foo2]
          expect(pages[1].foos).to eq ['foo3']
          expect(pages[2].foos).to eq ['foo4']
        end

        it 'can paginate with each_item' do
          subject.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          items = []
          subject.get_foos.each_item do |item|
            items << item
          end
          expect(items.size).to eq 4
          expect(items).to eq %w[foo1 foo2 foo3 foo4]
        end
      end

      context 'inheritance' do
        include_context context, 'PaginatedService', fixture: 'paginated_trait/inheritance'

        it 'allows operations to set or override properties' do
          subject.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          # items property is set on the operation
          items = []
          subject.get_foos.each_item do |item|
            items << item
          end
          expect(items.size).to eq 4
          expect(items).to eq %w[foo1 foo2 foo3 foo4]
        end
      end

      context 'member paths' do
        include_context context, 'PaginatedService', fixture: 'paginated_trait/paths'

        it 'can paginate using wrapped member paths' do
          subject.stub_responses(
            :get_foos,
            { result: { next_token: 'next_token', foos: %w[foo1 foo2] } },
            { result: { next_token: 'next_token2', foos: ['foo3'] } },
            { result: { next_token: nil, foos: ['foo4'] } }
          )

          pages = []
          subject.get_foos.each_page do |page|
            pages << page
          end
          expect(pages.size).to eq 3
          expect(pages[0].result.foos).to eq %w[foo1 foo2]
          expect(pages[1].result.foos).to eq ['foo3']
          expect(pages[2].result.foos).to eq ['foo4']
        end
      end
    end
  end
end
