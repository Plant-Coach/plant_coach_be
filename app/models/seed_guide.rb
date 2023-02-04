class SeedGuide < ApplicationRecord
  validates_presence_of :germination_temp,
                        :growing_temp,
                        :equipment_needed,
                        :description,
                        :sewing_depth,
                        :needs_fertilization,
                        :direct_seed_recommended
  has_many :seed_coachings
  has_many :garden_plants, through: :seed_coachings
end
