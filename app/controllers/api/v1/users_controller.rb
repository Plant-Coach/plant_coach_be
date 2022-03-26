class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(user)
    elsif User.find_by(email: params[:email])
      render json: UserSerializer.error("This user already exists!!"), status: 403
    elsif params[:password] != params[:password_confirmation]
      render json: UserSerializer.error("Your passwords must match!"), status: 400
    elsif user.errors.messages[:email]
      render json: UserSerializer.error("#{params[:email]} is not a valid email address!!")
    end
  end

  private
  def user_params
    params.permit(:name, :email, :zip_code, :password, :password_confirmation)
  end
end
