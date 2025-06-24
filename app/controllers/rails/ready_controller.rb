class Rails::ReadyController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    render json: { status: 'UP' }, status: :ok
  end
end