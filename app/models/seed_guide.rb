class SeedGuide < ApplicationRecord
  validates_presence_of :germination_temp,
                        :description,
                        :sewing_depth,
                        :when_ready_for_transplant

  validates :needs_fertilization, inclusion: [true, false]
  validates :direct_seed_recommended, inclusion: [true, false]

  has_many :seed_coachings
  has_many :garden_plants, through: :seed_coachings
end
