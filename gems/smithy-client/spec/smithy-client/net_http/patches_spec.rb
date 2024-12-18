# frozen_string_literal: true

module Smithy
  module Client
    module NetHTTP
      describe Patches do
        context 'thread local variable is set' do
          before { Thread.current[:net_http_skip_default_content_type] = true }
          after { Thread.current[:net_http_skip_default_content_type] = nil }

          it 'does not supply a default content type' do
            request = Net::HTTP::Put.new('/')
            request.body = 'foo'
            request.send(:supply_default_content_type)
            expect(request['Content-Type']).to be_nil
          end
        end

        context 'thread local variable is not set' do
          it 'supplies a default content type' do
            request = Net::HTTP::Put.new('/')
            request.body = 'foo'
            request.send(:supply_default_content_type)
            expect(request['Content-Type']).to eq('application/x-www-form-urlencoded')
          end
        end
      end
    end
  end
end
