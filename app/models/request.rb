# frozen_string_literal: true

class Request < ApplicationRecord
  validates_presence_of :name, :description
end
