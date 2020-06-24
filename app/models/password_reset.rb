# frozen_string_literal: true

class PasswordReset < ApplicationRecord
  belongs_to	:user

  before_save :generate_token

  def generate_token
    self.token = SecureRandom.uuid
    self.token_expiration = 2.days.from_now
    puts token
    puts token_expiration
    puts self
  end
end
