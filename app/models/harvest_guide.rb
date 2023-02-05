class HarvestGuide < ApplicationRecord
  validates_presence_of :when,
                        :how,
                        :harvest_time
                        
  has_many :harvest_coachings
  has_many :garden_plants, through: :harvest_coachings
end
