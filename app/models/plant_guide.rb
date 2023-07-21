class PlantGuide < ApplicationRecord
  validates_presence_of :plant_type,
                        # :direct_seed_recommended,
                        :seedling_days_to_transplant,
                        :days_to_maturity,
                        :days_relative_to_frost_date,
                        :harvest_period

  belongs_to :user
end
