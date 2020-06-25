# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_secure_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workflows
end
