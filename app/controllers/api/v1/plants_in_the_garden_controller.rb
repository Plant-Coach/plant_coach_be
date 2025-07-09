# CRUD for the plants the User currently has planted in their garden.
class Api::V1::PlantsInTheGardenController < ApplicationController
  def index
    plants_in_the_garden = @user.plants_in_the_garden
    render json: PlantsInTheGardenSerializer.new(plants_in_the_garden)
  end
end
