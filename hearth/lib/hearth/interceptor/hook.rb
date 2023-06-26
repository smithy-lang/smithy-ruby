# frozen_string_literal: true

module Hearth
  module Interceptor
    # A module mixed into Middleware classes to provide methods
    # for calling interceptor hooks
    # @api private
    module Hook

      # if an exception is thrown AND output is not nil, the output will be modified to include the error
      # @return nil if successful, an exception otherwise
      def interceptor_hook(hook, input, context, output, aggregate_errors: false)
        ictx = context.interceptor_context(input, output)
        last_error = nil
        context.interceptors.each do |i|
          next unless i.respond_to?(hook)

          begin
            i.send(hook, ictx)
          rescue StandardError => e
            context.logger.error(e) if last_error
            last_error = e
            break unless aggregate_errors
          end
        end

        if last_error && output
          output.data = nil
          output.error = last_error
        end

        return last_error
      end
    end
  end
end
