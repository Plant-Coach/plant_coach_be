class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(user)
    elsif user_already_exists
      render json: UserSerializer.error("This user already exists!!"), status: 403
    elsif passwords_dont_match
      render json: UserSerializer.error("Your passwords must match!"), status: 400
    elsif email_formatted_incorrectly(user)
      render json: UserSerializer.error("#{params[:email]} is not a valid email address!!")
    end
  end

  private
  def user_params
    params.permit(:name, :email, :zip_code, :password, :password_confirmation)
  end
end
