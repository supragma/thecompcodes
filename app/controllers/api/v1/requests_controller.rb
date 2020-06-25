# frozen_string_literal: true

module Api
  module V1
    class RequestsController < ApplicationController
      def index
        requests = Request.all
        requests = requests.map do |request|
          { id: request.id, name: request.name }
        end

        render json: [requests].to_json, status: :ok
      end

      def create
        request = Request.new(request_params)
        if request.save
          json_response(request, :created)
        else
          render json: request.errors, status: :unprocessable_entity
        end
      end

      private

      def request_params
        params.require(:request).permit(
          :name, :description
        )
      end
    end
  end
end
