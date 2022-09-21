class GardenPlantCoaching < ApplicationRecord
  validates_presence_of :title, :description, :days_to_remind
  has_many :garden_plant_actions
  has_many :garden_plants, through: :garden_plant_actions
end
