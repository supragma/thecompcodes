# frozen_string_literal: true

require 'sendgrid-ruby'

class UserNotifierMailer < ApplicationMailer
  default from: 'admin@comp.codes'

  def pass_reset_email(reset_obj)
    @reset_obj = reset_obj
    mail(
      to: @reset_obj.user.email,
      subject: 'CompCodes Password Reset',
      # from: ENV['FROM_EMAIL'],
      custom_args: {
        id: '.'
      }
    )
  end
end
