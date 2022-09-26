class SeedDefaultData < ApplicationRecord
  validates_presence_of :plant_type,
                        :days_to_maturity,
                        :seed_days_to_transplant,
                        :days_relative_to_frost_date,
                        :direct_seed

  enum direct_seed: [:yes, :no, :either]
end
