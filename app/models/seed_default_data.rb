class SeedDefaultData < ApplicationRecord
  validates_presence_of :plant_type,
                        :days_to_maturity,
                        :seedling_days_to_transplant,
                        :days_relative_to_frost_date
  validates :direct_seed_recommended, inclusion: [true, false], null: false
end
