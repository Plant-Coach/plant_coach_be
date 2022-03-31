class Api::V1::UsersController < ApplicationController
  def index
    user = User.find_by(email: params[:email])
    if !user.nil?
      render json: UserSerializer.new(user), status: 200
    else
      render json: UserSerializer.error("This user is not found!"), status: 400
    end
  end

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

  def update
    user = User.find_by(id: params[:id])
    if !user.nil?
      user.update(user_params)
      render json: UserSerializer.new(user), status: 200
    else
      render json: UserSerializer.error("User not found!!"), status: 400
    end
  end

  private
  def user_params
    params.permit(:name, :email, :zip_code, :password, :password_confirmation)
  end
end
