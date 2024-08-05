# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @api private
  module Telemetry

    class CreateHighScore
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'HighScoreService',
          'rpc.method' => 'CreateHighScore',
          'code.function' => 'create_high_score',
          'code.namespace' => 'HighScoreService::Telemetry'
        }
        context.tracer.in_span(
          'HighScoreService.CreateHighScore',
          attributes: attributes,
          kind: Hearth::Telemetry::SpanKind::CLIENT,
          &block
        )
      end
    end

    class DeleteHighScore
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'HighScoreService',
          'rpc.method' => 'DeleteHighScore',
          'code.function' => 'delete_high_score',
          'code.namespace' => 'HighScoreService::Telemetry'
        }
        context.tracer.in_span(
          'HighScoreService.DeleteHighScore',
          attributes: attributes,
          kind: Hearth::Telemetry::SpanKind::CLIENT,
          &block
        )
      end
    end

    class GetHighScore
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'HighScoreService',
          'rpc.method' => 'GetHighScore',
          'code.function' => 'get_high_score',
          'code.namespace' => 'HighScoreService::Telemetry'
        }
        context.tracer.in_span(
          'HighScoreService.GetHighScore',
          attributes: attributes,
          kind: Hearth::Telemetry::SpanKind::CLIENT,
          &block
        )
      end
    end

    class ListHighScores
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'HighScoreService',
          'rpc.method' => 'ListHighScores',
          'code.function' => 'list_high_scores',
          'code.namespace' => 'HighScoreService::Telemetry'
        }
        context.tracer.in_span(
          'HighScoreService.ListHighScores',
          attributes: attributes,
          kind: Hearth::Telemetry::SpanKind::CLIENT,
          &block
        )
      end
    end

    class UpdateHighScore
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'HighScoreService',
          'rpc.method' => 'UpdateHighScore',
          'code.function' => 'update_high_score',
          'code.namespace' => 'HighScoreService::Telemetry'
        }
        context.tracer.in_span(
          'HighScoreService.UpdateHighScore',
          attributes: attributes,
          kind: Hearth::Telemetry::SpanKind::CLIENT,
          &block
        )
      end
    end

  end
end
