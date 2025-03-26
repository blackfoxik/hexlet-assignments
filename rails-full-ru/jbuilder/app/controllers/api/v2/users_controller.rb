# frozen_string_literal: true

class Api::V2::UsersController < Api::ApplicationController
  def index
    @users = User.order(created_at: :desc)
    render json: @users, each_serializer: UserSerializer
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end
end