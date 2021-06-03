# frozen_string_literal: true

module Seahorse
  describe MiddlewareBuilder do
    let(:stack) { double('middleware stack') }
    let(:handler) { proc {} }
    let(:middleware_class) { Seahorse::Middleware::Build }

    subject { MiddlewareBuilder.new }

    def expect_middleware(builder, klass, type, handler)
      middleware = builder.to_a
      expect(middleware.size).to be 1
      middleware = middleware.first
      type_class =
        case type
        when :request then Seahorse::Middleware::RequestHandler
        when :response then Seahorse::Middleware::ResponseHandler
        when :around then Seahorse::Middleware::AroundHandler
        end
      expect(middleware[0]).to eq :use_before
      expect(middleware[1]).to eq klass
      expect(middleware[2]).to eq type_class
      expect(middleware[3]).to eq({ handler: handler })
    end

    describe '#initialize' do
      it 'appends other MiddlewareBuilder' do
        subject.before(middleware_class, handler)
        expect(MiddlewareBuilder.new(subject).to_a)
          .to include(array_including(middleware_class))
      end

      it 'raises when provided something else' do
        expect { MiddlewareBuilder.new('error') }.to raise_error(ArgumentError)
      end
    end

    describe '#apply' do
      it 'applies the middleware to the stack' do
        subject.before(middleware_class, handler)
        subject.before(middleware_class, handler)
        expect(stack).to receive(:use_before)
          .with(
            middleware_class,
            Seahorse::Middleware::RequestHandler,
            { handler: handler }
          )
        expect(stack).to receive(:use_before)
          .with(
            middleware_class,
            Seahorse::Middleware::RequestHandler,
            { handler: handler }
          )
        subject.apply(stack)
      end
    end

    describe '#before' do
      it 'adds the handler to the middleware list with a RequestHandler' do
        subject.before(middleware_class, handler)
        expect_middleware(subject, middleware_class, :request, handler)
      end

      it 'is chainable (returns self)' do
        expect(subject.before(middleware_class, handler)).to be subject
      end

      it 'accepts a block' do
        expect(Proc).to receive(:new).and_return(handler)
        subject.before(middleware_class) { {} }
        expect_middleware(subject, middleware_class, :request, handler)
      end

      it 'raises when a block and args are provided' do
        expect do
          subject.before(middleware_class, handler) { {} }
        end.to raise_error(ArgumentError)
      end

      it 'raises when no handler is provided' do
        expect do
          subject.before(middleware_class)
        end.to raise_error(ArgumentError)
      end

      it 'raises when multiple handlers are provided' do
        expect do
          subject.before(middleware_class, handler, handler)
        end.to raise_error(ArgumentError)
      end

      it 'raises when the handler is not callable' do
        expect do
          subject.before(middleware_class, double('Not Callable'))
        end.to raise_error(ArgumentError)
      end
    end

    describe '#after' do
      it 'adds the handler to the middleware list with a ResponseHandler' do
        subject.after(middleware_class, handler)
        expect_middleware(subject, middleware_class, :response, handler)
      end

      it 'is chainable (returns self)' do
        expect(subject.after(middleware_class, handler)).to be subject
      end
    end

    describe '#around' do
      it 'adds the handler to the middleware list with an AroundHandler' do
        subject.around(middleware_class, handler)
        expect_middleware(subject, middleware_class, :around, handler)
      end

      it 'is chainable (returns self)' do
        expect(subject.around(middleware_class, handler)).to be subject
      end
    end

    describe '.before' do
      it 'creates a new instance and adds the handler to the middleware list with a RequestHandler' do
        builder = MiddlewareBuilder.before(middleware_class, handler)
        expect_middleware(builder, middleware_class, :request, handler)
      end
    end

    describe '.after' do
      it 'creates a new instance and adds the handler to the middleware list with a ResponseHandler' do
        builder = MiddlewareBuilder.after(middleware_class, handler)
        expect_middleware(builder, middleware_class, :response, handler)
      end
    end

    describe '.around' do
      it 'creates a new instance and adds the handler to the middleware list with an AroundHandler' do
        builder = MiddlewareBuilder.around(middleware_class, handler)
        expect_middleware(builder, middleware_class, :around, handler)
      end
    end

    MiddlewareBuilder::STANDARD_MIDDLEWARE.each do |klass|
      simple_step_name = klass.to_s.split('::').last.downcase
      %w[before after around].each do |method|
        method_name = "#{method}_#{simple_step_name}"
        type =
          case method
          when 'before' then :request
          when 'after' then :response
          when 'around' then :around
          end

        it "defines a #{method_name} on the instance that calls #{method}" do
          expect(subject.send(method_name, handler)).to eq(subject)
          expect_middleware(subject, klass, type, handler)
        end

        it "defines a #{method_name} on the class that calls #{method}" do
          builder = MiddlewareBuilder.send(method_name, handler)
          expect_middleware(builder, klass, type, handler)
        end
      end
    end
  end
end
