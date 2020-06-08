# frozen_string_literal: true

# Api to response with the app status test
class StatusesController < ApplicationController
  def index
    render json: { message: 'comp code backend' }
  end
end
