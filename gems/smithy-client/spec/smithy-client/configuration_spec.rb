# frozen_string_literal: true

module Smithy
  module Client
    describe Configuration do
      subject { Configuration.new }

      describe '#add_option' do
        it 'defines a getter' do
          subject.add_option(:name)
          expect(subject.build!).to respond_to(:name)
        end

        it 'defaults the value to nil' do
          subject.add_option(:name)
          expect(subject.build!.name).to be(nil)
        end

        it 'accepts a default value' do
          subject.add_option(:name, 'John Doe')
          expect(subject.build!.name).to eq('John Doe')
        end

        it 'accepts blocks' do
          subject.add_option(:name) { 'John Doe' }
          expect(subject.build!.name).to eq('John Doe')
        end

        it 'accepts blocks with an arity of 1, yielding self' do
          subject.add_option(:name) { 'John Doe' }
          subject.add_option(:username) { |cfg| cfg.name.gsub(/\W+/, '').downcase }
          expect(subject.build!.name).to eq('John Doe')
          expect(subject.build!.username).to eq('johndoe')
        end

        it 'blocks can rely on other blocks' do
          subject.add_option(:base) { 2 }
          subject.add_option(:next) { |cfg| cfg.base * 2 }
          subject.add_option(:last) { |cfg| cfg.next * 3 }
          cfg = subject.build!
          expect(cfg.last).to eq(12)
          expect(cfg.next).to eq(4)
          expect(cfg.base).to eq(2)
        end

        it 'blocks work with supplied values' do
          subject.add_option(:base) { 2 }
          subject.add_option(:next) { |cfg| cfg.base * 2 }
          subject.add_option(:last) { |cfg| cfg.next * 3 }
          cfg = subject.build!(base: 1, next: 1)
          expect(cfg.base).to eq(1)
          expect(cfg.next).to eq(1)
          expect(cfg.last).to eq(3)
        end

        it 'replaces previous default values when called twice' do
          subject.add_option(:name, 'abc')
          subject.add_option(:name, 'xyz')
          expect(subject.build!.name).to eq('xyz')
        end

        it 'returns self so it can be chained' do
          c = subject.add_option(:name).add_option(:color)
          expect(c).to be(subject)
          expect(c.build!.members).to eq(%i[color name])
        end
      end

      describe '#build!' do
        it 'returns a Struct' do
          expect(subject.add_option(:opt).build!).to be_kind_of(Struct)
        end

        it 'accepts a hash of options' do
          subject.add_option(:size, 'default')
          subject.add_option(:color, 'default')
          cfg = subject.build!(size: 'large', color: 'red')
          expect(cfg.size).to eq('large')
          expect(cfg.color).to eq('red')
        end

        it 'raises an argument error for unknown options' do
          subject.add_option(:known)
          expect do
            subject.build!(unknown: 'option')
          end.to raise_error(ArgumentError, /invalid configuration option/)
        end

        it 'resolves nested dependent options' do
          subject.add_option(:base, 1)
          subject.add_option(:top, &:middle)
          subject.add_option(:middle, &:base)
          expect(subject.build!.top).to eq(1)
        end

        it 'resolves defaults in LIFO order until a non-nil value is found' do
          # default cost is 10
          subject.add_option(:cost) { 10 }

          # increase cost for red items
          subject.add_option(:cost) { |cfg| cfg.color == 'red' ? 9001 : nil }

          subject.add_option(:color)

          expect(subject.build!(color: 'green').cost).to eq(10)
          expect(subject.build!(color: 'red').cost).to eq(9001) # over 9000!
        end

        it 'does not resolve procs passed as args' do
          value = -> {}
          subject.add_option(:proc, value)
          expect(subject.build!.proc).to be(value)
        end

        it 'does not resolve invalid config in proc' do
          subject.add_option(:valid, &:invalid)
          expect { subject.build! }.to raise_error(NoMethodError)
        end

        it 'can check configs with respond_to? in proc' do
          subject.add_option(:valid) { |cfg| cfg.invalid if cfg.respond_to?(:invalid) }
          subject.build!
        end
      end
    end
  end
end
