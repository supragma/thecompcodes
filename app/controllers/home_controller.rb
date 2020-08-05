# frozen_string_literal: true

# Controller for the root view.
class HomeController < ApplicationController

  # Root view method.
  def index
    render 'index'
  end
end
