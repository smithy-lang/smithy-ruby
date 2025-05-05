# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Client' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      subject { Weather::Client.new(stub_responses: true) }

      it 'loads default plugins' do
        expect(Weather::Client.plugins).to include(*Smithy::Welds::Plugins.new(@plan).add_plugins.keys)
      end

      it 'responds to each operation name' do
        subject.operation_names.each do |operation_name|
          expect(subject).to respond_to(operation_name)
        end
      end

      it 'builds and sends a request when it receives a request method' do
        input = subject.send(:build_input, :get_city, { id: '1' })
        expect(subject).to receive(:build_input).with(:get_city, { city_id: '1' }).and_return(input)
        expect(input).to receive(:send_request)
        subject.get_city(city_id: '1')
      end

      # it 'passes block arguments to the request method' do
      #   input = subject.send(:build_input, :get_city, { id: '1' })
      #   expect(subject).to receive(:build_input).with(:get_city, { city_id: '1' }).and_return(input)
      #   allow(input).to receive(:send_request)
      #     .and_yield('chunk1')
      #     .and_yield('chunk2')
      #     .and_yield('chunk3')
      #   chunks = []
      #   subject.get_city(city_id: '1') do |chunk|
      #     chunks << chunk
      #   end
      #   expect(chunks).to eq(%w[chunk1 chunk2 chunk3])
      # end

      it 'can call operations' do
        subject.get_city(city_id: '1')
      end
    end
  end

  context 'documentation trait' do
    include_context 'generated client gem', 'DocumentationTrait'

    it 'generates operation and param documentation' do
      expected = <<~DOC
        Operation documentation
        @param [Hash] params
        @option params [String] :baz
          Member documentation
        @option params [String] :bar
          Shape documentation
        @option params [String] :qux
        @return [Types::Foo]
      DOC
      client_file = File.join(@plan.destination_root, 'lib', 'documentation_trait', 'client.rb')
      expect(expected).to be_in_documentation(client_file, 'DocumentationTrait::Client', 'operation')
    end
  end

  context 'examples trait' do
    include_context 'generated client gem', 'ExamplesTrait'

    it 'generates operation examples' do
      expected = <<~EXAMPLE
        @example Example
          # This is an example
          params = {
            string: "input",
            structure: {
              string: "structure"
            },
            list: [
              {
                string: "list"
              }
            ],
            map: {
              "mapKey" => {
                string: "map value"
              }
            }
          }
          options = {}
          output = client.operation(params, options)
          output.to_h #=>
          {
            string: "output",
            structure: {
              string: "structure"
            },
            list: [
              {
                string: "list"
              }
            ],
            map: {
              "mapKey" => {
                string: "map value"
              }
            }
          }
        @example Error Example
          # This is an example with errors
          params = {
            string: "bad input",
            structure: {
              string: "structure"
            },
            list: [
              {
                string: "list"
              }
            ],
            map: {
              "mapKey" => {
                string: "map value"
              }
            }
          }
          options = {}
          begin
            output = client.operation(params, options)
          rescue Smithy::Client::Errors::ServiceError => e
            puts e.class #=> Error
            puts e.data.to_h #=>
            {
              message: "This is an error"
            }
          end
      EXAMPLE
      client_file = File.join(@plan.destination_root, 'lib', 'examples_trait', 'client.rb')
      expect(expected).to be_in_documentation(client_file, 'ExamplesTrait::Client', 'operation')
    end
  end

  context 'request and response syntax examples' do
    include_context 'generated client gem', 'SyntaxExamples'

    it 'generates request and response syntax examples' do
      expected = <<~EXAMPLE
        @example Request syntax with placeholder values
          params = {
            blob: "data",
            streaming_blob: File.read("source_file"), # required
            boolean: false,
            string: "String",
            byte: 97,
            short: 1,
            integer: 1,
            long: 1,
            float: 1.0,
            double: 1.0,
            big_integer: 1,
            big_decimal: BigDecimal(1),
            timestamp: Time.now,
            document: ""null"",
            enum: "VALUE" # One of: ["VALUE"],
            int_enum: 0 # One of: [0],
            simple_list: ["String"],
            complex_list: [
              {
                member: "String"
              }
            ],
            simple_map: {
              "String" => "String"
            },
            complex_map: {
              "String" => {
                member: "String"
              }
            },
            structure: {
              member: "String"
            },
            union: {
              # One of:
              string: "String",
              structure: {
                member: "String"
              },
              simple_list: ["String"],
              simple_map: {
                "String" => "String"
              },
              complex_list: [
                {
                  member: "String"
                }
              ],
              complex_map: {
                "String" => {
                  member: "String"
                }
              }
            }
          }
          options = {}
          output = client.operation(params, options)
        @example Response structure with placeholder values
          output.to_h #=>
          {
            blob: "data",
            streaming_blob: File.read("source_file"), # required
            boolean: false,
            string: "String",
            byte: 97,
            short: 1,
            integer: 1,
            long: 1,
            float: 1.0,
            double: 1.0,
            big_integer: 1,
            big_decimal: BigDecimal(1),
            timestamp: Time.now,
            document: ""null"",
            enum: "VALUE" # One of: ["VALUE"],
            int_enum: 0 # One of: [0],
            simple_list: ["String"],
            complex_list: [
              {
                member: "String"
              }
            ],
            simple_map: {
              "String" => "String"
            },
            complex_map: {
              "String" => {
                member: "String"
              }
            },
            structure: {
              member: "String"
            },
            union: {
              # One of:
              string: "String",
              structure: {
                member: "String"
              },
              simple_list: ["String"],
              simple_map: {
                "String" => "String"
              },
              complex_list: [
                {
                  member: "String"
                }
              ],
              complex_map: {
                "String" => {
                  member: "String"
                }
              }
            }
          }
      EXAMPLE
      client_file = File.join(@plan.destination_root, 'lib', 'syntax_examples', 'client.rb')
      expect(expected).to be_in_documentation(client_file, 'SyntaxExamples::Client', 'operation')
    end

    context 'recursive shapes' do
      include_context 'generated client gem', 'Recursive'

      it 'handles recursive shapes' do
        expected = <<~EXAMPLE
          @example Request syntax with placeholder values
            params = {
              structure: {
                structure: {
                  # recursive Structure
                }
              }
            }
            options = {}
            output = client.operation(params, options)
          @example Response structure with placeholder values
            output.to_h #=>
            {
              structure: {
                structure: {
                  # recursive Structure
                }
              }
            }
        EXAMPLE
        client_file = File.join(@plan.destination_root, 'lib', 'recursive', 'client.rb')
        expect(expected).to be_in_documentation(client_file, 'Recursive::Client', 'operation')
      end
    end
  end
end
