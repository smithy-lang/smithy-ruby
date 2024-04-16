# frozen_string_literal: true

module Hearth
  # Always returns the Anonymous/noAuth auth scheme.
  # Can be used to effectively disable/skip auth.
  class AnonymousAuthResolver
    def resolve(_params)
      [Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')]
    end
  end
end
