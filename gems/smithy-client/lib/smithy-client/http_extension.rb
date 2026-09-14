# frozen_string_literal: true

module Smithy
  module Client
    # Cached Smithy HTTP binding metadata.
    #
    # Metadata is stored under +shape[:http]+. Operation metadata contains
    # +:method+, +:path+, +:static_query+, and +:response_code+. Structure
    # metadata contains ordered binding entries:
    # - headers and queries: +[ruby_name, member_shape, wire_name]+
    # - labels: modeled name => +[ruby_name, member_shape]+
    # - payload: +[ruby_name, member_shape, payload_type, content_type]+
    #
    # Payload content types prefer +smithy.api#mediaType+ resolved through
    # +Schema::Extension.media_type+.
    # @api private
    module HttpExtension
      KEY = :http
      EMPTY_ARRAY = [].freeze
      EMPTY_HASH = {}.freeze

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

        # Returns query bindings as:
        #   [ruby_name, member_shape, wire_name]
        #
        # Example:
        #   HttpExtension.query_members(shape)
        #   # => [[:page_size, member, 'pageSize']]
        def query_members(shape)
          fetch(shape).fetch(:query_members, EMPTY_ARRAY)
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

        private

        def operation_metadata(operation)
          http = operation.traits['smithy.api#http'] || {}
          path, static_query = (http['uri'] || '/').split('?', 2)
          { method: http['method'] || 'POST', path: path, static_query: static_query,
            response_code: http.fetch('code', 200) }.compact.freeze
        end

        # rubocop:disable-next Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        def shape_metadata(shape)
          metadata = { header_members: [], query_members: [], label_index: {}, body_members: [] }
          shape.members.each do |name, member|
            traits = member.traits
            if (header = traits['smithy.api#httpHeader'])
              metadata[:header_members] << [name, member, header].freeze
            elsif (query = traits['smithy.api#httpQuery'])
              metadata[:query_members] << [name, member, query].freeze
            elsif traits.key?('smithy.api#httpLabel')
              metadata[:label_index][member.name] = [name, member].freeze
            elsif traits.key?('smithy.api#httpPayload')
              metadata[:payload_member] = [name, member, payload_type(member), content_type(member)].freeze
            else
              metadata[:body_members] << [name, member].freeze
            end
          end
          metadata.each_value { |value| value.freeze if value.respond_to?(:freeze) }
          metadata.freeze
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
