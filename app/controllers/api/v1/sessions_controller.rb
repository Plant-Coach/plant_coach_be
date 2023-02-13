class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password]) # Changed from !user.nil? to just user.
      token = encode_token({ user_id: user.id})
      render json: { user: SessionsSerializer.new(user), jwt: token }, status: :created
    elsif user.nil?
      render json: SessionsSerializer.error("Your credentials are incorrect!"), status: :unauthorized
    else
      render json: SessionsSerializer.error("Your credentials are incorrect!"), status: :unauthorized
    end
  end
end
