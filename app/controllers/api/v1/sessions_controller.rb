class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if !user.nil? && user.authenticate(params[:password])
      render json: SessionsSerializer.new(user), status: 200
    elsif user.nil?
      render json: SessionsSerializer.error("Your credentials are incorrect!")
    else
      render json: SessionsSerializer.error("Your credentials are incorrect!")
    end
  end
end
