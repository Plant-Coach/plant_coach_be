class Plant < ApplicationRecord
  validates_presence_of :name,
                        :plant_type,
                        :days_to_maturity,
                        :hybrid_status,
                        :days_relative_to_frost_date

  has_many :user_plants
  has_many :users, through: :user_plants
end
