class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # This is being used similarly to a show action.
  def index
    if @user
      render json: UserSerializer.new(@user), status: :ok
    end
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token(user_id: user.id)
      session[:token] = { value: token, http_only: true }
      render json: { user: UserSerializer.new(user) }, status: :created
    elsif passwords_dont_match
      render json: UserSerializer.error("Your passwords must match!"), status: :not_acceptable
    else
      render json: UserSerializer.error(user.errors.full_messages.first), status: :not_acceptable
    end
  end

  def update
    @user.update(user_params)
    if @user.valid?
      render json: UserSerializer.new(@user), status: :ok
    else
      valid_user_record = User.find_by_id(@user.id)
      failed_update_errors = @user.errors.full_messages.first
      
      render json: UserSerializer.changes_not_saved(failed_update_errors, valid_user_record), status: :bad_request
    end
  end

  def destroy
    @user.destroy
    render status: 204
  end

  private
  def user_params
    params.permit(:name, :email, :zip_code, :password, :password_confirmation)
  end
end
