class GardenPlant < ApplicationRecord
  validates_presence_of :name,
                        :plant_type,
                        :days_to_maturity,
                        :hybrid_status,
                        :days_relative_to_frost_date
  validates_inclusion_of :organic, in: [true, false]
  validates_uniqueness_of :name

  belongs_to :user

  enum hybrid_status: [:open_pollinated, :f1]
end
