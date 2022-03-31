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
    if user.valid?
      render json: UserSerializer.new(user), status: :created
    elsif user_already_exists
      render json: UserSerializer.error("This user already exists!!"), status: :not_acceptable
    elsif passwords_dont_match
      render json: UserSerializer.error("Your passwords must match!"), status: :not_acceptable
    elsif email_formatted_incorrectly(user)
      render json: UserSerializer.error("#{params[:email]} is not a valid email address!!"), status: :not_acceptable
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
