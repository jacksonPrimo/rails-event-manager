class ApplicationController < ActionController::API
  include AuthHelper
  rescue_from StandardError, with: :handle_internal_error
  rescue_from ::CustomException, with: :handle_custom_exception

  def handle_internal_error(exception)
    render json: {
      error: 'Ocorreu um erro inesperado, tente novamente mais tarde',
      details: exception.message.split(' for #<').first,
      endpoint: "#{request.method} #{request.path}"
    }, status: :internal_server_error
  end

  def handle_custom_exception(exception)
    render json: { error: exception.message, details: exception.details }, status: exception.code
  end

  def authenticate_user
    token = request.headers['Authorization']&.remove('Bearer ')
    decoded_token = decode_token(token)
    user_id = decoded_token['user_id']
    user = User.find_by id: user_id
    request.params.merge!(session_user: user)
  rescue JWT::ExpiredSignature
    render json: { error: 'token expirado' }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: 'token inválido' }, status: :unauthorized
  end
end
