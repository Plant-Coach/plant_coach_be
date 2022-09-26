class Api::V1::StartedIndoorSeedsController < ApplicationController
  def index
    started_indoor_seeds = @user.started_indoor_seeds
    render json: StartedIndoorSeedSerializer.new(started_indoor_seeds)
  end
end
