# frozen_string_literal: true

module Hearth
  # Interceptors are a generic extension point that allows injecting
  # logic at specific stages of execution within the SDK. Logic injection
  # is done with hooks that the interceptor implements.
  #
  # Hooks are either read-only or read/write.
  # Read-only hooks allow an interceptor to read the input,
  # transport request, transport response or output messages.
  # Read/write hooks allow an interceptor to modify one of these messages.
  #
  # To create an Interceptor, you must create a class that inherits
  # from this class and implement the hooks you want to use. Then,
  # pass an instance of your interceptor to the {InterceptorList}
  # constructor for your client. For example:
  #
  #    class MyInterceptor < Interceptor
  #      def read_before_execution(context)
  #        puts "Before execution"
  #      end
  #
  #      def read_after_execution(context)
  #        puts "After execution"
  #      end
  #    end
  #
  #    interceptors = InterceptorList.new([MyInterceptor.new])
  #    config = Organization::Config.new(interceptors: interceptors)
  #    client = Organization::Client.new(config: config)
  #    client.operation
  #    #=> "Before execution"
  #    #=> "After execution"
  #
  class Interceptor
    # A hook called at the start of an execution, before the SDK
    # does anything else.
    #
    # When: This will ALWAYS be called once per execution. The duration
    # between invocation of this hook and {#read_after_execution} is very
    # close to full duration of the execution.
    #
    # Available Information: The {InterceptorContext#input} is ALWAYS
    # available. Other information WILL NOT be available.
    #
    # Error Behavior: Errors raised by this hook will be stored
    # until all interceptors have had their {#read_before_execution}
    # invoked. Other hooks will then be skipped and execution will jump to
    # {#modify_before_completion} with the raised error as the
    # {Output#error} in {InterceptorContext#output}. If multiple
    # {#read_before_execution} methods raise errors, the latest
    # will be used and earlier ones will be logged and dropped.
    #
    # @param [InterceptorContext] context
    def read_before_execution(context)
      # Implement me
    end

    # A hook called before the input message is marshalled into a
    # transport message. This method has the ability to modify the
    # input message.
    #
    # When: This will ALWAYS be called once per execution, except when a
    # failure occurs earlier in the request pipeline.
    #
    # Available Information: The {InterceptorContext#input} is ALWAYS
    # available. This input may have been modified by earlier
    # {#modify_before_serialization} hooks, and may be modified further by
    # later hooks. Other information WILL NOT be available.
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_completion} with the raised error as the
    # {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_serialization(context)
      # Implement me
    end

    # A hook called after the input message is marshalled into a transport
    # message.
    #
    # When: This will ALWAYS be called once per execution, except when a
    # failure occurs earlier in the request pipeline. The duration
    # between invocation of this hook and {#read_after_serialization} is
    # very close to the amount of time spent marshalling the request.
    #
    # Available Information: The {InterceptorContext#input} is
    # ALWAYS available. Other information WILL NOT be available.
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_completion} with the raised error as the
    # {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_before_serialization(context)
      # Implement me
    end

    # A hook called after the input message is marshalled into a transport
    # message.
    #
    # When: This will ALWAYS be called once per execution, except when a
    # failure occurs earlier in the request pipeline. The duration
    # between invocation of this hook and {#read_before_serialization} is
    # very close to the amount of time spent marshalling the request.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request} are ALWAYS available. Other
    # information WILL NOT be available.
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_completion} with the raised error as the
    # {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_after_serialization(context)
      # Implement me
    end

    # A hook called before the retry loop is entered. This method
    # has the ability to modify the transport request message.
    #
    # When: This will ALWAYS be called once per execution, except when a
    # failure occurs earlier in the request pipeline.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. Other
    # information WILL NOT be available.
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_completion} with the raised error as the
    # {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_retry_loop(context)
      # Implement me
    end

    # A hook called before each attempt at sending the transmission
    # request message to the service.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method will be
    # called multiple times in the event of retries.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. Other
    # information WILL NOT be available. In the event of retries, the
    # {InterceptorContext} WILL include changes made in previous
    # attempts (e.g. by other interceptors).
    #
    # Error Behavior: Errors raised by this hook will be stored
    # until all interceptors have had their {#read_before_attempt}
    # invoked. Other hooks will then be skipped and execution will jump to
    # {#modify_before_attempt_completion} with the raised error as the
    # {Output#error} in {InterceptorContext#output}. If multiple
    # {#read_before_attempt} methods raise errors, the latest will be used
    # and earlier ones will be logged and dropped.
    #
    # @param [InterceptorContext] context
    def read_before_attempt(context)
      # Implement me
    end

    # A hook called before the transport request message is signed. This
    # method has the ability to modify the transport request message.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. The request may
    # have been modified by earlier {#modify_before_signing} hooks, and may
    # be modified further by later hooks. Other information WILL NOT be
    # available. In the event of retries, the {InterceptorContext} WILL
    # include changes made in previous attempts (e.g. by other middleware
    # or interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_signing(context)
      # Implement me
    end

    # A hook called after the transport request message is signed.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries. The duration between
    # invocation of this hook and {#read_after_signing} is very close to
    # the amount of time spent signing the request.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. Other
    # information WILL NOT be available. In the event of retries, the
    # {InterceptorContext} WILL include changes made in previous
    # attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_before_signing(context)
      # Implement me
    end

    # A hook called after the transport request message is signed.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries. The duration between
    # invocation of this hook and {#read_before_signing} is very close to
    # the amount of time spent signing the request.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. Other
    # information WILL NOT be available. In the event of retries, the
    # {InterceptorContext} WILL include changes made in previous
    # attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_after_signing(context)
      # Implement me
    end

    # A hook called before the transport request message is sent to the
    # service. This method has the ability to modify the transport request
    # message.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. The request may
    # have been modified by earlier {#modify_before_transmit} hooks, and
    # may be modified further by later hooks. Other information WILL NOT be
    # available. In the event of retries, the {InterceptorContext} WILL
    # include changes made in previous attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_transmit(context)
      # Implement me
    end

    # A hook called before the transport request message is sent to the
    # service.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries. The duration between
    # invocation of this hook and {#read_after_transmit} is very close to
    # the amount of time spent communicating with the service. Depending on
    # the protocol, the duration may not include the time spent reading the
    # response data.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#request} are ALWAYS available. Other
    # information WILL NOT be available. In the event of retries, the
    # {InterceptorContext} WILL include changes made in previous
    # attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_before_transmit(context)
      # Implement me
    end

    # A hook called after the transport response message is sent to the
    # service and a transport response message is received.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries. The duration between
    # invocation of this hook and {#read_before_transmit} is very close to
    # the amount of time spent communicating with the service. Depending on
    # the protocol, the duration may not include the time spent reading the
    # response data.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request}, and {InterceptorContext#response}
    # are ALWAYS available. Other information WILL NOT be available. In the
    # event of retries, the {InterceptorContext} WILL include changes
    # made in previous attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_after_transmit(context)
      # Implement me
    end

    # A hook called before the transport response message is unmarshalled.
    # This method has the ability to modify the transport response message.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request}, and {InterceptorContext#response}
    # are ALWAYS available. The response may have been modified by earlier
    # {#modify_before_deserialization} hooks, and may be modified further by
    # later hooks. Other information WILL NOT be available. In the event of
    # retries, the {InterceptorContext} WILL include changes made in
    # previous attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_deserialization(context)
      # Implement me
    end

    # A hook called after the transport response message is unmarshalled.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. This method may be
    # called multiple times in the event of retries. The duration between
    # invocation of this hook and {#read_after_deserialization} is very
    # close to the amount of time spent unmarshalling the service response.
    # Depending on the protocol and operation, the duration may include the
    # time spent downloading the response data.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request}, and {InterceptorContext#response}
    # are ALWAYS available. Other information WILL NOT be available. In the
    # event of retries, the {InterceptorContext} WILL include changes
    # made in previous attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_before_deserialization(context)
      # Implement me
    end

    # A hook called after the transport response message is unmarshalled.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs earlier in the request pipeline. The duration between
    # invocation of this hook and {#read_before_deserialization} is very
    # close to the amount of time spent unmarshalling the service response.
    # Depending on the protocol and operation, the duration may include the
    # time spent downloading the response data.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request}, {InterceptorContext#response}
    # and {InterceptorContext#output} are ALWAYS available. In the event
    # of retries, the {InterceptorContext} WILL include changes made
    # in previous attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#modify_before_attempt_completion} with the raised error as
    # the {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def read_after_deserialization(context)
      # Implement me
    end

    # A hook called when an attempt is completed. This method has the
    # ability to modify the output message or error matching
    # the currently-executing operation.
    #
    # When: This will ALWAYS be called once per attempt, except when a
    # failure occurs before {#read_before_attempt}. This method may
    # be called multiple times in the event of retries.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request}, {InterceptorContext#response} and
    # {InterceptorContext#output} are ALWAYS available. In the event
    # of retries, the {InterceptorContext} WILL include changes made
    # in previous attempts (e.g. by other interceptors).
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#read_after_attempt} with the raised error as the
    # {Output#error} in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_attempt_completion(context)
      # Implement me
    end

    # A hook called when an attempt is completed.
    #
    # When: This will ALWAYS be called once per attempt, as long as
    # {#read_before_attempt} has been executed.
    #
    # Available Information: The {InterceptorContext#input},
    # {InterceptorContext#request}, {InterceptorContext#response} and
    # {InterceptorContext#output} are ALWAYS available. The
    # {InterceptorContext#response} is available if a response
    # was received by the service for this attempt. In the event of retries,
    # the {InterceptorContext} WILL include changes made in previous
    # attempts (e.g. by other interceptors).
    #
    # Error Behavior: Errors raised by this hook will be stored
    # until all interceptors have had their {#read_after_attempt} invoked.
    # If multiple {#read_after_attempt} methods raise errors, the latest
    # will be used and earlier ones will be logged and dropped. If the retry
    # strategy determines that {Output#error} is a retryable error, execution
    # will then jump to {#read_before_attempt}. Otherwise, execution will jump
    # to {#modify_before_completion}.
    #
    # @param [InterceptorContext] context
    def read_after_attempt(context)
      # Implement me
    end

    # A hook called when an execution is completed. This method has the
    # ability to modify the output message or error matching
    # the currently-executing operation.
    #
    # When: This will ALWAYS be called once per execution.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#output} are ALWAYS available. The
    # {InterceptorContext#request} and {InterceptorContext#response}
    # are available if the execution proceeded far enough for them to be
    # generated.
    #
    # Error Behavior: If errors are raised by this hook, execution will
    # jump to {#read_after_execution} with the raised error as the
    # {Output#error) in {InterceptorContext#output}.
    #
    # @param [InterceptorContext] context
    def modify_before_completion(context)
      # Implement me
    end

    # A hook called when an execution is completed.
    #
    # When: This will ALWAYS be called once per execution. The duration
    # between invocation of this hook and {#read_before_execution} is very
    # close to the full duration of the execution.
    #
    # Available Information: The {InterceptorContext#input} and
    # {InterceptorContext#output} are ALWAYS available. The
    # {InterceptorContext#request} and {InterceptorContext#response}
    # are available if the execution proceeded far enough for them to be
    # generated.
    #
    # Error Behavior: Errors raised by this hook will be stored until all
    # interceptors have had their {#read_after_execution} invoked. The
    # error will then be treated as the {Output#error} raised by the
    # operation. If multiple {#read_after_execution} methods raise
    # errors, the latest will be used and earlier ones will be logged and
    # dropped.
    #
    # @param [InterceptorContext] context
    def read_after_execution(context)
      # Implement me
    end
  end
end
