# frozen_string_literal: true

module Hearth
  module Retry
    describe Strategy do
      subject { Strategy.new }

      it 'defines the interface' do
        expect { subject.acquire_initial_retry_token }
          .to raise_error(NotImplementedError)
        expect { subject.refresh_retry_token(nil, nil) }
          .to raise_error(NotImplementedError)
        expect { subject.record_success(nil) }
          .to raise_error(NotImplementedError)
      end
    end
  end
end
