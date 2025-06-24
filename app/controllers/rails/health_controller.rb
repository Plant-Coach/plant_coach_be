class Rails::HealthController < ApplicationController
  skip_before_action :authorized, only: [:show]
  def show
    render json: { status: 'UP' }, status: :ok
  end
end