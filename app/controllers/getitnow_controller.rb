# frozen_string_literal: true

# Controller for the get it now service controller.
class GetitnowController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Get It Now view method.
  def index
    @submission_received = false
    render 'index'
  end

  # Get It Now post method.
  def create
    puts params
    render 'index'
  end
end
