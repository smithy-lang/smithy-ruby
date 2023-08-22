class AuthController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Digest::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  http_basic_authenticate_with name: 'basic', password: 'basic', realm: 'Basic Auth', only: :basic_auth
  before_action :authenticate_with_digest, only: :digest_auth
  before_action :authenticate_with_token, only: [:bearer_auth, :api_key_auth]

  def basic_auth
  end

  def digest_auth
  end

  def bearer_auth
  end

  def api_key_auth
  end

  private

    def authenticate_with_digest
      authenticate_or_request_with_http_digest('Digest Auth') { |username| 'digest' }
    end

    def authenticate_with_token
      authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(token, 'token')
      end
    end
end
