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
    end
  end
end
