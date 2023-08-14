class PlantGuide < ApplicationRecord
  validates :plant_type, presence: { message: "A Plant Type must be provided." }
  # This validation does not recognize the boolean values coming from the tests and causes them to
  # erroneously fail.
  # validates :direct_seed_recommended, presence: { message: "A direct seed recommendation must be provided." }
  validates :seedling_days_to_transplant, presence: { message: "A seedling days to transplant must be provided if direct seed recommended is false" }, if: -> {
    direct_seed_recommended == false
  }
  validates :days_to_maturity, presence: { message: "Days to Maturity can not be blank." }
  validates :days_relative_to_frost_date, presence: { message: "Days Relative to Frost Date must not be blank." }
  validates :harvest_period, presence: { message: "Harvest Period must not be blank." }

  belongs_to :user
end
