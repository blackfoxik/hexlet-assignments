# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def index
    @users = User.all.order(created_at: :desc)
    respond_with @users
  end
end