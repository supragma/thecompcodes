# frozen_string_literal: true

class RequestSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
