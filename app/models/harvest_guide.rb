class HarvestGuide < ApplicationRecord
  validates_presence_of :harvest_period
                        
  has_many :harvest_coachings
  has_many :garden_plants, through: :harvest_coachings
end
