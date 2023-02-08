class SeedGuide < ApplicationRecord
  validates_presence_of :description,
                        :sewing_depth,
                        :when_ready_for_transplant,
                        :plant_type,
                        :fertilization_frequency,
                        :needs_potting_up
  validates :germination_temp, presence: true
  validates :needs_fertilization, inclusion: [true, false]
  validates :direct_seed_recommended, inclusion: [true, false]

  has_many :seed_coachings
  has_many :garden_plants, through: :seed_coachings
end
