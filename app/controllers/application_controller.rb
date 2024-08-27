# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = decode_token(token)
    @current_user = User.find(decoded_token[:user_id]) if decoded_token
  rescue
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  private

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)[0].symbolize_keys
  end

  def encode_token(payload)
  JWT.encode(payload, Rails.application.secrets.secret_key_base)
end
end
