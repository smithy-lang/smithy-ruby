# frozen_string_literal: true

module Hearth
  describe Interceptor do
    let(:context) { double('context') }
    let(:callable) { proc { |context| context } }

    subject do
      callbacks = Interceptor.hooks.to_h { |hook| [hook, callable] }
      Interceptor.new(**callbacks)
    end

    describe '#initialize' do
      it 'validates callback' do
        expect { Interceptor.new(read_before_execution: 'invalid') }
          .to raise_error(ArgumentError, /callable with arity 1/)

        expect { Interceptor.new(read_before_execution: proc {}) }
          .to raise_error(ArgumentError, /callable with arity 1/)

        expect { Interceptor.new(read_before_execution: -> {}) }
          .to raise_error(ArgumentError, /callable with arity 1/)

        expect { Interceptor.new(read_before_execution: proc { |context| }) }
          .not_to raise_error

        expect { Interceptor.new(read_before_execution: ->(context) {}) }
          .not_to raise_error
      end

      describe 'singleton methods' do
        Interceptor.hooks.each do |hook|
          it "defines a singleton method for #{hook}" do
            expect(subject).to respond_to(hook)
          end

          it "calls the callback for #{hook}" do
            expect(callable).to receive(:call).with(context)
            subject.send(hook, context)
          end
        end
      end

      it 'ignores unknown hooks' do
        interceptor = Interceptor.new(unknown: callable)
        expect(interceptor).not_to respond_to(:unknown)
      end
    end

    describe '#callbacks' do
      it 'returns a hash of callbacks' do
        expect(subject.callbacks).to be_a(Hash)
        expect(subject.callbacks.keys).to include(*Interceptor.hooks)
      end

      it 'ignores unknown hooks' do
        interceptor = Interceptor.new(unknown: callable)
        expect(interceptor.callbacks).not_to have_key(:unknown)
      end
    end

    describe '.hooks' do
      it 'returns a complete list of hooks' do
        expect(Interceptor.hooks).to eq %i[
          read_before_execution
          modify_before_serialization
          read_before_serialization
          read_after_serialization
          modify_before_retry_loop
          read_before_attempt
          modify_before_attempt_completion
          read_after_attempt
          modify_before_signing
          read_before_signing
          read_after_signing
          modify_before_transmit
          read_before_transmit
          read_after_transmit
          modify_before_deserialization
          read_before_deserialization
          read_after_deserialization
          modify_before_completion
          read_after_execution
        ]
      end
    end
  end
end
