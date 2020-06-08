# frozen_string_literal: true

# Api Module
module Api
  module V1
    # Index Controller
    class IndexController < ApplicationController
      def index
        render json: { message: 'Comp Code Backend' }, status: :ok
      end
    end
  end
end
