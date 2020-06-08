# frozen_string_literal: true

# app mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@compcode.com'
  layout 'mailer'
end
