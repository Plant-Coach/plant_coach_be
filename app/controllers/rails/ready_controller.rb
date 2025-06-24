class Rails::ReadyController < ApplicationController
  def up
    render json: { status: 'UP' }, status: :ok
  end
end