module Auth
  class Signup < Base
    include AuthHelper

    def call
      already_has_user_with_this_email?
      user = create_user
      encode_token(user)
    rescue CustomException => e
      { error: e.message, code: e.code }
    rescue Exception => e
      { error: e.message, code: 500 }
    end

    def already_has_user_with_this_email?
      user = ::User.find_by_email(@params[:email])
      raise CustomException.new('email already in use', 400) if user 
    end

    def create_user
      user = User.new(sanitize_params)
      return user if user.save!
      raise ::CustomException.new("cannot register user: #{user.errors}", 400)
    end

    def sanitize_params
      @params.slice(:name, :password, :email)
    end
  end
end