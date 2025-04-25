class PlantGuide < ApplicationRecord
  # validates :plant_type, presence: { message: "A Plant Type must be provided." }
  # This validation does not recognize the boolean values coming from the tests and causes them to
  # erroneously fail.
  # validates :direct_seed_recommended, presence: { message: "A direct seed recommendation must be provided." }
  # validates :seedling_days_to_transplant, presence: { message: "A seedling days to transplant must be provided if direct seed recommended is false" },
  #   if: -> {
  #   direct_seed_recommended == false
  # }
  validates :plant_type, presence: { message: 'A Plant Type must be provided.' }, uniqueness: {
    scope: :user_id,
    message: lambda do |object, _data|
      "A Plant Guide for #{object.plant_type}s already exists for #{object.user.name}!"
    end
  }
  validates :days_to_maturity, presence: { message: 'Days to Maturity can not be blank.' }
  validates :days_relative_to_frost_date, presence: { message: 'Days Relative to Frost Date must not be blank.' }
  validates :harvest_period, presence: { message: 'Harvest Period must not be blank.' }
  validates :seedling_days_to_transplant,
            numericality: {
              only_integer: true,
              message: 'Seedling Days to Transplant must be a whole number.'
            }
  validates :days_to_maturity,
            numericality: {
              only_integer: true,
              message: 'Days to Maturity must be a whole number.'
            }
  validates :days_relative_to_frost_date,
            numericality: {
              only_integer: true,
              message: 'Days Relative to Frost Date must be a whole number.'
            }

  belongs_to :user
end
