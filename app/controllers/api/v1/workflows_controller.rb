# frozen_string_literal: true

module Api
  module V1
    class WorkflowsController < ApplicationController
      before_action :workflow, only: %i[update show destroy]
      def index
        workflows = Workflow.all
        json_response(workflows, :ok)
      end

      def create
        workflow = Workflow.new(workflow_params)
        if workflow.save
          json_response(workflow, :created)
        else
          render json: workflow.errors, status: :unprocessable_entity
        end
      end

      def show
        if @workflow
          json_response(@workflow, :ok)
        else
          json_response({ message: 'Workflow not found'}, :not_found)
        end
      end

      def update
        if @workflow
          @workflow.update(workflow_params)
          json_response(@workflow, :ok)
        else
          json_response({ message: 'Workflow not found'}, :not_found)
        end
      end

      def destroy
        if @workflow
          @workflow.destroy
          json_response({ message: 'Workflow has been deleted' }, :ok)
        else
          json_response({ message: 'Workflow not found'}, :not_found)
        end
      end

      private

      def workflow
        @workflow = Workflow.find_by(id: params[:id])
      end

      def workflow_params
        params.require(:workflow).permit(
          :user_id, :request_id, :status
        )
      end
    end
  end
end
