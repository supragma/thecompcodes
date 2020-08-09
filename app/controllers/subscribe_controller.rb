# frozen_string_literal: true

# Controller for the subscribe view.
class SubscribeController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Subscribeview method.
  def index
    Subscribe.create(email: params["femail"])
    redirect_to contactus_url(request.parameters)
  end
end
