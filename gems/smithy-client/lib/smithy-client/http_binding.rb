# frozen_string_literal: true

module Smithy
  module Client
    # Lookup helpers for HTTP binding metadata derived from Smithy HTTP binding
    # traits.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module resolves HTTP binding routing metadata on demand
    # and caches the resolved values directly on reusable operation and
    # structure shapes:
    # - +operation[:http_operation_index]+ caches HTTP method/path/query metadata
    # - +shape[:http_request_index]+ caches request member routing metadata
    # - +shape[:http_response_index]+ caches response member routing metadata
    #
    # Payload-shaping concerns remain in the JSON/XML/CBOR codec extensions.
    # This module only caches where members travel in the HTTP message.
    # @api private
    module HttpBinding # rubocop:disable Metrics/ModuleLength
      class << self # rubocop:disable Metrics/ClassLength
        def operation_method(operation)
          operation_index(operation)[:http_method]
        end

        def operation_path(operation)
          operation_index(operation)[:http_path]
        end

        def operation_static_query(operation)
          operation_index(operation)[:http_static_query]
        end

        def header_members(shape)
          request_index(shape)[:http_header_members]
        end

        def prefix_header_members(shape)
          request_index(shape)[:http_prefix_header_members]
        end

        def query_members(shape)
          request_index(shape)[:http_query_members]
        end

        def query_name(member_shape)
          member_shape[:http_query_name] ||= member_shape.traits['smithy.api#httpQuery'] || member_shape.name
        end

        def query_params_member(shape)
          request_index(shape)[:http_query_params_member]
        end

        def label_members(shape)
          request_index(shape)[:http_label_members]
        end

        def payload_member(shape)
          request_index(shape)[:http_payload_member]
        end

        def payload_type(shape)
          request_index(shape)[:http_payload_type]
        end

        def payload_content_type(shape)
          request_index(shape)[:http_payload_content_type]
        end

        def raw_payload?(shape)
          payload_type(shape) == :raw
        end

        def union_payload?(shape)
          payload_type(shape) == :union
        end

        def special_payload?(shape)
          raw_payload?(shape) || union_payload?(shape)
        end

        def body_members(shape)
          request_index(shape)[:http_body_members]
        end

        def response_header_members(shape)
          response_index(shape)[:http_header_members]
        end

        def response_prefix_header_members(shape)
          response_index(shape)[:http_prefix_header_members]
        end

        def response_payload_member(shape)
          response_index(shape)[:http_payload_member]
        end

        def response_payload_type(shape)
          response_index(shape)[:http_payload_type]
        end

        def response_raw_payload?(shape)
          response_payload_type(shape) == :raw
        end

        def response_union_payload?(shape)
          response_payload_type(shape) == :union
        end

        def response_special_payload?(shape)
          response_raw_payload?(shape) || response_union_payload?(shape)
        end

        def response_code_member(shape)
          response_index(shape)[:http_response_code_member]
        end

        private

        def operation_index(operation)
          operation[:http_operation_index] ||= build_operation_index(operation)
        end

        def request_index(shape)
          shape[:http_request_index] ||= build_request_index(shape)
        end

        def response_index(shape)
          shape[:http_response_index] ||= build_response_index(shape)
        end

        def build_operation_index(operation)
          http = operation.traits['smithy.api#http'] || {}
          uri = http['uri'] || '/'
          path, static_query = uri.split('?', 2)

          {
            http_method: http['method'] || 'POST',
            http_path: path,
            http_static_query: static_query,
            http_response_code: http['code']
          }.freeze
        end

        def build_request_index(shape) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
          index = {
            http_header_members: [],
            http_prefix_header_members: [],
            http_query_members: [],
            http_query_params_member: nil,
            http_label_members: {},
            http_payload_member: nil,
            http_payload_type: nil,
            http_payload_content_type: nil,
            http_body_members: []
          }

          shape.members.each do |ruby_name, member|
            kind, value = request_binding(member)

            case kind
            when :header
              index[:http_header_members] << [ruby_name, member, value].freeze
            when :prefix_header
              index[:http_prefix_header_members] << [ruby_name, member, value].freeze
            when :query
              index[:http_query_members] << [ruby_name, member].freeze
            when :query_params
              index[:http_query_params_member] = [ruby_name, member].freeze
            when :label
              index[:http_label_members][member.name] = [ruby_name, member].freeze
            when :payload
              index[:http_payload_member] = [ruby_name, member].freeze
              index[:http_payload_type] = resolve_payload_type(member)
              index[:http_payload_content_type] = resolve_payload_content_type(member)
            when :body
              index[:http_body_members] << [ruby_name, member].freeze
            end
          end

          index[:http_header_members].freeze
          index[:http_prefix_header_members].freeze
          index[:http_query_members].freeze
          index[:http_label_members].freeze
          index[:http_body_members].freeze
          index.freeze
        end

        def build_response_index(shape) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          index = {
            http_header_members: [],
            http_prefix_header_members: [],
            http_payload_member: nil,
            http_payload_type: nil,
            http_response_code_member: nil
          }

          shape.members.each do |ruby_name, member|
            kind, value = response_binding(member)

            case kind
            when :header
              index[:http_header_members] << [ruby_name, member, value].freeze
            when :prefix_header
              index[:http_prefix_header_members] << [ruby_name, member, value].freeze
            when :response_code
              index[:http_response_code_member] = [ruby_name, member].freeze
            when :payload
              index[:http_payload_member] = [ruby_name, member].freeze
              index[:http_payload_type] = resolve_payload_type(member)
            end
          end

          index[:http_header_members].freeze
          index[:http_prefix_header_members].freeze
          index.freeze
        end

        def request_binding(member) # rubocop:disable Metrics/CyclomaticComplexity
          traits = member.traits
          return [:header, traits['smithy.api#httpHeader']] if traits.key?('smithy.api#httpHeader')
          return [:prefix_header, traits['smithy.api#httpPrefixHeaders']] if traits.key?('smithy.api#httpPrefixHeaders')

          if traits.key?('smithy.api#httpQuery')
            query_name(member)
            return [:query, nil]
          end

          return [:query_params, nil] if traits.key?('smithy.api#httpQueryParams')
          return [:label, nil] if traits.key?('smithy.api#httpLabel')
          return [:payload, nil] if traits.key?('smithy.api#httpPayload')
          # Leave response-code members out of the request/body fallback.
          # Staging stub generation reuses the request-side serializers against
          # output shapes, so these must not be classified as body members.
          return [:ignore, nil] if traits.key?('smithy.api#httpResponseCode')

          [:body, nil]
        end

        def response_binding(member)
          traits = member.traits
          return [:header, traits['smithy.api#httpHeader']] if traits.key?('smithy.api#httpHeader')

          return [:prefix_header, traits['smithy.api#httpPrefixHeaders']] if traits.key?('smithy.api#httpPrefixHeaders')
          return [:response_code, nil] if traits.key?('smithy.api#httpResponseCode')
          return [:payload, nil] if traits.key?('smithy.api#httpPayload')

          [:ignore, nil]
        end

        def resolve_payload_type(member_shape)
          case member_shape.target
          when Smithy::Schema::Shapes::StringShape,
               Smithy::Schema::Shapes::BlobShape,
               Smithy::Schema::Shapes::EnumShape
            :raw
          when Smithy::Schema::Shapes::UnionShape then :union
          else :default
          end
        end

        def resolve_payload_content_type(member_shape)
          payload = member_shape.target
          media_type = Schema::Extension.media_type(payload)
          return media_type if media_type

          case payload
          when Smithy::Schema::Shapes::BlobShape
            'application/octet-stream'
          when Smithy::Schema::Shapes::StringShape,
               Smithy::Schema::Shapes::EnumShape
            'text/plain'
          end
        end
      end
    end
  end
end
