# frozen_string_literal: true

module Smithy
  module Client
    module NetHTTP
      # @api private
      module Patches
        def self.apply!
          if Net::HTTPGenericRequest.method_defined?(:supply_default_content_type, false)
            Net::HTTPGenericRequest.prepend(PatchDefaultContentType)
          end
        end

        # Net::HTTP < 0.7.0 sets a default content type of
        # 'application/x-www-form-urlencoded' on requests with bodies.
        # This patch disables that behavior when a Thread local variable
        # is set. net-http 0.7.0+ removed this entirely, so the patch
        # is only applied when the method exists. Unable to remove this
        # completely due to bundled net-http versions in Ruby 3.2-3.3.
        # TODO: re-evaluate when we determine min version for smithy-ruby/v4 GA.
        # See: https://github.com/ruby/net-http/pull/207
        module PatchDefaultContentType
          def supply_default_content_type
            return if Thread.current[:net_http_skip_default_content_type]

            super
          end
        end
      end
    end
  end
end
