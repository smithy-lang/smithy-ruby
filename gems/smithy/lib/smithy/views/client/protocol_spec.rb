# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class ProtocolSpec < View
        PROTOCOL_TEST_TRAITS = %w[smithy.test#httpRequestTests smithy.test#httpResponseTests].freeze

        def initialize(plan)
          @plan = plan
          @model = plan.model
          @all_operation_tests =
            Model::ServiceIndex
            .new(@model)
            .operations_for(@plan.service)
            .map { |id, o| OperationTests.new(@model, id, o, vendor_code) }
            .reject(&:empty?)
          super()
        end

        attr_reader :all_operation_tests

        def module_name
          @plan.module_name
        end

        def additional_requires
          Set.new(@all_operation_tests.map(&:additional_requires).flatten)
        end

        def vendor_code
          @plan
            .welds
            .map(&:protocol_test_vendor_code)
            .reduce({}, :merge)
        end

        # @api private
        class OperationTests
          def initialize(model, id, operation, vendor_code)
            @model = model
            @id = id
            @operation = operation
            @vendor_code = vendor_code
            @request_tests = build_request_tests
            @response_tests = build_response_tests
            @error_tests = build_error_tests
          end

          attr_reader :request_tests, :response_tests, :error_tests

          def name
            Model::Shape.name(@id).underscore
          end

          def additional_requires
            @request_tests.map(&:additional_requires) + @response_tests.map(&:additional_requires)
          end

          def empty?
            request_tests.empty? && response_tests.empty? && error_tests.empty?
          end

          private

          def build_response_tests
            @operation
              .fetch('traits', {})
              .fetch('smithy.test#httpResponseTests', [])
              .select { |t| t.fetch('appliesTo', 'client') == 'client' }
              .map { |t| ResponseTest.new(@model, @operation, t, @vendor_code) }
          end

          def build_request_tests
            @operation
              .fetch('traits', {})
              .fetch('smithy.test#httpRequestTests', [])
              .select { |t| t.fetch('appliesTo', 'client') == 'client' }
              .map { |t| RequestTest.new(@model, @operation, t, @vendor_code) }
          end

          def build_error_tests
            @operation
              .fetch('errors', [])
              .map { |e| tests_for_error(e) }
              .flatten
          end

          def tests_for_error(error)
            error_shape = Model.shape(@model, error['target'])
            # NOTE: error tests do not have a appliesTo that should be checked
            error_shape
              .fetch('traits', {})
              .fetch('smithy.test#httpResponseTests', [])
              .map { |t| ErrorTest.new(@model, @operation, error['target'], t, @vendor_code) }
          end
        end

        # @api private
        class TestCase
          def initialize(model, operation, test_case, vendor_code)
            @model = model
            @operation = operation
            @test_case = test_case
            @vendor_code = vendor_code
            @input_shape = Model.shape(@model, @operation['input']['target'])
            @output_shape = Model.shape(@model, @operation['output']['target'])
          end

          def vendor_code(method)
            return [] unless @test_case['vendorParamsShape'] && @test_case['vendorParams']

            vendor_code = @vendor_code[@test_case['vendorParamsShape']]
            unless vendor_code.respond_to?(method)
              raise "Unhandled protocol test vendor code for shape: '#{@test_case['vendorParamsShape']}. '" \
                    "Please implement a class that responds to :#{method} and register it with a weld."
            end
            vendor_code.send(method, @test_case['vendorParams']).split("\n")
          end

          def [](key)
            @test_case[key]
          end

          def docstrings
            @test_case.fetch('documentation', '').split("\n")
          end

          def additional_requires
            requires = []
            if @test_case['bodyMediaType']
              requires +=
                case @test_case['bodyMediaType']
                when 'application/cbor'
                  %w[base64]
                when 'application/json'
                  %w[json]
                else
                  []
                end
            end
            requires
          end

          def skip?
            @operation
              .fetch('traits', {})
              .fetch('smithy.ruby#skipTests', [])
              .any? { |skip| skip['id'] == @test_case['id'] }
          end

          def skip_reason
            @operation
              .fetch('traits', {})
              .fetch('smithy.ruby#skipTests', [])
              .find { |skip| skip['id'] == @test_case['id'] }
              &.fetch('reason', 'skipped')
          end
        end

        # @api private
        class RequestTest < TestCase
          def params
            ShapeToHash.transform_value(@model, @test_case.fetch('params', {}), @input_shape)
          end

          def endpoint
            "https://#{@test_case.fetch('host', '127.0.0.1')}"
          end

          def body_expect
            return nil unless @test_case['body']

            case @test_case['bodyMediaType']
            when 'application/cbor'
              'expect(Smithy::CBOR.decode(request.body.read)).' \
              "to match_data(Smithy::CBOR.decode(::Base64.decode64('#{@test_case['body']}')))"
            when 'application/json'
              "expect(JSON.parse(request.body.read)).to eq(JSON.parse('#{@test_case['body']}'))"
            else
              "expect(request.body.read).to eq('#{@test_case['body']}')"
            end
          end

          def query_expect?
            @test_case['queryParams'] || @test_case['forbidQueryParams'] || @test_case['requireQueryParams']
          end

          def idempotency_token_trait?
            @input_shape
              .fetch('members', {})
              .any? { |_name, shape| shape.fetch('traits', {}).key?('smithy.api#idempotencyToken') }
          end
        end

        # @api private
        class ResponseTest < TestCase
          def params
            # Finds all required members to pass operation validation
            ShapeToHash.transform_value(@model, structure(@input_shape, {}), @input_shape)
          end

          def shape(shape, value)
            case shape['type']
            when 'structure' then structure(shape, value)
            else value
            end
          end

          def structure(shape, values)
            shape['members'].each_with_object({}) do |(member_name, member_shape), data|
              next unless required?(member_shape.fetch('traits', {}))

              target = Model.shape(@model, member_shape['target'])
              data[member_name] = shape(target, values)
            end
          end

          def required?(traits)
            traits.key?('smithy.api#required') && !traits.key?('smithy.api#clientOptional')
          end

          def stub_body
            case @test_case['bodyMediaType']
            when 'application/cbor'
              "::Base64.decode64('#{@test_case['body']}')"
            else
              "'#{@test_case['body']}'"
            end
          end

          def data_expect
            output = ShapeToHash.transform_value(@model, @test_case.fetch('params', {}), @output_shape)
            "expect(response.data.to_h).to match_data(#{output})"
          end

          def streaming_member
            @output_shape
              .fetch('members', {})
              .map { |name, member| [name, Model.shape(@model, member['target'])] }
              .find { |_name, shape| shape.fetch('traits', {}).key?('smithy.api#streaming') }
          end
        end

        # @api private
        class ErrorTest < ResponseTest
          def initialize(model, operation, error_id, test_case, vendor_code)
            super(model, operation, test_case, vendor_code)
            @error_id = error_id
            @error_shape = Model.shape(@model, error_id)
          end

          def error_name
            Model::Shape.name(@error_id)
          end

          def params
            ShapeToHash.transform_value(@model, @test_case.fetch('params', {}), @error_shape)
          end
        end
      end
    end
  end
end
