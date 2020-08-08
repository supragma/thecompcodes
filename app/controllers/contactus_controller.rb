# frozen_string_literal: true

# Controller for the contact us controller.
class ContactusController < ApplicationController

  # Contact us view method.
  def index
    @has_email_subscribed = !params["femail"].nil?
    render 'index'
  end
end
