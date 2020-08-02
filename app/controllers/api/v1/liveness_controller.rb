# frozen_string_literal: true

# Define the namespace for the API.
module Api
  # Define the namespace for version one.
  module V1
    # Class for liveness testing.
    class LivenessController < ApplicationController
      # Test for successful liveness.
      def success
        render json: { success: true }, status: 200
      end

      # Test for failed liveness.
      def failure
        render json: { success: false}, status: 400
      end
    end
  end
end

  
