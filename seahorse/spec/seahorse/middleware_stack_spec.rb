# frozen_string_literal: true

module Seahorse
  describe MiddlewareStack do
    subject { MiddlewareStack.new }
    let(:build_middleware) { Seahorse::Middleware::Build }
    let(:builder) { double('builder') }
    let(:builder_params) { { builder: builder } }

    let(:parse_middleware) { Seahorse::Middleware::Parse }
    let(:error_parser) { double('error_parser') }
    let(:data_parser) { double('data_parser') }
    let(:parser_params) do
      { error_parser: error_parser, data_parser: data_parser }
    end

    describe '#use' do
      it 'adds middleware and kwargs to the stack' do
        subject.use(build_middleware, **builder_params)
        middleware = subject.use(parse_middleware, **parser_params)

        expect(middleware).to eq(
          [
            [build_middleware, builder_params],
            [parse_middleware, parser_params]
          ]
        )
      end
    end

    describe '#use_before' do
      context 'relative middleware exists' do
        it 'adds middleware relatively before other middleware' do
          subject.use(build_middleware, **builder_params)
          middleware = subject.use_before(
            build_middleware,
            parse_middleware,
            **parser_params
          )

          expect(middleware).to eq(
            [
              [parse_middleware, parser_params],
              [build_middleware, builder_params]
            ]
          )
        end
      end

      context 'relative middleware does not exist' do
        it 'raises with a message' do
          expect do
            subject.use_before(
              build_middleware,
              parse_middleware,
              **parser_params
            )
          end.to raise_error(ArgumentError)
        end
      end
    end

    describe '#use_after' do
      context 'relative middleware exists' do
        it 'adds middleware relatively after other middleware' do
          subject.use(build_middleware, **builder_params)
          middleware = subject.use_after(
            build_middleware,
            parse_middleware,
            **parser_params
          )

          expect(middleware).to eq(
            [
              [build_middleware, builder_params],
              [parse_middleware, parser_params]
            ]
          )
        end
      end

      context 'relative middleware does not exist' do
        it 'raises with a message' do
          expect do
            subject.use_after(
              build_middleware,
              parse_middleware,
              **parser_params
            )
          end.to raise_error(ArgumentError)
        end
      end
    end

    let(:parser) { double('parser') }
    let(:builder) { double('builder') }
    let(:input) { double('input') }
    let(:context) { double('context') }
    let(:app) { double('app') }

    describe '#run' do
      it 'runs the middleware in reverse order' do
        # subject.use(build_middleware, **builder_params)
        # subject.use(parse_middleware, **parser_params)
        #
        # expect(parse_middleware).to receive(:new).and_return(app).ordered
        # expect(build_middleware).to receive(:new).and_return(app).ordered
        # expect(app).to receive(:call)
        # expect(app).to receive(:call)
        #
        # subject.run(input: input, context: context)
      end
    end
  end
end
