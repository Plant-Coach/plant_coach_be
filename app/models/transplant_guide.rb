class TransplantGuide < ApplicationRecord
  validates_presence_of :plant_type,
                        :growth_habit,
                        :spacing,
                        :depth,
                        :recommended_tools,
                        :sun_requirements,
                        :description
                        
  has_many :transplant_coachings
  has_many :garden_plants, through: :transplant_coachings
end
