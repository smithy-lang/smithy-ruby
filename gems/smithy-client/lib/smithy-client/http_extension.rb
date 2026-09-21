# frozen_string_literal: true

module Smithy
  module Client
    # Cached Smithy HTTP binding metadata.
    #
    # Metadata is stored under +shape[:http]+. Operation metadata contains
    # +:method+, +:path+, +:static_query+, and +:response_code+. Structure
    # metadata contains ordered binding entries:
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
      KEY = :http
      EMPTY_ARRAY = [].freeze
      EMPTY_HASH = {}.freeze
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
        def fetch(shape)
          return shape[KEY] if shape.key?(KEY)

          shape[KEY] =
            if shape.is_a?(Schema::Shapes::OperationShape)
              operation_metadata(shape)
            elsif shape.respond_to?(:members)
              shape_metadata(shape)
            else
              EMPTY_HASH
            end
        end

        # Returns header bindings as:
        #   [ruby_name, member_shape, wire_name]
        #
        # Example:
        #   HttpExtension.header_members(shape)
        #   # => [[:request_id, member, 'X-Request-Id']]
        def header_members(shape)
          fetch(shape).fetch(:header_members, EMPTY_ARRAY)
        end

        # Returns the prefix-header binding as:
        #   [ruby_name, member_shape, prefix]
        #
        # Example:
        #   HttpExtension.prefix_header_member(shape)
        #   # => [:metadata, member, 'x-amz-meta-']
        def prefix_header_member(shape)
          fetch(shape)[:prefix_header_member]
        end

        # Returns query bindings as:
        #   [ruby_name, member_shape, wire_name]
        #
        # Example:
        #   HttpExtension.query_members(shape)
        #   # => [[:page_size, member, 'pageSize']]
        def query_members(shape)
          fetch(shape).fetch(:query_members, EMPTY_ARRAY)
        end

        # Returns the query-params binding as:
        #   [ruby_name, member_shape]
        #
        # Example:
        #   HttpExtension.query_params_member(shape)
        #   # => [:filters, member]
        def query_params_member(shape)
          fetch(shape)[:query_params_member]
        end

        # Returns labels indexed by modeled member name.
        #
        # Example:
        #   HttpExtension.label_index(shape)
        #   # => { 'bucket' => [:bucket, member] }
        def label_index(shape)
          fetch(shape).fetch(:label_index, EMPTY_HASH)
        end

        # Returns members serialized in the document body.
        #
        # Example:
        #   HttpExtension.body_members(shape)
        #   # => [[:name, member]]
        def body_members(shape)
          fetch(shape).fetch(:body_members, EMPTY_ARRAY)
        end

        # Returns the payload binding as:
        #   [ruby_name, member_shape, payload_type, content_type]
        #
        # Example:
        #   HttpExtension.payload_member(shape)
        #   # => [:body, member, :raw, 'application/octet-stream']
        def payload_member(shape)
          fetch(shape)[:payload_member]
        end

        # Returns the response-code binding as:
        #   [ruby_name, member_shape]
        #
        # Example:
        #   HttpExtension.response_code_member(shape)
        #   # => [:status_code, member]
        def response_code_member(shape)
          fetch(shape)[:response_code_member]
        end

        private

        def operation_metadata(operation)
          http = operation.traits['smithy.api#http'] || {}
          path, static_query = (http['uri'] || '/').split('?', 2)
          { method: http['method'] || 'POST', path: path, static_query: static_query,
            response_code: http.fetch('code', 200) }.compact.freeze
        end

        def shape_metadata(shape)
          metadata = { header_members: [], query_members: [], label_index: {}, body_members: [] }
          shape.members.each do |name, member|
            add_member_binding(metadata, name, member)
          end
          metadata.each_value { |value| value.freeze if value.respond_to?(:freeze) }
          metadata.freeze
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
          Schema::Extension.media_type(member.target) ||
            case member.target
            when Schema::Shapes::BlobShape then 'application/octet-stream'
            when Schema::Shapes::StringShape, Schema::Shapes::EnumShape then 'text/plain'
            end
        end
      end
    end
  end
end
