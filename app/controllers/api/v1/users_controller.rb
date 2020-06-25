# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :require_login, only: %i[create send_reset_token reset_password]
      before_action :set_user, only: %i[show update destroy]

      MSG = {
        'token_used' => 'The token is already used',
        'token_expired' => 'The token is expired',
        'token_invalid' => 'Invalid token',

        'password_changed' => 'password changed successfully'

      }.freeze

      def index
        # puts Rails.configuration.database_configuration['development']
        # puts Rails.application.class.parent_name
        @users = User.all
        json_response(@users, :ok)
      end

      def show
        render json: @user, serializer: SingleUserSerializer
      end

      def create
        @user = User.create(user_params)
        if @user.save
          response = { message: 'User created successfully' }
          render json: response, status: :created
        else
          render json: @user.errors, status: :bad_request
        end
      end

      def send_reset_token
        @user = User.find_by(send_reset_params)
        if @user
          @password_reset = PasswordReset.create({ user: @user })
          UserNotifierMailer.pass_reset_email(@password_reset).deliver
          json_response({ message: 'PasswordReset Link Sent' })
        else
          json_response({ message: 'Invalid Email' })
        end
      end

      def reset_password
        @password_reset = PasswordReset.find_by({ token: reset_params['token'] })
        if @password_reset
          user = @password_reset.user
          return json_response({ message: MSG['token_expired'] }) if @password_reset.token_expired?

          return json_response({ message: MSG['token_used'] }) if @password_reset.is_used

          if user.update({ password: reset_params['password'] })
            @password_reset.update({ is_used: true })
            json_response({ message: MSG['password_changed'] })
          else
            json_response({ message: 'Error' })
          end
        else
          json_response({ message: MSG['token_invalid'] })
        end
      end

      private

      def user_params
        params.permit(
          :email,
          :password
        )
      end

      def send_reset_params
        params.permit(
          :email
        )
      end

      def reset_params
        params.permit(
          :token,
          :password
        )
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
