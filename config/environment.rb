# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: 'SuPragma',
  api_key: ENV['SENDGRID_API_KEY'],
  domain: 'comp.codes',
  address: 'smtp.sendgrid.net',
  port: 465,
  authentication: :plain,
  enable_starttls_auto: true
}
