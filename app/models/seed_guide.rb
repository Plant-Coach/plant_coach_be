class SeedGuide < ApplicationRecord
  validates_presence_of :seedling_days_to_transplant
                        
  validates :direct_seed_recommended, inclusion: [true, false]

  has_many :seed_coachings
  has_many :garden_plants, through: :seed_coachings
end
