# frozen_string_literal: true

class Request < ApplicationRecord
  validates_presence_of :name, :description
  has_many :workflows
end
