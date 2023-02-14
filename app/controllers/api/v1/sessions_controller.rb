class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password]) # Changed from !user.nil? to just user.
      token = encode_token({ user_id: user.id})
      session[:token] = { value: token, http_only: true }
      render json: { user: SessionsSerializer.new(user) }, status: :created
    elsif user.nil?
      render json: SessionsSerializer.error("Your credentials are incorrect!"), status: :unauthorized
    else
      render json: SessionsSerializer.error("Your credentials are incorrect!"), status: :unauthorized
    end
  end
end
