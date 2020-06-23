# frozen_string_literal: true

class UserNotifierMailer < ApplicationMailer
  default from: 'admin@comp.codes'

  def send_pw_reset_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Password Reset For #{Rails.application.class.parent_name}')
  end
end
