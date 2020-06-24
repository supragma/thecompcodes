# frozen_string_literal: true

# Workflow model
class Workflow < ApplicationRecord
  belongs_to :user
  belongs_to :request
end
