# frozen_string_literal: true

# Controller for the contact us controller.
class ContactusController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Contact us view method.
  def index
    @has_email_subscribed = !params["femail"].nil?
    render 'index'
  end

  # Post request for creating a message.
  def create
    Message.create(name: params["name"], email: params["email"], message: params["message"])
    @has_message_posted = !params["message"].nil?
    render 'index'
  end
end
