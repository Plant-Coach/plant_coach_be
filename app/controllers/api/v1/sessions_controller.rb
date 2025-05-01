class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: SessionsSerializer.new(user), jwt: token }, status: :created
    else
      render json: SessionsSerializer.error('Your credentials are incorrect!'), status: :unauthorized
    end
  end

  def destroy
    session.destroy
    render status: :no_content
  end
end
