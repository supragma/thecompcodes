# frozen_string_literal: true

# Controller for the get it now service controller.
class GetitnowController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Get It Now view method.
  def index
    render 'index'
  end

  # Get It Now post method.
  def create
    Getquote.create(json_blob: params.to_s)
    GetQuoteMailer.new_quote(params.to_s).deliver
    redirect_to contactus_url(request.parameters)
  end
end
