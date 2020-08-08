# frozen_string_literal: true

# Controller for the contact us controller.
class ContactusController < ApplicationController

  # Contact us view method.
  def index
    puts "HELLO"
    puts params
    puts params["femail"]
    @has_email_subscribed = !params["femail"].nil?
    puts @has_email_subscribed
    render 'index'
  end
end
