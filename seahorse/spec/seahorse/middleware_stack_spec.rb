# frozen_string_literal: true

module Seahorse

  describe MiddlewareStack do
    subject { MiddlewareStack.new }
    let(:app) { double('app') }

    describe '#use' do
      it 'adds middleware and kwargs to the stack'
    end

    describe '#use_before' do
      it 'adds middleware relatively before other middleware'
    end

    describe '#use_after' do
      it 'adds middleware relatively after other middleware'
    end

    describe '#run' do
      it 'runs the middleware in reverse order'
    end
  end

end
