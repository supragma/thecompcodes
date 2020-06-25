# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    name { Faker::Name.name }
    description { 'sometext' }
  end
end
