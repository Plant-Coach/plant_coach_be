class GardenPlantCoaching < ApplicationRecord
  validates_presence_of :title, :description, :days_to_remind
end
