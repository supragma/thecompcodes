# frozen_string_literal: true

module AuthHandler
  JWT_SECRET = Rails.application.secrets.secret_key_base

  def encode_token(payload)
    JWT.encode(payload, JWT_SECRET)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    decoded = nil
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        decoded = JWT.decode(token, JWT_SECRET, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
    decoded
  end

  def session_user
    decoded_hash = decoded_token
    if decoded_hash.nil?
      nil
    else
      user_id = decoded_hash[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!session_user
  end

  def require_login
    render json: { message: 'Invalid Credentials' }, status: :unauthorized unless logged_in?
  end
end
