class PlantingGuide < ApplicationRecord
  validates_presence_of :plant_type, :description
end
