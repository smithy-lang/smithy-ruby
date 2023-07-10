# frozen_string_literal: true

module Hearth
  module Interceptor
    # Interceptor hooks
    # @api private
    module Hooks
      @hooks = [
        READ_BEFORE_EXECUTION = :read_before_execution,

        MODIFY_BEFORE_SERIALIZATION = :modify_before_serialization,
        READ_BEFORE_SERIALIZATION = :read_before_serialization,

        READ_BEFORE_ATTEMPT = :read_before_attempt,
        MODIFY_BEFORE_ATTEMPT_COMPLETION = :modify_before_attempt_completion,
        READ_AFTER_ATTEMPT = :read_after_attempt,

        MODIFY_BEFORE_SIGNING = :modify_before_signing,
        READ_BEFORE_SIGNING = :read_before_signing,
        READ_AFTER_SIGNING = :read_after_signing,

        MODIFY_BEFORE_TRANSMIT = :modify_before_transmit,
        READ_BEFORE_TRANSMIT = :read_before_transmit,
        READ_AFTER_TRANSMIT = :read_after_transmit,

        MODIFY_BEFORE_DESERIALIZATION = :modify_before_deserialization,
        READ_BEFORE_DESERIALIZATION = :read_before_deserialization,
        READ_AFTER_DESERIALIZATION = :read_after_deserialization,

        MODIFY_BEFORE_COMPLETION = :modify_before_completion,
        READ_AFTER_EXECUTION = :read_after_execution
      ]

      def self.implements_interceptor?(obj)
        !(obj.methods & @hooks).empty?
      end
    end
  end
end
