class AdminController < ApplicationController
  before_action :authenticate_user
  before_action :verify_role

  def list_all_users
    result = ::Admin::ListAllUsers.new(params).call
    render json: result
  end

  private

  def verify_role
    return if params[:session_user].role == 'admin'

    raise CustomException.new('permission denied', 403)
  end
end
