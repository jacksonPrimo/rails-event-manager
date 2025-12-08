class EventController < ApplicationController
  before_action :authenticate_user

  def create
    result = ::Events::Create.new(params).call
    render json: result
  end
end
