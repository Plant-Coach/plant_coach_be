class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    # Try changing !user.nil? to just user
    if !user.nil? && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id})
      render json: { user: SessionsSerializer.new(user), jwt: token }, status: :accepted
    elsif user.nil?
      render json: SessionsSerializer.error("Your credentials are incorrect!"), status: :unauthorized
    else
      render json: SessionsSerializer.error("Your credentials are incorrect!")
    end
  end
end
