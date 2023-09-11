module Auth
  # Custom Auth Scheme implementation
  class HTTPCustomAuthScheme < Hearth::AuthSchemes::Base
    def initialize
      super(
        scheme_id: 'smithy.ruby.tests#httpCustomAuth',
        signer: HTTPCustomAuthSigner.new,
        identity_type: HTTPCustomAuthIdentity
      )
    end
  end

  # Custom Signer implementation
  class HTTPCustomAuthSigner < Hearth::Signers::Base
    def sign(request:, identity:, properties:)
      request.headers['X-Http-Custom-Auth'] =
        "identity=#{identity.key}, property=#{properties[:property]}"
    end

    # rubocop:disable Lint/UnusedMethodArgument
    def reset(request:, properties:)
      request.headers.delete('X-Http-Custom-Auth')
    end
    # rubocop:enable Lint/UnusedMethodArgument
  end

  # Custom Identity implementation
  class HTTPCustomAuthIdentity < Hearth::Identities::Base
    def initialize(key:, **kwargs)
      super(**kwargs)
      @key = key
    end

    attr_reader :key
  end
end
