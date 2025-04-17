class UserController < ApplicationController
  before_action :authenticate_user

  def info
    data = params[:session_user].slice(:name, :email, :created_at)
    render json: { user: data }, status: :ok
  end
end
