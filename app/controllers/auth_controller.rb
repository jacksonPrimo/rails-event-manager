class AuthController < ApplicationController
  def signin
    result = ::Auth::Signin.new(params).call
    render json: result
  end

  def signup
    result = ::Auth::Signup.new(params).call
    render json: result
  end
end
