class Api::V1::PlantGuidesController < ApplicationController
  def index
    render json: PlantGuideSerializer.all_guides(@user.plant_guides), status: :accepted
  end

  def create
    new_plant_guide = @user.plant_guides.create(plant_guide_params)
    if new_plant_guide
      render json: PlantGuideSerializer.new(new_plant_guide), status: :created
    end
  end

  def update
    plant_guide = @user.plant_guides.find_by_id(params[:id])
    if plant_guide
      plant_guide.update(plant_guide_params)
      render json: PlantGuideSerializer.new(plant_guide), status: :ok
    else
      render status: :bad_request
    end
  end

  def destroy
    plant_guide = @user.plant_guides.find_by_id(params[:id])
    if plant_guide
      plant_guide.destroy
      render json: PlantGuideSerializer.message("success"), status: :ok
    end
  end

  private
  def plant_guide_params
    params.permit(
      :plant_type,
      :direct_seed_recommended,
      :seedling_days_to_transplant,
      :days_to_maturity,
      :days_relative_to_frost_date,
      :harvest_period
    )
  end
end