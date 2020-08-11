# frozen_string_literal: true

# Controller for the contact us controller.
class ContactusController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Contact us view method.
  def index
    @has_email_subscribed = !params["femail"].nil?
    @has_message_posted = !params["message"].nil?
    @has_quote_request = !params["size"].nil?
    render 'index'
  end

  # Post request for creating a message.
  def create
    msg = Message.create(name: params["name"], email: params["email"], message: params["message"])
    @has_message_posted = !params["message"].nil?
    @has_quote_request = !params["size"].nil?
    ContactusMailer.new_contact_us(msg).deliver
    render 'index'
  end
end
