# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe PageableResponse do
        let(:shapes) do
          {
            'smithy.ruby.tests#Example' => {
              'type' => 'service',
              'version' => '2019-06-27',
              'operations' => [
                { 'target' => 'smithy.ruby.tests#GetFoos' }
              ],
              'traits' => { 'smithy.protocols#rpcv2Cbor' => {} }
            },
            'smithy.ruby.tests#GetFoos' => {
              'type' => 'operation',
              'input' => { 'target' => 'smithy.ruby.tests#GetFoosInput' },
              'output' => { 'target' => 'smithy.ruby.tests#GetFoosOutput' },
              'traits' => {
                'smithy.api#paginated' => {
                  'inputToken' => 'nextToken',
                  'outputToken' => 'nextToken',
                  'pageSize' => 'maxResults',
                  'items' => 'foos'
                },
                'smithy.api#readonly' => {}
              }
            },
            'smithy.ruby.tests#GetFoosInput' => {
              'type' => 'structure',
              'members' => {
                'maxResults' => { 'target' => 'smithy.api#Integer' },
                'nextToken' => { 'target' => 'smithy.api#String' }
              },
              'traits' => { 'smithy.api#input' => {} }
            },
            'smithy.ruby.tests#GetFoosOutput' => {
              'type' => 'structure',
              'members' => {
                'nextToken' => { 'target' => 'smithy.api#String' },
                'foos' => { 'target' => 'smithy.ruby.tests#StringList', 'traits' => { 'smithy.api#required' => {} } }
              },
              'traits' => { 'smithy.api#output' => {} }
            },
            'smithy.ruby.tests#StringList' => {
              'type' => 'list',
              'member' => { 'target' => 'smithy.api#String' }
            }
          }
        end

        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true, endpoint: 'https://example.com') }

        context 'pagination' do
          it 'can paginate with next_page and next_page?' do
            client.stub_responses(
              :get_foos,
              { next_token: 'next_token', foos: %w[foo1 foo2] },
              { next_token: 'next_token2', foos: ['foo3'] },
              { next_token: nil, foos: ['foo4'] }
            )

            pages = []
            response = client.get_foos
            pages << response
            while response.next_page?
              response = response.next_page
              pages << response
            end
            expect(pages.size).to eq 3
            expect(pages[0].foos).to eq %w[foo1 foo2]
            expect(pages[1].foos).to eq ['foo3']
            expect(pages[2].foos).to eq ['foo4']
          end

          it 'can check with next_page? and last_page?' do
            client.stub_responses(
              :get_foos,
              { next_token: 'next_token', foos: %w[foo1 foo2] },
              { next_token: 'next_token2', foos: ['foo3'] },
              { next_token: nil, foos: ['foo4'] }
            )

            response = client.get_foos
            expect(response.next_page?).to be true
            expect(response.last_page?).to be false
            response = response.next_page
            expect(response.next_page?).to be true
            expect(response.last_page?).to be false
            response = response.next_page
            expect(response.next_page?).to be false
            expect(response.last_page?).to be true
          end

          it 'can paginate with each_page' do
            client.stub_responses(
              :get_foos,
              { next_token: 'next_token', foos: %w[foo1 foo2] },
              { next_token: 'next_token2', foos: ['foo3'] },
              { next_token: nil, foos: ['foo4'] }
            )

            pages = []
            client.get_foos.each_page do |page|
              pages << page
            end
            expect(pages.size).to eq 3
            expect(pages[0].foos).to eq %w[foo1 foo2]
            expect(pages[1].foos).to eq ['foo3']
            expect(pages[2].foos).to eq ['foo4']
          end

          it 'handles tail style truncation' do
            client.stub_responses(
              :get_foos,
              { next_token: 'next_token', foos: %w[foo1 foo2] },
              { next_token: 'next_token2', foos: ['foo3'] },
              { next_token: 'next_token2', foos: ['foo4'] }
            )

            pages = []
            client.get_foos.each_page do |page|
              pages << page
            end
            expect(pages.size).to eq 3
            expect(pages[0].foos).to eq %w[foo1 foo2]
            expect(pages[1].foos).to eq ['foo3']
            expect(pages[2].foos).to eq ['foo4']
          end

          it 'can paginate with each_item' do
            client.stub_responses(
              :get_foos,
              { next_token: 'next_token', foos: %w[foo1 foo2] },
              { next_token: 'next_token2', foos: ['foo3'] },
              { next_token: nil, foos: ['foo4'] }
            )

            items = []
            client.get_foos.each_item do |item|
              items << item
            end
            expect(items.size).to eq 4
            expect(items).to eq %w[foo1 foo2 foo3 foo4]
          end
        end

        it 'can inherit the paginated trait from the operation' do
          shapes['smithy.ruby.tests#Example']['traits']['smithy.api#paginated'] = {
            'inputToken' => 'nextToken',
            'outputToken' => 'nextToken',
            'pageSize' => 'maxResults'
          }
          shapes['smithy.ruby.tests#GetFoos']['traits'] = {
            'smithy.api#paginated' => { 'items' => 'foos' }
          }

          client.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          pages = []
          response = client.get_foos
          pages << response
          while response.next_page?
            response = response.next_page
            pages << response
          end
          expect(pages.size).to eq 3
          expect(pages[0].foos).to eq %w[foo1 foo2]
          expect(pages[1].foos).to eq ['foo3']
          expect(pages[2].foos).to eq ['foo4']
        end

        it 'can handle nested member paths' do
          shapes['smithy.ruby.tests#GetFoosOutput'] = {
            'type' => 'structure',
            'members' => {
              'result' => { 'target' => 'smithy.ruby.tests#ResultWrapper', 'traits' => { 'smithy.api#required' => {} } }
            },
            'traits' => { 'smithy.api#output' => {} }
          }
          shapes['smithy.ruby.tests#ResultWrapper'] = {
            'type' => 'structure',
            'members' => {
              'nextToken' => { 'target' => 'smithy.api#String' },
              'foos' => { 'target' => 'smithy.ruby.tests#StringList', 'traits' => { 'smithy.api#required' => {} } }
            }
          }
          shapes['smithy.ruby.tests#GetFoos']['traits']['smithy.api#paginated']['outputToken'] = 'result.nextToken'
          shapes['smithy.ruby.tests#GetFoos']['traits']['smithy.api#paginated']['items'] = 'result.foos'

          client.stub_responses(
            :get_foos,
            { result: { next_token: 'next_token', foos: %w[foo1 foo2] } },
            { result: { next_token: 'next_token2', foos: ['foo3'] } },
            { result: { next_token: nil, foos: ['foo4'] } }
          )

          pages = []
          client.get_foos.each_page do |page|
            pages << page
          end
          expect(pages.size).to eq 3
          expect(pages[0].result.foos).to eq %w[foo1 foo2]
          expect(pages[1].result.foos).to eq ['foo3']
          expect(pages[2].result.foos).to eq ['foo4']
        end

        it 'raises NotImplementedError for each_item if no items' do
          shapes['smithy.ruby.tests#GetFoos']['traits']['smithy.api#paginated'].delete('items')

          client.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          expect { client.get_foos.each_item {} } # empty
            .to raise_error NotImplementedError
        end

        it 'adds a null paginator if no paginated trait' do
          shapes['smithy.ruby.tests#GetFoos']['traits'].delete('smithy.api#paginated')

          client.stub_responses(
            :get_foos,
            { next_token: 'next_token', foos: %w[foo1 foo2] },
            { next_token: 'next_token2', foos: ['foo3'] },
            { next_token: nil, foos: ['foo4'] }
          )

          response = client.get_foos
          expect(response.paginator).to be_a(Smithy::Client::Plugins::PageableResponse::Handler::NullPaginator)
          expect(response.next_page?).to be false
          expect(response.last_page?).to be true
          expect { response.next_page }.to raise_error(LastPageError)
        end
      end
    end
  end
end
