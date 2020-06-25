# frozen_string_literal: true

class PasswordReset < ApplicationRecord
  belongs_to	:user

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
    self.token_expiration = 2.days.from_now
  end

  def token_expired?
    Time.now > token_expiration
  end
end
