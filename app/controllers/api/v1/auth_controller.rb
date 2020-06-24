# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :require_login, only: %i[login auto_login]
      def login
        @user = User.find_by_email(params[:email])
        if @user.valid_password?(params[:password])
          payload = { user_id: @user.id }
          token = encode_token(payload)
          render json: { user: @user, jwt: token, message: "Welcome #{@user.email}" }
        else
          render json: { failure: 'Log in failed! Username or password invalid!' }
        end
      end

      # def user_is_authed
      #   json_response({ message: 'You are authorized' })
      # end
    end
  end
end
