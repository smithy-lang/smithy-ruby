# frozen_string_literal: true

require 'pathname'

module Smithy
  module Client
    module Plugins
      # Routes successful response bodies to a file, IO object, or block.
      # Non-success response bodies stay buffered so service error payloads
      # are not written to the target.
      #
      # For a String or Pathname target, successful response headers cause the
      # SDK to open the supplied path for writing, replacing any existing
      # contents. It closes that file on completion. If an error occurs after
      # opening it, the SDK closes the file and deletes it from the supplied
      # path. Caller-provided IO objects are neither closed nor deleted.
      #
      # Blocks receive chunks immediately. Already delivered chunks cannot be
      # retracted on failure, and the wrapper owns no resources to clean up.
      # @api private
      class ResponseTarget < Plugin
        # Installs response listeners that select and clean up the target.
        class Handler < Client::Handler
          def call(context)
            target = context[:response_target]
            add_event_listeners(context.http_response, target) if target
            @handler.call(context)
          end

          private

          def add_event_listeners(response, target)
            add_header_listener(response, target)
            add_success_listener(response)
            add_error_listener(response)
          end

          def add_header_listener(response, target)
            response.on_headers(200..299) do
              # In a fresh response, the body will be a StringIO. However, when a request
              # is retried we may have an existing ManagedFile or BlockIO,
              # and those should be reused.
              response.body = io(target, response.headers) if response.body.is_a?(StringIO)
            end
          end

          def add_success_listener(response)
            response.on_success(200..299) do
              close_managed_file(response.body)
            end
          end

          def add_error_listener(response)
            response.on_error do
              discard_managed_file(response)
            end
          end

          def close_managed_file(body)
            body.close if body.is_a?(ManagedFile) && body.open?
          end

          def discard_managed_file(response)
            body = response.body
            return unless body.is_a?(ManagedFile)

            close_managed_file(body)
            File.unlink(body)
            response.body = StringIO.new
          end

          def io(target, headers)
            case target
            when Proc then BlockIO.new(headers, &target)
            when String, Pathname then ManagedFile.new(target, 'w+b')
            else target
            end
          end
        end

        handler(Handler, step: :initialize, priority: 90)
      end
    end
  end
end
