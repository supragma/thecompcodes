# frozen_string_literal: true

class WorkflowSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :request_id, :status, :request_name

  def request_name
    object.request.name
  end
end
