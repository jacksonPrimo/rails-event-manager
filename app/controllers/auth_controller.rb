class AuthController < ApplicationController
  def signin
    result = ::Auth::Signin.new(params).call
    render_result result
  end

  def signup
    result = ::Auth::Signup.new(params).call
    render_result result
  end
end
