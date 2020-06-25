# frozen_string_literal: true

module AuthHelper
  def valid_header(user)
    jwt_secret = Rails.application.secrets.secret_key_base
    jwt_token = JWT.encode({ user_id: user.id }, jwt_secret)
    { 'Authorization' => "Bearer #{jwt_token}" }
  end
end
