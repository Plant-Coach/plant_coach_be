class Plant < ApplicationRecord
  validates_presence_of :name,
                        :type,
                        :latin_name,
                        :days_to_maturity,
                        :hybrid_status,
                        :organic,
                        :days_relative_to_frost_date

  has_many :user_plants
  has_many :users, through: :user_plants
end
