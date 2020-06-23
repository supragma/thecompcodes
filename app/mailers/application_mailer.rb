# frozen_string_literal: true

# app mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'admin@comp.codes'
  layout 'mailer'
end
