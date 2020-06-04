module Api
  module V1
    class IndexController < ApplicationController
      def index
        render json: {message:'Comp Code Backend'},status: :ok
      end
    end
  end
end