# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
  	debugger
    user = User.new(user_params)
    if user.save
      render json: { id: user.id, name: user.name, email: user.email, role: user.role }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def user_params
    # Permit parameters nested under the `user` key
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
