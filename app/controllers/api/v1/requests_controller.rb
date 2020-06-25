# frozen_string_literal: true

module Api
  module V1
    class RequestsController < ApplicationController
      def get_object(id)
        Request.find(id)
      end

      def index
        requests = Request.all
        requests = requests.map do |request|
          { id: request.id, name: request.name, description: request.description }
        end

        json_response(requests)
      end

      def create
        request = Request.new(request_params)
        if request.save
          json_response(request, :created)
        else
          render json: request.errors, status: :unprocessable_entity
        end
      end

      def show
        @r = get_object(params[:id])
        if @r
          json_response(@r, :ok)
        else
          json_response({ message: 'Request not found' }, :not_found)
        end
      end

      def update
        @r = get_object(params[:id])
        if @r
          @r.update(request_params)
          json_response(@r, :ok)
        else
          json_response({ message: 'Request not found' }, :not_found)
        end
      end

      def destroy
        @r = get_object(params[:id])
        if @r
          @r.destroy
          json_response({ message: 'Request has been deleted' }, :ok)
        else
          json_response({ message: 'Request not found' }, :not_found)
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
