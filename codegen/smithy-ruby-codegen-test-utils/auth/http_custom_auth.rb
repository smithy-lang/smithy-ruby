# frozen_string_literal: true

module Auth
  class HTTPCustomAuthScheme < Hearth::AuthSchemes::Base
    def initialize
      super(
        scheme_id: 'smithy.ruby.tests#httpCustomAuth',
        signer: HTTPCustomAuthSigner.new,
        identity_type: HTTPCustomAuthIdentity
      )
    end
  end

  class HTTPCustomAuthSigner < Hearth::Signers::Base
    def sign(request:, identity:, properties:)
      request.headers['X-Http-Custom-Auth'] = "identity=#{identity.key}, property=#{properties[:property]}"
    end

    def reset(request:, properties:)
      request.headers.delete('X-Http-Custom-Auth')
    end
  end

  class HTTPCustomAuthIdentity < Hearth::Identities::Base
    def initialize(key:, **kwargs)
      super(**kwargs)
      @key = key
    end

    attr_reader :key
  end
end
