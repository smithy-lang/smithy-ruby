# frozen_string_literal: true

module Hearth
  module DNS
    describe HostAddress do
      it 'can be initialized' do
        HostAddress.new(
          address_type: :A,
          address: '123.123.123.123',
          hostname: 'example.com'
        )
      end
    end
  end
end
