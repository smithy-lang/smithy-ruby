# frozen_string_literal: true

module Smithy
  module Client
    # Cached Smithy HTTP binding metadata.
    #
    # Resolved values are cached as flat, HTTP-prefixed keys on their owning
    # operation or structure. Structure metadata contains ordered binding
    # entries:
    # - headers and queries: +[ruby_name, member_shape, wire_name]+
    # - prefix headers: +[ruby_name, member_shape, prefix]+
    # - query params: +[ruby_name, member_shape]+
    # - labels: modeled name => +[ruby_name, member_shape]+
    # - payload: +[ruby_name, member_shape, payload_type, content_type]+
    # - response code: +[ruby_name, member_shape]+
    #
    # Payload content types prefer +smithy.api#mediaType+ resolved through
    # +Schema::Extension.media_type+.
    # @api private
    module HttpExtension
      BINDING_WRITERS = {
        'smithy.api#httpHeader' => :add_header,
        'smithy.api#httpPrefixHeaders' => :add_prefix_header,
        'smithy.api#httpQuery' => :add_query,
        'smithy.api#httpQueryParams' => :add_query_params,
        'smithy.api#httpLabel' => :add_label,
        'smithy.api#httpPayload' => :add_payload,
        'smithy.api#httpResponseCode' => :add_response_code
      }.freeze

      class << self
        def method(operation)
          operation[:http_method] || resolve_operation(operation, :http_method)
        end

        def path(operation)
          operation[:http_path] || resolve_operation(operation, :http_path)
        end

        def static_query(operation)
          operation.fetch_metadata(:http_static_query) do
            resolve_operation(operation, :http_static_query)
          end
        end

        def response_code(operation)
          operation[:http_response_code] || resolve_operation(operation, :http_response_code)
        end

        # Returns header bindings as:
        #   [ruby_name, member_shape, wire_name]
        #
        # Example:
        #   HttpExtension.header_members(shape)
        #   # => [[:request_id, member, 'X-Request-Id']]
        def header_members(shape)
          shape[:http_header_members] || resolve_bindings(shape, :http_header_members)
        end

        # Returns the prefix-header binding as:
        #   [ruby_name, member_shape, prefix]
        #
        # Example:
        #   HttpExtension.prefix_header_member(shape)
        #   # => [:metadata, member, 'x-amz-meta-']
        def prefix_header_member(shape)
          shape.fetch_metadata(:http_prefix_header_member) do
            resolve_bindings(shape, :http_prefix_header_member)
          end
        end

        # Returns query bindings as:
        #   [ruby_name, member_shape, wire_name]
        #
        # Example:
        #   HttpExtension.query_members(shape)
        #   # => [[:page_size, member, 'pageSize']]
        def query_members(shape)
          shape[:http_query_members] || resolve_bindings(shape, :http_query_members)
        end

        # Returns the query-params binding as:
        #   [ruby_name, member_shape]
        #
        # Example:
        #   HttpExtension.query_params_member(shape)
        #   # => [:filters, member]
        def query_params_member(shape)
          shape.fetch_metadata(:http_query_params_member) do
            resolve_bindings(shape, :http_query_params_member)
          end
        end

        # Returns labels indexed by modeled member name.
        #
        # Example:
        #   HttpExtension.label_index(shape)
        #   # => { 'bucket' => [:bucket, member] }
        def label_index(shape)
          shape[:http_label_index] || resolve_bindings(shape, :http_label_index)
        end

        # Returns members serialized in the document body.
        #
        # Example:
        #   HttpExtension.body_members(shape)
        #   # => [[:name, member]]
        def body_members(shape)
          shape[:http_body_members] || resolve_bindings(shape, :http_body_members)
        end

        # Returns the payload binding as:
        #   [ruby_name, member_shape, payload_type, content_type]
        #
        # Example:
        #   HttpExtension.payload_member(shape)
        #   # => [:body, member, :raw, 'application/octet-stream']
        def payload_member(shape)
          shape.fetch_metadata(:http_payload_member) do
            resolve_bindings(shape, :http_payload_member)
          end
        end

        # Returns the response-code binding as:
        #   [ruby_name, member_shape]
        #
        # Example:
        #   HttpExtension.response_code_member(shape)
        #   # => [:status_code, member]
        def response_code_member(shape)
          shape.fetch_metadata(:http_response_code_member) do
            resolve_bindings(shape, :http_response_code_member)
          end
        end

        private

        def resolve_operation(operation, result)
          http = operation.traits['smithy.api#http'] || {}
          path, static_query = (http['uri'] || '/').split('?', 2)
          operation[:http_method] = http['method'] || 'POST'
          operation[:http_path] = path
          operation[:http_static_query] = static_query
          operation[:http_response_code] = http.fetch('code', 200)
          operation[result]
        end

        def resolve_bindings(shape, result)
          metadata = { header_members: [], query_members: [], label_index: {}, body_members: [] }
          shape.members.each do |name, member|
            add_member_binding(metadata, name, member)
          end
          metadata.each_value { |value| value.freeze if value.respond_to?(:freeze) }
          metadata.each { |key, value| shape[:"http_#{key}"] = value }
          shape[result]
        end

        def add_member_binding(metadata, name, member)
          traits = member.traits
          trait_name = BINDING_WRITERS.keys.find { |trait| traits.key?(trait) }
          return send(BINDING_WRITERS.fetch(trait_name), metadata, name, member, traits[trait_name]) if trait_name

          metadata[:body_members] << [name, member].freeze
        end

        def add_header(metadata, name, member, header)
          metadata[:header_members] << [name, member, header].freeze
        end

        def add_prefix_header(metadata, name, member, prefix)
          metadata[:prefix_header_member] = [name, member, prefix].freeze
        end

        def add_query(metadata, name, member, query)
          metadata[:query_members] << [name, member, query].freeze
        end

        def add_query_params(metadata, name, member, _trait)
          metadata[:query_params_member] = [name, member].freeze
        end

        def add_label(metadata, name, member, _trait)
          metadata[:label_index][member.name] = [name, member].freeze
        end

        def add_payload(metadata, name, member, _trait)
          metadata[:payload_member] = [name, member, payload_type(member), content_type(member)].freeze
        end

        def add_response_code(metadata, name, member, _trait)
          metadata[:response_code_member] = [name, member].freeze
        end

        def payload_type(member)
          case member.target
          when Schema::Shapes::StringShape, Schema::Shapes::BlobShape, Schema::Shapes::EnumShape then :raw
          when Schema::Shapes::UnionShape then :union
          else :default
          end
        end

        def content_type(member)
          target = member.target
          Schema::Extension.media_type(target) ||
            case target
            when Schema::Shapes::BlobShape then 'application/octet-stream'
            when Schema::Shapes::StringShape, Schema::Shapes::EnumShape then 'text/plain'
            end
        end
      end
    end
  end
end
