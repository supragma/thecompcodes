# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :require_login, only: [:create]
      before_action :set_user, only: %i[show update destroy]

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


      def reset_pw_post
        @user = User.find_by(pw_reset_post_params)
        if @user
          UserNotifierMailer.send_pw_reset_email(@user).deliver
          json_response('sent email')
        else
          json_response('invalid email')
        end
      end

      private

      def user_params
        params.permit(
          :email,
          :password
        )
      end

      def pw_reset_post_params
        params.permit(
          :email
        )
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
