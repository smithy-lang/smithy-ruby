# frozen_string_literal: true

module Hearth
  describe MiddlewareStack do
    subject { MiddlewareStack.new }
    let(:build_middleware) { Hearth::Middleware::Build }
    let(:builder) { double('builder') }
    let(:builder_params) { { builder: builder } }

    let(:parse_middleware) { Hearth::Middleware::Parse }
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

    describe '#run' do
      let(:parser) { double('parser') }
      let(:input) { double('input') }
      let(:context) { double('context') }

      it 'runs the middleware in reverse order' do
        subject.use(build_middleware, **builder_params)
        subject.use(parse_middleware, **parser_params)

        expect(parse_middleware).to receive(:new)
          .with(nil, parser_params).and_return(parser).ordered
        expect(build_middleware).to receive(:new)
          .with(parser, builder_params).and_return(builder).ordered

        expect(builder).to receive(:call) # first middleware is called
        subject.run(input: input, context: context)
      end
    end
  end
end