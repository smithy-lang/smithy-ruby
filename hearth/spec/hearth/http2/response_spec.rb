# frozen_string_literal: true

module Hearth
  module HTTP2
    describe Response do
      subject do
        Response.new
      end

      describe '#initialize' do
        it 'initializes a sync queue' do
          expect(subject.sync_queue).to be_a(Thread::Queue)
        end
      end
    end
  end
end
