class CustomException < Exception
  attr_reader :code

  def initialize(message, error_code=500)
    super(message)
    @code = error_code
  end
end

class Base
  def initialize(params)
    @params = params
  end
end