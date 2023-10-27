class Api::V1::PlantGuidesController < ApplicationController
  def index
    render json: PlantGuideSerializer.all_guides(@user.plant_guides), status: :accepted
  end

  def create
    new_plant_guide = @user.plant_guides.create(plant_guide_params)
    if new_plant_guide.valid?
      render json: PlantGuideSerializer.new(new_plant_guide), status: :created
    else
      render json: PlantGuideSerializer.errors(new_plant_guide.errors.full_messages), staus: :bad_request
    end
  end

  def show
    plant_guide = @user.plant_guides.find_by_id(params[:id])
    if !plant_guide.nil?
      render json: PlantGuideSerializer.new(plant_guide)
    else
      render json: PlantGuideSerializer.error("This plant guide could not be found.")
    end
  end

  def update
    begin
      plant_guide = @user.plant_guides.find_by_id(params[:id])
      plant_guide.update!(plant_guide_params)
    rescue ActiveRecord::RecordInvalid
      render json: PlantGuideSerializer.errors(plant_guide.errors.full_messages), status: :bad_request
    else
      render json: PlantGuideSerializer.new(plant_guide), status: :ok
    end

    # if plant_guide.valid?
    #   plant_guide.update(plant_guide_params)
    #   render json: PlantGuideSerializer.new(plant_guide), status: :ok
    # else
    #   render status: :bad_request
    # end
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